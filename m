From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 6/7] git-blame.el: Doc fixes and cleanup
Date: Fri, 09 Feb 2007 12:02:59 +0100
Message-ID: <871wkzpp98.fsf@morpheus.local>
References: <87irebpwps.fsf@morpheus.local> <eqhfdv$8uq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 12:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFTXj-0007qO-Ke
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 12:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965728AbXBILDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 06:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965730AbXBILDs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 06:03:48 -0500
Received: from main.gmane.org ([80.91.229.2]:58501 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965728AbXBILDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 06:03:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFTXK-0008QS-SJ
	for git@vger.kernel.org; Fri, 09 Feb 2007 12:03:27 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:03:26 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:03:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:I/5WND64E5QKvLoUEPJ1irVLxQE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39175>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc: git@vger.kernel.org]
>
> David K?gedal wrote:
>
>> @@ -123,6 +123,7 @@
>> =C2=A0
>> =C2=A0;;;###autoload
>> =C2=A0(defun git-blame-mode (&optional arg)
>> + =C2=A0"Minor mode for displaying Git blame"
>> =C2=A0 =C2=A0(interactive "P")
>> =C2=A0 =C2=A0(if arg
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(setq git-blame-mode (eq arg 1))
>
> We should probably also change file description in header, and autolo=
ad
> instruction in Installation: section of commentary:

Agreed.

> ;;; git-blame.el --- Minor mode for displaying Git blame  -*- coding:=
 utf-8 -*-
> ;;
>
> [...]
>
> ;; If you do not want to load this package before it is necessary, yo=
u
> ;; can make use of the `autoload' feature, e.g. by adding to your .em=
acs
> ;; the following lines
> ;;
> ;;    (autoload 'git-blame-mode "git-blame"
> ;;              "Minor mode for displaying Git blame" t)
>
> (docstring is needed because INTERACTIVE is _fourth_ parameter).

Yes?  Of course you need the doc string here, since the file isn't
loaded yet.

--=20
David K=C3=A5gedal
