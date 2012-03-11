From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER
Date: Sun, 11 Mar 2012 20:27:50 +0100
Message-ID: <CACBZZX47hAF_ayaa_QBrGcOkZ9UpR0Uxm-4Hf=FB685OKKvYFw@mail.gmail.com>
References: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
 <1331382575-16936-1-git-send-email-avarab@gmail.com> <1331382575-16936-3-git-send-email-avarab@gmail.com>
 <7vfwdg16i8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 20:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6oRN-0003JB-Mj
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 20:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab2CKT2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 15:28:13 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49007 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab2CKT2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 15:28:11 -0400
Received: by eekc41 with SMTP id c41so852758eek.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=t2UPNAtPX5Ihua0ApAX96dkTu48XlnaurSGiBAOkGTA=;
        b=lVcWXnDpdoF3kxTljk0XK7vBbv0YIzHN0YIyT3KWev2Wn24TVxJeDgIK8noqIIX2TN
         6+NbH7zpcZ3S1QHl9MZM3IxKcvplOfePNHoIHfs8h1O9JqAjpmriAM7Wr2E8GETP40W2
         c+luD7Qd28CIeyoQAnp+QtGlGvxl7pkhvFSgfpZMJRsv58NH0sOovpuav7MvN5Su357L
         3janVTanQxE3hH89KeTFSsIY6C/A/VmMKrVA8FR9eO8w6sz7ZunJd7P0YgAYq+Xeszz5
         ojVkXazp7ig5rym4GAXxCU1sQImhE3RQzyvgWfwLQop4UIKvaS87PvnHlyqxoN9GRv8F
         oeEQ==
Received: by 10.14.127.76 with SMTP id c52mr1515496eei.37.1331494090329; Sun,
 11 Mar 2012 12:28:10 -0700 (PDT)
Received: by 10.213.2.147 with HTTP; Sun, 11 Mar 2012 12:27:50 -0700 (PDT)
In-Reply-To: <7vfwdg16i8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192824>

On Sat, Mar 10, 2012 at 22:38, Junio C Hamano <gitster@pobox.com> wrote=
:
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0$(RM) blib/lib/Git.pm; cp Git.pm b=
lib/lib/' >> $@
>> + =C2=A0 =C2=A0 echo ' =C2=A0$(RM) blib/lib/Git/I18N.pm; cp Git/I18N=
=2Epm blib/lib/Git/' >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0$(RM) blib/lib/Error.pm' >> $@
>> =C2=A0 =C2=A0 =C2=A0 '$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VER=
SION < 0.15009)' || \
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0cp private-Error.pm blib/lib/Error=
=2Epm' >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo install: >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0mkdir -p "$$(DESTDIR)$(instdir_SQ)=
"' >> $@
>> + =C2=A0 =C2=A0 echo ' =C2=A0mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git"=
' >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0$(RM) "$$(DESTDIR)$(instdir_SQ)/Gi=
t.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
>> + =C2=A0 =C2=A0 echo ' =C2=A0$(RM) "$$(DESTDIR)$(instdir_SQ)/Git/I18=
N.pm"; cp Git/I18N.pm "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0$(RM) "$$(DESTDIR)$(instdir_SQ)/Er=
ror.pm"' >> $@
>> =C2=A0 =C2=A0 =C2=A0 '$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VER=
SION < 0.15009)' || \
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0cp private-Error.pm "$$(DESTDIR)$(=
instdir_SQ)/Error.pm"' >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo instlibdir: >> $@
>> =C2=A0 =C2=A0 =C2=A0 echo ' =C2=A0echo $(instdir_SQ)' >> $@
>> + =C2=A0 =C2=A0 echo ' =C2=A0echo $(instdir_SQ)/Git' >> $@
>
> This break "make NO_PERL_MAKEMAKER=3DNah git-add--interactive", or
> anything that is a perl script, it appears.
>
> The resulting perl/perl.mak ends with
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0instlibdir:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo foo/Git
>
> but the top-level Makefile wants to see output from
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make instlibdir

=46ail, I just tested installing it to /tmp. Sorry about that.
