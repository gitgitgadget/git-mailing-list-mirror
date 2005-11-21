From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 21 Nov 2005 16:44:16 +0100
Message-ID: <200511211644.16789.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 16:54:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeDva-0001Y7-OW
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 16:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVKUPtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 10:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVKUPtp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 10:49:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:23697 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932328AbVKUPto (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 10:49:44 -0500
Received: (qmail invoked by alias); 21 Nov 2005 15:49:42 -0000
Received: from fauia100.informatik.uni-erlangen.de (EHLO fauia100.informatik.uni-erlangen.de) [131.188.67.100]
  by mail.gmx.net (mp025) with SMTP; 21 Nov 2005 16:49:42 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12450>

On Monday 21 November 2005 14:56, Johannes Schindelin wrote:
> With this patch, git automatically extracts the information from 
> .git/branches and .git/remotes, puts it into .git/config, and renames the 
> directories to .git/branches.old and .git/remotes.old, respectively.

Please... don't trash .git/branches.
This is about Cogito, not about Git. You will render every repository cloned
with Cogito useless, as it expects a per-branch configuration with the same
name as heads.

The part about .git/branches has to be sent to Pasky, not Junio. 

Josef
