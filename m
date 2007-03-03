From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH] Automatically add GIT as a VC backend
Date: Sat, 03 Mar 2007 10:31:58 +0100
Message-ID: <14819.1172914318@localhost>
References: <28587.1172793178@localhost> <87zm6vvqzt.fsf@wine.dyndns.org>
Cc: Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 10:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNQdx-0002cg-QS
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 10:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXCCJew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 04:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXCCJew
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 04:34:52 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:34446 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbXCCJev (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 04:34:51 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id CD0167D18;
	Sat,  3 Mar 2007 10:34:48 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l239VwT1014820;
	Sat, 3 Mar 2007 10:31:59 +0100
In-reply-to: <87zm6vvqzt.fsf@wine.dyndns.org> 
Comments: In-reply-to Alexandre Julliard <julliard@winehq.org>
   message dated "Fri, 02 Mar 2007 12:12:22 +0100."
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41278>

Alexandre Julliard <julliard@winehq.org> wrote:

> Xavier Maillard <zedek@gnu.org> writes:
> 
> > @@ -22,18 +22,19 @@
> >  ;; This file contains a VC backend for the git version control
> >  ;; system.
> >  ;;
> > -;; To install: put this file on the load-path and add GIT to the list
> > -;; of supported backends in `vc-handled-backends'; the following line,
> > -;; placed in your ~/.emacs, will accomplish this:
> > -;;
> > -;;     (add-to-list 'vc-handled-backends 'GIT)
> > +;; To install: put this file on the load-path.
> 
> Simply putting it on the load-path is not enough to make it work,
> you'd still have to load it explicitly; it's not clear to me that this
> is better than adding it to vc-handled-backends. 

You are right.

Xavier
