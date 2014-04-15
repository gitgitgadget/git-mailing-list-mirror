From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: wrong handling of text git attribute leading to files incorrectly
 reported as modified
Date: Tue, 15 Apr 2014 16:12:50 -0400
Message-ID: <CANUGeEYoS+t57jfpEoZE-2u_cD1uOD5pdp=yF--Rhpb9z91qxQ@mail.gmail.com>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
 <534852D4.5070608@web.de> <D552B854-59FB-406A-8CDE-3A1269CD0F6E@ammeter.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Frank Ammeter <git@ammeter.ch>
X-From: git-owner@vger.kernel.org Tue Apr 15 22:13:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa9jL-00041U-MI
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 22:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbaDOUNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2014 16:13:14 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56338 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbaDOUNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2014 16:13:12 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so389903wib.5
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mm6J4833D5flPjPezR1IedyI14tqdSRqEIiKuxOCJQg=;
        b=uBI7gJHIeEtVf9OUeMC8Nq6AKoKHTcgALx6iXjvpkfiHJobLsiL8cG8dt8/wCZB/ip
         ZVSZn+usY5tOvgV367iBVCQJ7JL1oRdoKTHTnjIZv2hFLSSyql29Kk6WLbYGSEF5bHZU
         vzomJ90D1uWEW1wDV5zx+8mfR5IMYx6aCp9VuBOlIfY1fs2hcPBjb8JnvKfZga9zWctd
         K7cI8mrnVEALhUR7N8L6iyJeJv/dsv11Yi4DDn5wZ7ZkTyoGK9zYDrLkmyIr3G6TRNtG
         WgjNSdWS//AyGmtQw6pGgwmqXXiosqjiYJZZMJv6DaYqGb2NqpdT2qHpnR5brDlm4eyb
         kC5A==
X-Received: by 10.180.94.102 with SMTP id db6mr4170245wib.12.1397592790591;
 Tue, 15 Apr 2014 13:13:10 -0700 (PDT)
Received: by 10.217.120.8 with HTTP; Tue, 15 Apr 2014 13:12:50 -0700 (PDT)
In-Reply-To: <D552B854-59FB-406A-8CDE-3A1269CD0F6E@ammeter.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246296>

=46rank:

On Sat, Apr 12, 2014 at 7:29 AM, Frank Ammeter <git@ammeter.ch> wrote:
> I don=E2=80=99t see that argument.
> I don=E2=80=99t know why at the time of a commit git should read unst=
aged files from my working tree - that affect my commit.

=2Egitignore works the exact same way. If you modify .gitignore then gi=
t
status will immediately reflect those changes. You don't even have to
store either file in the repository (.gitignore or .gitattributes).
That is for your benefit, and for easily sharing that configuration
with collaborators. Git only cares that the file exists in your
working tree at run-time.

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
