From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Method invokes inefficient new String(String)
	constructor
Date: Mon, 27 Apr 2009 16:17:01 -0700
Message-ID: <20090427231701.GL23604@spearce.org>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lya4W-0007FP-FE
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbZD0XRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbZD0XRD
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:17:03 -0400
Received: from george.spearce.org ([209.20.77.23]:57577 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZD0XRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 19:17:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 634B738215; Mon, 27 Apr 2009 23:17:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117734>

"Sohn, Matthias" <matthias.sohn@sap.com> wrote:
> Using the java.lang.String(String) constructor wastes memory because the
> object so constructed will be functionally
> indistinguishable from the String passed as a parameter.  Just use the
> argument String directly.

NAK.

Like the Long.valueOf() case this came up before:

http://thread.gmane.org/gmane.comp.version-control.git/113739/focus=113787
 
-- 
Shawn.
