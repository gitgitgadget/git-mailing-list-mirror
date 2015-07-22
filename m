From: =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Wed, 22 Jul 2015 21:46:44 +0200
Message-ID: <55AFF324.2000609@gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com>
 <CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
 <CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
 <CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
 <CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
 <CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>,
	Gaurav Chhabra <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzz6-00068A-S7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbbGVTrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 15:47:16 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36206 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbGVTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:47:14 -0400
Received: by wicgb10 with SMTP id gb10so113054616wic.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=wN4l2WyvjSRuf1mUOMOKc7MAw5yWyGgp5SpFB3lXOqw=;
        b=jRXTLuSt45ydmq8hOTmbumDxI5c1DlxaUdk1oDOPPuVwnlZ6JZGIC+KctjtaTgRLq/
         UdtqrkKN5tXF1ULP7TZtNX4OeygL/aJ43VY2UNJ96C+8pDcarsKkph47tls8QQXhqEQr
         lXcphUTworP9H8W1RI1dGhXtmxsedyvYpVj4UNjoXyvyLewRBcfjYYZvvTsA7/MW7VWP
         sWe6rZFPdHAbsZZv+osJaFqSbpmHc2/e1cJI23EO0PDn8Myr/GgXXHrnlDTKN+Kiy9Ah
         YVRWn5dvHFbFvyuZx1S0jH4taKKwHgoR1xAo1PVQeRwlAM+tg2M+aPm8NT8pfmXmc39g
         a4xw==
X-Received: by 10.194.9.102 with SMTP id y6mr8084482wja.91.1437594433603;
        Wed, 22 Jul 2015 12:47:13 -0700 (PDT)
Received: from [192.168.1.53] (afu155.neoplus.adsl.tpnet.pl. [83.25.150.155])
        by smtp.googlemail.com with ESMTPSA id b13sm4871868wic.15.2015.07.22.12.47.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 12:47:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274464>

On 2015-07-19, Jacob Keller wrote:

> git describe will tell you if the commit you're passing it is
> associated with an annotated tag. I do not understand who this
> information can help you implement any policy, so understanding what
> the policy you want is would be the most helpful.

One policy I can think of that may have use of checking if commit
is tagged is requiring some extra restrictions on the commit that
is being tagged, for example that the only file that it can touch
is version.h / VERSION-FILE, and no code changes at all.

--=20
Jakub Nar=C4=99bski
