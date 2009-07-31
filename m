From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Fri, 31 Jul 2009 00:27:37 +0000
Message-ID: <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vljm84htf.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
	 <20090729174000.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 02:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWfyV-0004TG-UY
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 02:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbZGaA1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 20:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZGaA1i
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 20:27:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:5435 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbZGaA1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 20:27:37 -0400
Received: by fg-out-1718.google.com with SMTP id e21so524397fga.17
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 17:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K9Q2iQ4XnVRr4JwvoimKCpL0Co+Cy0yuJXJfoff8kQs=;
        b=LmCVgEPKOmxzAodR9HJbsPTk9RuGw+7/K4wDyFgj3ObGK25Ey18HVo+qJut9N0XhrM
         AhOntKpdmzEMEBabqVZICK2bdVO7RHMH3bchOFlzsGkKn5FdzKAvxhjQx7kj9sFPzQDN
         QrwNG7q/wYaRnEJS1xSXeAQ52ll5rW0/JW6b0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MW2f7dIWEKvANab+IwDyc2HhD01P2oIJhAD5KXzr3mN0ZccjAvTzfAELMyk2NVEGkk
         UOZm3qXf7IDPAAIeZC1CLWA0K7S/X9RQNXtJKmnRHMfPguw05sAjtB2agsr4Iw8z/J4x
         nID+ai5L5F4kZfmIa88V/xcSeMzYbDyJ/HS2c=
Received: by 10.86.92.13 with SMTP id p13mr644967fgb.43.1249000057325; Thu, 30 
	Jul 2009 17:27:37 -0700 (PDT)
In-Reply-To: <20090729174000.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124492>

On Wed, Jul 29, 2009 at 8:40 AM, Nanako Shiraishi<nanako3@lavabit.com> wrote:
> Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
>>> Perhaps --ignore-space-change, to be consistent with a "git diff" option,
>>> would be more appropriate. Doing so has an added benefit of leaving the
>>> door open to add --ignore-all-space option to the patch application side
>>> later.
>>
>> On the other hand, --ignore-whitespace matches the option name (and
>> behavior) of the 'patch' command (just like "git diff"'s matches the
>> 'diff' option name and behavior). Principle of least surprise says
>> that someone coming to git from raw diff/patch setups would expect
>> --ignore-whitespace on the patch side.
>
> Not everybody shares your diff/patch background.
>
> I wouldn't be surprised if git were the first system they ever learn for
> majority of users of version control systems in this century, especially
> because now there are many books written on it.

That's not relevant, "white space" is an already used concept.

Google:
ignore space change: 17,300,000
ignore white space: 181,000,000

> Isn't it more important for git to be internally consistent across its
> commands for such an audience to satisfy the principle of least surprise?

Perhaps, but you are forgetting the option to change the current
commands' arguments.

-- 
Felipe Contreras
