From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 11:46:55 +0200
Message-ID: <CABPQNSae3MU34pRw87CNkEUBbTpE5h9UVT3cqv3iFnWs1wQ5FQ@mail.gmail.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7v7h5d2wd3.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 11:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Pag-0006uD-Qd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 11:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1IMJrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 05:47:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59903 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab1IMJrg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 05:47:36 -0400
Received: by ywb5 with SMTP id 5so282366ywb.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=YiuEvWuOt0QY2DOmAr/4S+Js+CjR2eHIJgqM6kpR340=;
        b=Qx6SBOuwVjbiU/Ll87H/+f8xfTCMLmgA3rWUH4D88DJwTIkbH7Xgn5DYLvNMtXCHnO
         cKw+bIln9aotV2kqFHrh5dvCrBxiXiQOoOfNkLYLb1pENU1sjyKbEV9qJ+6+awRBIvZj
         ZMmsrvE9GndM1DfxXdny3Wce36vGdj0yk031o=
Received: by 10.68.8.36 with SMTP id o4mr640800pba.255.1315907255045; Tue, 13
 Sep 2011 02:47:35 -0700 (PDT)
Received: by 10.68.49.41 with HTTP; Tue, 13 Sep 2011 02:46:55 -0700 (PDT)
In-Reply-To: <7v7h5d2wd3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181279>

On Tue, Sep 13, 2011 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> [Stalled]
>>
>> * po/cygwin-backslash (2011-08-05) 2 commits
>> =A0- On Cygwin support both UNIX and DOS style path-names
>> =A0- git-compat-util: add generic find_last_dir_sep that respects is=
_dir_sep
>
> Honestly I lost track of this one. How would we want to proceed on th=
is
> topic after 1.7.7?
>
> Asking help from Windows folks.

I believe Hannes pointed out that there were some work left to be done
on it ("enable backslash processing in setup.c:prefix_filename()"),
and I didn't spot a new version after that. He also pointed out that
enabling backslash processing would cause you to lose the ability to
escape special characters, but it sounds to me like this is something
that simply "comes with the territory" of supporting win32-paths in a
POSIX-ish environment, and is already the governing convention in
Cygwin. But I'm not an expert on this topic; Cygwin is not something I
usually care much about.
