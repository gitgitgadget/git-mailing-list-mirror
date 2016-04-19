From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 20:50:44 +0200
Message-ID: <CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:50:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaja-000885-0E
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933125AbcDSSuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:50:46 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:34681 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbcDSSup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:50:45 -0400
Received: by mail-qg0-f66.google.com with SMTP id m8so2516148qgd.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rugzkcfu0YdxNSF4l44rrlabeQlEjQdHHO9A4q9vEG8=;
        b=tuPRrSxZtSysciylrBcnExGH0jZ0XiTB3/sknupGEMqBwUcepkO6UmetcTZa5lvrwG
         5H1WFVwAaRLjKaJv1dZpJg5Wv4fkJLGLWSG3/wa8DyhQVKIzBXnqVn21rFp2GUy0kMG2
         RPMszD9r4ezEudJdWSI7dMBXEg5k0WdT8clMDAXGg8Gayt3NMzEBD6hYOOJe0lKVhJXp
         uCItAfO8UbjM4aVzeqrhmSO2eaH9CJ0gPSaGmhBx9NqE+xFRe5VlIwXgjVsA/3GPTdVd
         VTNIjs1qHmrdjm6VPpiel10VsTJ5kmXzYmtcHszTevz1u+xZm916Gdrut4VgLOV+q1Vo
         dDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rugzkcfu0YdxNSF4l44rrlabeQlEjQdHHO9A4q9vEG8=;
        b=ElsJaDzrNc2i17vKsrHbkh/cj4Rq+ThpOi4lkE9WAEhN0+fgEEcYEgvcdJO1WgBmMj
         gngLp2V1vFcimI934zpsLkJ0gnD0T0ozLJ7OzcKTomXErLqVo3t8qNXuAea5UxI4pVZk
         lt+gEHA3F2pyaoOl3ug5RtMU95E+ftNbehNRfet+s0J/Z1qxytDw8rG10u0LHMurYxFF
         apDgGIdFQyYTmG930OILkAqfkHSSzkIiCUhWHbqKQANAUGjsjHV3s3St/56rarpXYuaB
         BOj4JW4oEz2BF8SpAavUn12ZKtKX9kPFS3vu8Q7k8m/NTUdQMbdJRG4ORsYQ/y99Fnm6
         3bZQ==
X-Gm-Message-State: AOPr4FVY4Ts/2KHUewaE1jMW7EKmqEt1WlaclJbMxz5pSzZ3RJYM6083fRZGDV3n/pWoRhBm51X3EUqwAY16eA==
X-Received: by 10.140.236.87 with SMTP id h84mr6051100qhc.20.1461091844233;
 Tue, 19 Apr 2016 11:50:44 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Tue, 19 Apr 2016 11:50:44 -0700 (PDT)
In-Reply-To: <xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291902>

> Any submitGit users?  I think it lets you throw multiple-patch
> series just fine.  In this case, you'd prepare a two patch series on
> a branch, 1/2 being the clean-up and 2/2 being the new feature, and
> if you give that branch to submitGit as a whole it should do the
> right thing, I'd imagine.

Hm... I'll see what it does with a pull request that has 2 commits.
