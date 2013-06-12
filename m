From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 17:23:57 -0400
Message-ID: <CAPig+cRg4so7W+ddgGg7_ZnKNkoc0T8CqNQOO5a7xnjN1LYvzw@mail.gmail.com>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
	<vpqd2rrqeqg.fsf@anie.imag.fr>
	<51B8DB5E.8030707@ensimag.fr>
	<51B8DE57.9040205@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmsWT-0000Og-PA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab3FLVYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 17:24:00 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50531 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab3FLVX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 17:23:59 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so5755555lba.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lDQFhIuA6G7V4KrgusOgLa+MGAjBNg01LT0INOqjKrU=;
        b=xA7OGBsT6Z3AdgJ5ZA0GRcyzgvbFlwbvRB3TKhmMyYziaDnAYUkzXdjYuYCGCgI7Q3
         dKXNEyASCrmrgqJxCy9LZjT0LRWyLIa3vacTuVhxxyl1/ArksWjEh18eZzZ+C9RnmZ4e
         sQ5zTwlXtPf8ogvppzX+uLQpe+6o/zWV/AgvO71UsJc7+bAov3V2MI6ml5Ufmp63quqI
         MdLKfOehFqZUgUs6FRO9WHUrMBSgJ57woCSZV8XDpY09AljghOk3Wm/tcNb7cN1Ws9N5
         hnVr9IkQ509rb2PiPqBfMOzBz6HhANnIfCcUcg7WE7SM2G6B76QmXxZXesFsMyuOHyXo
         Ku7Q==
X-Received: by 10.152.6.228 with SMTP id e4mr10487285laa.61.1371072237836;
 Wed, 12 Jun 2013 14:23:57 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Wed, 12 Jun 2013 14:23:57 -0700 (PDT)
In-Reply-To: <51B8DE57.9040205@ensimag.fr>
X-Google-Sender-Auth: _FtDn9tPK6FGPn3nNYunHCa2gr4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227683>

On Wed, Jun 12, 2013 at 4:47 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Le 12/06/2013 22:34, C=E9lestin Matte a =E9crit :
>>> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>> Actually, there still is a problem: the "defined(@array)" (introduce=
d
>> with the change in [21/31]) produces a warning.
>> Benoit also seems to have problems with this patch... I'm waiting fo=
r
>> his feedback.
>>
> There is indeed a bug. In patch [21/31], at line 163, it should be
> if (!defined $cmd[0]) {
> instead of
> if (!defined @cmd) {
>
> Should I send yet another version of this series of patch?

Assuming you don't discover more problems, for such a small change in
a lengthy patch series, it might make sense to send a simple "fixup!"
[*1*] patch and ask if Junio would be willing to squash it into v5.

[*1*]: see fixup! in git/Documentation/git-rebase.txt
