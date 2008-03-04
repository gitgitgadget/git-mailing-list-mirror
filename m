From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] git-pack-objects: Automatically pack annotated tags
 if object was packed
Date: Mon, 3 Mar 2008 21:49:12 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803032145480.19665@iabervon.org>
References: <20080304023607.GA16152@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNE0-0001MW-Kb
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 03:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYCDCtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 21:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYCDCtO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 21:49:14 -0500
Received: from iabervon.org ([66.92.72.58]:42375 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbYCDCtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 21:49:14 -0500
Received: (qmail 8700 invoked by uid 1000); 4 Mar 2008 02:49:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Mar 2008 02:49:12 -0000
In-Reply-To: <20080304023607.GA16152@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76018>

On Mon, 3 Mar 2008, Shawn O. Pearce wrote:

> +	if (auto_tags && nr_result)
> +		for_each_ref(add_ref_tag, NULL);

There's for_each_tag_ref() that does the path-based filter internally, in 
a possibly more efficient way, and avoids open-coding the test for whether 
this is a tag sort of ref.

Aside from that, it looks good to me.

	-Daniel
*This .sig left intentionally blank*
