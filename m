From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use of it.
Date: Thu, 19 Aug 2010 10:28:17 -0300
Message-ID: <AANLkTiny0i-raKdkdEVhKjMSUprnkfD-H-4Z5dARa1Xm@mail.gmail.com>
References: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
	<bcb1b64b5db55dd11a398da3cf2c95145852ddfb.1278097858.git.tfransosi@gmail.com>
	<20100702193002.GB6585@burratino>
	<AANLkTiltCRnezNdL-ueNGfM87mRlbtK6fn1fYMcv5M0G@mail.gmail.com>
	<20100702202257.GA7539@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com,
	Alex Riesen <raa.lkml@gmail.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 15:28:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om5AP-00075x-5C
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 15:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab0HSN2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 09:28:19 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49517 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0HSN2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 09:28:18 -0400
Received: by qyk33 with SMTP id 33so1890102qyk.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=frOOvvAeKlykC4roFoykEHhA8wBzQn8NMnn56aIHVvY=;
        b=mSU/+LfCYm9EhH+QVzTFs+D2uXjY6BQ+uxWAm6pfJFhiUO2VaiARFXzfs/5VSFRslr
         2DSii6yuuElCKcwL4ZVf1XCohrjSJjcIK18GZsLEtR3byAQPwK9mjkrJH7YHEYB+EY+l
         h1IWX/MsEu06xV5tfyDLsvjitpYSKC/fnI7Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IbA56Kxsy9D+APlLVAlZx/K9OM2bG0z1tQN/GOr4nV82jjkyc7gqDqsbFFBJBbGMQf
         vAUALvnJjaMlmMeUKg6dOPM8qKs2UkaeMzWYwKNIpYX7cwKQfTvDaAYBlLASXGQJgl6Z
         wtF2w0DR9dEUxIDl6lNBqXQz3PXTX3sphhqXM=
Received: by 10.224.116.20 with SMTP id k20mr6437547qaq.308.1282224497459;
 Thu, 19 Aug 2010 06:28:17 -0700 (PDT)
Received: by 10.229.249.199 with HTTP; Thu, 19 Aug 2010 06:28:17 -0700 (PDT)
In-Reply-To: <20100702202257.GA7539@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153921>

On Fri, Jul 2, 2010 at 5:22 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Thiago Farina wrote:
>
>> #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
>> #define STRING_LIST_INIT_DUP { NULL, 0, 0, 1 }
>
> That looks fine to me. =C2=A0Thanks, and sorry to nitpick.
>
Why that was never merged to the master branch?

<fc60bb94eb4a4b54a0b3f0c075ca2e7141be06f5.1278272263.git.tfransosi@gmai=
l.com>
