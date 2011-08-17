From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Issue: Mails sent twice if patch is mentioned twice while sending mail.
Date: Wed, 17 Aug 2011 14:22:09 +0530
Message-ID: <CALkWK0nv=NrCzxfePL50GiJya+DbqdOmSMjPVEa-Sf1Qm5oAvg@mail.gmail.com>
References: <4E4B5B9D.1070901@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 10:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtbrY-0000kd-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 10:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1HQIwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 04:52:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50054 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1HQIwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 04:52:31 -0400
Received: by wyg24 with SMTP id 24so515908wyg.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wyTDwoQcbADYcNcJi/B3GP5k4siw1ug4vFssAkypkAM=;
        b=JO2engzDYxXQCDFX8us2n4SavHePBoe3AiXbjKjDn7sFwb9dah0p6ibyVURWUuU3Tx
         hrB4nRHfR5dts3WLn3sMuC3070Mgk7GWf9e8WKdNc6rkLjDAXnMvxmmW/ctulfhCW5wX
         7H1m3QnjgT4hkhljbvpVT7kxtzktOcaLgWwz0=
Received: by 10.216.37.16 with SMTP id x16mr560186wea.93.1313571150107; Wed,
 17 Aug 2011 01:52:30 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Wed, 17 Aug 2011 01:52:09 -0700 (PDT)
In-Reply-To: <4E4B5B9D.1070901@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179504>

Hi Viresh,

Viresh kumar writes:
> git send-email --to=abc@xyz.com 0001-xyz.patch 0001-xyz.patch
>
> What should be the desired behavior of this command, Should we get
> mail only once or twice?

I'd expect it to send out two emails.  Why should 'git send-email'
check the supplied command-line arguments for duplicates?  I can't
think of a usecase for it. It's a simple Perl script that mails out
the mbox files specified on the command-line.  Could you tell us your
usecase?  If it's a shell script that calls 'git send-email' with
duplicate arguments, I think you should fix the shell script, not 'git
send-email'.

Thanks.

-- Ram
