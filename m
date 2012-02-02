From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 2 Feb 2012 12:47:23 +0800
Message-ID: <CANYiYbFM3U=z5z-BTj3F51wjBQ4naS00jsGYKWFXUysfzVJs2Q@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
	<7vr4ye15kr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 02 05:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsoa3-0006mC-Iz
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 05:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab2BBEr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 23:47:26 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58019 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab2BBErZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 23:47:25 -0500
Received: by yhoo21 with SMTP id o21so930362yho.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 20:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=BrLHX1QYA+VnZUX18UDN6duxvjqxdejMU93xqhPZgIk=;
        b=kSzJjDD/p4CWa/JvSsa5VPXPGZn7upZq75xtrN0GAQ064fTtuRDonoS2s56BzPqzhq
         okkz7RIoB+4lOzs2KFQhhau+SUuFcdwnNk39OBTnMpgIKhRN+56V0eqChYf3RDpLNmO/
         X/Ei9wfJBrq/YPKrr8etT4FAod08GTKAJQ894=
Received: by 10.236.157.10 with SMTP id n10mr1549420yhk.41.1328158043269; Wed,
 01 Feb 2012 20:47:23 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Wed, 1 Feb 2012 20:47:23 -0800 (PST)
In-Reply-To: <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189583>

2012/2/2 Junio C Hamano <gitster@pobox.com>:
>> Git can speak Chinese now.
> ...
> I haven't decided what to do with this, though. =A0If we are going to=
 get
> tons of l10n patches[*1*], it may make sense to have a separate clone=
 of
> git.git, with possibly a maintainer other than myself, forked at v1.7=
=2E9
> and updates _only_ files in po/ hierarchy.
>
> Let me think about how to manage the l10n patches a bit.
>
It's really a problem. Nobody knowns all languages, so a seperate mail =
list
may also have troble.

Since current format-patch -> send-email -> am not suitable for l10n,
pull-request and outside seperate bug report maybe better.

=A0- One langage, one l10n team with one repo on GitHub.
=A0- Project homepage write into the header of PO file, such as:
=A0 =A0 "Language-Team: GitHub <https://github.com/gotgit/git/>\n"
=A0- Bug report not directly to this list, but use GitHub as an
alternate for example.
=A0- As to the branch management, =A0the same as Git or can be easily m=
atched.
=A0 =A0as a example: master-zh-cn <-> master, maint-zh-cn <-> maint
=A0- Pull Request send to this mailing list.

> *1* Ah, another thing, shouldn't the title be labelled as l10n instea=
d of
> i18n?

yeah. not only should I update the brief commit log, but also filename =
should
be zh_CN.po, not zh_cn.po.


--
Jiang Xin
