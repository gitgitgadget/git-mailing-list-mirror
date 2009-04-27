From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Method invokes inefficient Number constructor;
	use static valueOf instead
Date: Mon, 27 Apr 2009 16:15:50 -0700
Message-ID: <20090427231550.GK23604@spearce.org>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lya3x-00076J-Bf
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754AbZD0XPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758233AbZD0XPv
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:15:51 -0400
Received: from george.spearce.org ([209.20.77.23]:55558 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbZD0XPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 19:15:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 932DC38215; Mon, 27 Apr 2009 23:15:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117733>

"Sohn, Matthias" <matthias.sohn@sap.com> wrote:
> Using new Integer(int) is guaranteed to always result in a new object
> whereas Integer.valueOf(int) allows caching of values
> to be done by the compiler, class library, or JVM. Using of cached
> values avoids object allocation and the code will be faster.

NAK.

This thread came up about 5 weeks ago.  Please see my reply here:

  http://thread.gmane.org/gmane.comp.version-control.git/113738/focus=113785

 
-- 
Shawn.
