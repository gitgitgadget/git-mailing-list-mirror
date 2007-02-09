From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/7] git-blame.el: Doc fixes and cleanup
Date: Fri, 09 Feb 2007 10:39:45 +0100
Organization: At home
Message-ID: <eqhfdv$8uq$1@sea.gmane.org>
References: <87irebpwps.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 10:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFSDG-0007Io-3k
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 10:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946254AbXBIJie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 04:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946259AbXBIJie
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 04:38:34 -0500
Received: from main.gmane.org ([80.91.229.2]:54732 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946254AbXBIJid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 04:38:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFSCz-0000li-B6
	for git@vger.kernel.org; Fri, 09 Feb 2007 10:38:21 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 10:38:21 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 10:38:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39170>

[Cc: git@vger.kernel.org]

David K?gedal wrote:

> @@ -123,6 +123,7 @@
> =A0
> =A0;;;###autoload
> =A0(defun git-blame-mode (&optional arg)
> + =A0"Minor mode for displaying Git blame"
> =A0 =A0(interactive "P")
> =A0 =A0(if arg
> =A0 =A0 =A0 =A0(setq git-blame-mode (eq arg 1))

We should probably also change file description in header, and autoload
instruction in Installation: section of commentary:

;;; git-blame.el --- Minor mode for displaying Git blame  -*- coding: u=
tf-8 -*-
;;

[...]

;; If you do not want to load this package before it is necessary, you
;; can make use of the `autoload' feature, e.g. by adding to your .emac=
s
;; the following lines
;;
;;    (autoload 'git-blame-mode "git-blame"
;;              "Minor mode for displaying Git blame" t)

(docstring is needed because INTERACTIVE is _fourth_ parameter).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
