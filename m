From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Fri, 3 Feb 2012 09:35:56 +0800
Message-ID: <CANYiYbFfSLFQaFeedXkhQC5jVr=+szC3CL0PYv8Cg5gXdjs0Nw@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
	<7vr4ye15kr.fsf@alter.siamese.dyndns.org>
	<CACsJy8BPTuS+u8Grx0ojhdX-5+Vn6=DuojSWO0or7fJE1dbAEQ@mail.gmail.com>
	<CACBZZX5AceH+pc-teFm=PE9u14PM88GLtLnNg5ENOpNni0Tsig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt84I-0007Cy-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653Ab2BCBf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 20:35:57 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51940 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab2BCBf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 20:35:56 -0500
Received: by yhoo21 with SMTP id o21so1431878yho.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YSA/5sxciZBunf18cjhS8KFLoQsypXF1xXrNrvVeKOM=;
        b=jvfcqBYchYxSLrXvgS4kZrANlth+HhOW5IeUCWDDsv6q6KTQtVIMrRuzjal0RjNMgB
         6fktFVj0F1NX7+9ufDQNhRUfsIvpyArRnAzCIkUno6CXmYRR0bBz2WEcaC/cDXtTayGk
         gnmBiDIhTyzF4D2PE1U6Mrg4hx5wa7oH6E+fU=
Received: by 10.236.157.10 with SMTP id n10mr8193472yhk.41.1328232956243; Thu,
 02 Feb 2012 17:35:56 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Thu, 2 Feb 2012 17:35:56 -0800 (PST)
In-Reply-To: <CACBZZX5AceH+pc-teFm=PE9u14PM88GLtLnNg5ENOpNni0Tsig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189733>

2012/2/3 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
> For now we can also avoid this whole issue and just declare that
> anything that's used for interchange or permanently stored
> (git-format-patch output, reflogs, merge commit messages etc.) will b=
e
> in English.

An extreme case is: Hg translated 'hg --versoin' and broke many other s=
oftware.
=46or example, redmine had to grep hg version properly using 'LC_ALL=3D=
C
hg --version'.

I think Duy=91s patch maybe better for such cases.
http://thread.gmane.org/gmane.comp.version-control.git/189453/focus=3D1=
89509
The call of interactive_use makes translations only available for human
but not for interchange and permanently stored.

--=20
Jiang Xin
