From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 23:44:10 +0200
Message-ID: <CABEqOBzXvr3Xp+XJtqjL5eY8Spy8Bi1SezCut0_QJdYnw9C4Zg@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	<xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:44:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdRP-0004Zf-Vs
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbcDSVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:44:12 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34933 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbcDSVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:44:11 -0400
Received: by mail-qg0-f67.google.com with SMTP id b14so1817656qge.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LeA7wWanGVPRi5kxzk8S102vrzGuWnIhbAwhTMs3X6c=;
        b=x+YbeWjDf1gW/zNOBbo64IkzN0SVB8jF/fnsp6Oj1zWCD126qL9Hu7U9oECJUMKH8F
         syVgQ6s+1Z63LZnYINK8yw86/GIe5J+IxVX5Jdu0mHaoF+KiDYlgopv1MxU+5QLTB8aE
         WCrQYetgsGjADEhizAblbjKdhm3pDAc3JtgiA+OkWPwN4LkNHSkfAsuCc1gs1Vgg1yjn
         DN/l9kgmo7CiV/U4KobHSe6aAPmxjn51e0qqp5Mnpka6bfjRGU9LfoZ13oUCYYCox32i
         +mqeTmAsBSHA4cUAe6B//4+hXvkhWJsbE/BMJTNfXxS12jm+WDap8wZipvw1vjPS2NGh
         JPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LeA7wWanGVPRi5kxzk8S102vrzGuWnIhbAwhTMs3X6c=;
        b=YoKRGNYnaF+YN0jio8E4m0uKT9qnN0WLNjzguOFEP0epr7cGHcu3e/tXfrSjYhM2JY
         /TCLNR+JEy7I2Qav3ZW6SM8Qz2ttCLliG/mUVhQoKCVlNF7bDOdFP/c8Klp4HQGtn+Cp
         PSf/GpL2BNNnJ0yjcAR8Ojcxib3R+ORfk2gWwaZYMfoVxbl2lPmr9nEDIs2Y1D1nqhfO
         DelBugbNBY3NQAc3eyu9L0Qsxm/9nD4r8/Xvn9AsqgH0wa5cVQcJ+iUeexhuH/7rytVA
         PjwkhUL+hgXGUDOaFQfB26GJW9mGbOj8XqapfWvEEbzpwf7aXv5HkTjsnAOXNrYUPhCH
         XBew==
X-Gm-Message-State: AOPr4FVK0l8Rn1EjVl4yW6vsRNVji+Xifnnd5JBXDw7O+U1hpxGZd6Ay//HLsEdqxsFgJw1vuxbOBSHeKxGKvA==
X-Received: by 10.140.236.87 with SMTP id h84mr7081202qhc.20.1461102250358;
 Tue, 19 Apr 2016 14:44:10 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Tue, 19 Apr 2016 14:44:10 -0700 (PDT)
In-Reply-To: <xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291934>

> By the way, you may or may not have noticed that I've been
> reordering the lines of your message quoted in my responses; around
> here, top-posting is frowned upon.

I haven't noticed. Thanks for pointing out.

As for the submitGit cover letter I wanted to raise at least an issue
(if not create a fix itself) but it seems to be raised already as
https://github.com/rtyley/submitgit/issues/9
