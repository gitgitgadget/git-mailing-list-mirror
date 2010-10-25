From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 09/10] gitweb: provide a routine to display (sub)sections
Date: Mon, 25 Oct 2010 20:21:17 +0200
Message-ID: <AANLkTikjGz4LpsneTnJJfyFphUxCfOMa_haG6o9tPUEP@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1287917136-26103-10-git-send-email-giuseppe.bilotta@gmail.com> <201010251715.54531.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 20:21:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PARfz-0002kp-J7
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 20:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617Ab0JYSVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 14:21:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57837 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0JYSVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 14:21:38 -0400
Received: by yxn35 with SMTP id 35so2294200yxn.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OY/ImlSaURPiSA5KG0J370qZ5Gy+bWlJkUx+W84jb/g=;
        b=ELmbI8RYmzpkSZoAVmBPTtY+tlI1FLu8yQ87i3SGT9NbNb77trmNjfgAIJWM5ky5/0
         Z/Y94zG8rrh2u0mRtQLdx5O9oTJ2g2ykfiYGMEKXcqc/6KIhVoQ6o63dXtH5FHjFtrox
         1BSD5fMIpY/plC6H6lm+97LMF5bHiPbs6LS50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oB8xfGIdBAREErjkW0zHT4WetcMkumq1BaDZJoN604nyGWnDqehnT46/K8uUSyGK96
         zib+ujbBaC6QklDmbN0XwpzBuC51DaDqrhevizT8gQ+bOSejQWGUUnIDgtabpe4WKG24
         uXxqRUSTmHKTXtqrVmFXjIaI38bKpOMtZ675o=
Received: by 10.42.177.130 with SMTP id bi2mr5698297icb.91.1288030897321; Mon,
 25 Oct 2010 11:21:37 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Mon, 25 Oct 2010 11:21:17 -0700 (PDT)
In-Reply-To: <201010251715.54531.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159966>

2010/10/25 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:
>
> [...]
>> +# Group output by placing it in a DIV element and adding a header.
>> +# Options for start_div() can be provided by passing a hash referen=
ce as the
>> +# first parameter to the function.
>> +# Options to git_print_header_div() can be provided by passing an a=
rray
>> +# reference. This must follow the options to start_div if they are =
present.
>> +# The content can be a scalar, which is output as-is, a scalar refe=
rence, which
>> +# is output after html escaping, an IO handle passed either as *han=
dle or
>> +# *handle{IO}, or a function reference. In the latter case all foll=
owing
>> +# parameters will be taken as argument to the content function call=
=2E
>> +sub git_print_section {
>
> Very nice API. =A0Good work!

I'm glad you like it. And thank you very much for the reviews that
took me to design it properly. Shall I take this as an ack for the
series, modulo the minor suggestions for the other two patches? (Just
to know if I can include Junio in the next posting)

--=20
Giuseppe "Oblomov" Bilotta
