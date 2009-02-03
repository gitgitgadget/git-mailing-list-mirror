From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Git vc-git.el versus Emacs vc-git.el versus Gits git.el
Date: Tue, 3 Feb 2009 07:53:44 -0800
Message-ID: <18824.26760.499534.315711@hungover.brentg.com>
References: <18823.47791.359047.560149@hungover.brentg.com>
	<87ab93yfjx.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Brent Goodrick <bgoodr@gmail.com>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNcM-00089J-NJ
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbZBCPxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZBCPxw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:53:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:33399 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZBCPxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:53:52 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2060178rvb.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 07:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer;
        bh=v5IK4llrVLHaLYq9CtV4tpYAuUOKQV0l1cSX1drjtB4=;
        b=uomsF5pyQT6Suq1+hOB5x91f/lSualrd3cdB7rUlvPPxElHL4XWb816hmhWrWmOteL
         fEOgdZIr/osJ+mb1P9JXCbdesOr6KlxSDLWFojwHMhgHSAjkuIIi1p3ul21xg5PD0enj
         4PjSIKvqGsfJ9GiwT/ELeIIafEoZT1uEDtT1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:cc:subject:in-reply-to:references:x-mailer;
        b=tawIuCgUksAfFSaV7aWYUc7VRwwPZ4OfxuLHn2qeXVlZPL5cTKCAju8jDpkkPjtLrz
         Ou3CVpl43bQGD30xhDFhlqpqfwOA9XPuJi+b3ohI7ffreryyEkBCJOTzdK9Mp1yNunTj
         Af2ed1EHwZu3hA8dL59nxFKEBCI4ZDTQEZi8o=
Received: by 10.141.203.7 with SMTP id f7mr2283344rvq.256.1233676430428;
        Tue, 03 Feb 2009 07:53:50 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id f42sm5698916rvb.5.2009.02.03.07.53.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 07:53:49 -0800 (PST)
In-Reply-To: <87ab93yfjx.fsf@wine.dyndns.org>
X-Mailer: VM viewmail-609 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108204>


Alexandre Julliard writes:
 > Brent Goodrick <bgoodr@gmail.com> writes:
 > 
 > > Hi,
 > >
 > > I have some questions concerning the Emacs Git integration:
 > >
 > >  1. What is the difference between git.el and vc-git.el in the
 > >     git/contrib/emacs directory?
 > 
 > vc-git.el is a backend for the Emacs VC mode, which supports the
 > standard C-x v commands. The advantage is that you can use the same
 > commands for all VCS.
 > 
 > git.el is a project-wide status manager equivalent to pcl-cvs, but
 > specialized for git. Its advantage is that by not trying to be generic
 > it can offer more git-specific functionality that isn't available with
 > VC mode.
 > 
 > They are not exclusive, you can use both at the same time, depending on
 > what operations you are doing.

Sounds reasonable. I plan on using both since they are compatible with
each other.

 > 
 > >  2. There is a vc-git.el in the Emacs top-of-trunk sources, and
 > >     another one in the git/contrib/emacs directory in the Git
 > >     sources. Which one should I use?  If I should use the one in
 > >     Emacs, then why is there one in the Git source tree?
 > 
 > The most recent one is the one in the Emacs trunk, so you should use
 > this if possible. The one in the Git tree is an older version that's no
 > longer maintained, though it can still be useful if you are running an
 > old Emacs version.

Having the git.el and the vc-git.el file in the same git sources
directory, git/contrib/emacs, fouls up standard `require' loading
practice on Emacs 23 since Emacs 23 has vc-git.el in the load-path
already.  This is the way that I have hacked around it in my Emacs 23
setup, which also explains why:

	;; We can't use (add-to-list 'load-path git-emacs-lisp-dir) here because
	;; there is an older version of vc-git.el in that same directory, and we
	;; prefer the one that comes with Emacs 23:
	(load-file (expand-file-name "git.el" git-emacs-lisp-dir))

Since the vc-git.el is old, would it be feasible/desirable to rename
git/contrib/emacs/vc-git.el to git/contrib/emacs/old/vc-git.el so as
to allow older Emacs to continue to load the older version?

I would suppose that if/when git.el is moved into the Emacs sources,
then the same renaming operation would be done for git.el, too.

Also, I could not find any section in the Git manual for git.el.
Given that it is in the contrib directory, perhaps a separate manual
file would be appropriate?

Thanks for your help!
Brent
