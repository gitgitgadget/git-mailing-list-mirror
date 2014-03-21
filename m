From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/8] Import $LS_COLORS parsing code from coreutils
Date: Fri, 21 Mar 2014 18:54:45 +0700
Message-ID: <CACsJy8A2gcKHtYVO1+RfGmu8M_rUBXqDE_kS4P5wgKnWRH+HmA@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-2-git-send-email-pclouds@gmail.com> <loom.20140320T200517-726@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Tran <unsignedzero@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 12:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQy2s-0000KL-Cy
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 12:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760395AbaCULzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2014 07:55:19 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:42614 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaCULzQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 07:55:16 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so6714179qgd.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=b1P7FPx+VPaXaEea7VTmlltxr59wbyGIbENz0ex4poU=;
        b=hcFnTnFLXjiVpr1XhNSmuEUCEnaByr5PHWEKFmjTSI3BsJFSzGcFvQiPuU/qeBv6PK
         81lWqS988yALC98nW5zdm8TcwYRgUKDAX57U6p++Ieiay9kpzbngLNsn79VZkrCThmSF
         E5yC9aF0zBwqpnxgFW+aYGFW9i1EcSf/HstCAZ4Uke5ZkxClaNCEw47Z0UKUyq+V7hxg
         McMZQDKhvQZLnckqBy/CtbQMs1BtmlajRwKP/2GnSKm8S5RGJu+O2Yol2enHfPGdlycZ
         Z4vEoA8GaB/85ilftSMnTchIg9G99ZzvrRQjiqcHjm7xQsDizZdUN+ULoz/F5R+gvPLU
         +sYA==
X-Received: by 10.224.112.6 with SMTP id u6mr31854494qap.78.1395402915208;
 Fri, 21 Mar 2014 04:55:15 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 21 Mar 2014 04:54:45 -0700 (PDT)
In-Reply-To: <loom.20140320T200517-726@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244687>

On Fri, Mar 21, 2014 at 2:09 AM, David Tran <unsignedzero@gmail.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> wr=
ites:
>
>> This could could help highlight files in ls-files or status output, =
or
>> even diff --name-only (but that's questionable).
>>
>> This code is from coreutils.git commit
>> 7326d1f1a67edf21947ae98194f98c38b6e9e527 file src/ls.c. This is the
>> last GPL-2 commit before coreutils turns to GPL-3.
>>
>
> I don't know if this is something to consider but for my mac, I have =
another
> variable CLICOLOR which shows the colors if it is set. This is also t=
rue with
> FreeBSD[1] as well. I don't know if that should be checked if you're =
on those
> systems.
>
> I think it would be nice to have --color flag as well if you want to =
enable
> color output for just that one output.

My plan is stick to how git handles colors (e.g. --color and color.*
config variables). Is that enough or do you think git CLICOLOR should
override --color and color.*?

>
> [1]: https://unix.stackexchange.com/questions/2897/clicolor-and-ls-co=
lors-in-
> bash
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Duy
