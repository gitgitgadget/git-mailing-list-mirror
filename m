From: demerphq <demerphq@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 20:08:39 +0100
Message-ID: <CANgJU+U-M9zUUzRNJ=r=Utp7BMhGO37wDQAx8et0W23P3CTegA@mail.gmail.com>
References: <5150C3EC.6010608@nod.at>
	<20130325214343.GF1414@google.com>
	<7vboa7w2vm.fsf@alter.siamese.dyndns.org>
	<384BCFE976364F1EA6E56306566D003A@PhilipOakley>
	<51519DA0.4090201@nod.at>
	<20130326145637.GA3822@sigill.intra.peff.net>
	<5151D589.2000002@nod.at>
	<CANgJU+Wihp=rSQevij6R7SnZtW8UpDtRpFYE00aKKAwiYi9Q_Q@mail.gmail.com>
	<20130326174804.GB10383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZFE-0004zn-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155Ab3CZTIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:08:42 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52838 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969Ab3CZTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:08:40 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so3265591qcq.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DUMav3P1GkhK9ktPkg88BclfjtxkbW0roEOjkGzvw+k=;
        b=O7PLVbPiR6pjIp7FzSx+GpYxAFI0nCONvgIvmkvyV4Dai0zAJySDUm63yI4SBtYeut
         tyUJORAJcV7Wxt2c/vvfrsD3k+w666y6+kG92T81DU8AdOmlzwSBPQUgAeP9m6Hc5Gik
         R2/A5rcIWli9rdKt7Rld4NxtOruFxGvz5LS9SjzyIVk+NikB9OwgWccRKJrR91i0YfGt
         3EMNQmi5oKa7cx8wzqiHOPi85eBeEIEa5sNIhOsl5fDIQuQbExMwtq0vofIlxCakn6ZV
         vqa1kxI/OcWzRq6f45k0kJTdW1vJW1UgnInfinmLQnVgXRowJXm8vbKjavV8Sgi+4wTK
         GJbQ==
X-Received: by 10.49.61.164 with SMTP id q4mr10027701qer.60.1364324919811;
 Tue, 26 Mar 2013 12:08:39 -0700 (PDT)
Received: by 10.49.6.103 with HTTP; Tue, 26 Mar 2013 12:08:39 -0700 (PDT)
In-Reply-To: <20130326174804.GB10383@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219186>

On 26 March 2013 18:48, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 26, 2013 at 06:20:09PM +0100, demerphq wrote:
>
>> Seconded. At $work lots of people started asking anxious questions
>> about this. It was suggested it is a potential security hole, although
>> I am not sure I agree, but the general idea being that if you could
>> manage to set this var in someones environment then they might use git
>> to do real damage to a system. (The counterargument being that if you
>> can set that in someones environment you can do worse already... But
>> im a not a security type so I cant say)
>
> IMHO, that is just silly. Setting GIT_WORK_TREE=/ would be just as
> destructive. Or GIT_EXTERNAL_DIFF="rm -rf /" (or GIT_PAGER, etc).
> If there is a danger to the implicit-workdir behavior, it is due to
> accidental usage, not from a malicious attack.

Yeah, that was my line of reasoning too. I'm glad to hear you agree.

cheers
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
