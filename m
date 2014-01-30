From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Feature Request Google Authenticator Support
Date: Thu, 30 Jan 2014 18:22:33 +0100
Message-ID: <52EA8A59.1030801@gmail.com>
References: <20140130040702.GA77226@gmail.com> <CABPQNSZmvPH-J=r57_WNjq3WOS7m8dGyrj0Y84etF+8aGAMSiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com, Max Rahm <ac90b671@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 18:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8vK7-0002tO-SM
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 18:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaA3RWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jan 2014 12:22:40 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:60103 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaA3RWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 12:22:39 -0500
Received: by mail-ee0-f47.google.com with SMTP id d49so1735977eek.20
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 09:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jJ11O3RhqS1kaLylgYqX66g/8K7zHSITrjnukfQqoEc=;
        b=xzizO5MyEarR8LJ8NSYVUXiV4eAuliD4GSjieYxaoVn+O3Sdthwo51orn9gWWhnNhH
         kdSF8rEXuhNFnbFcpNBumbOG6urUAp4judzvkTY6EMrJfCWhC56SmPVYmkXZX0U4D6Tw
         p+3ttPI4mYGN3p3KTtwOS24uGQTrpQuU39sl24sGgDRoWSxiQITHnP5dnhf+bXQxAtvF
         HVlY4CDO03sJIvrcsO1d4RzTVuSQRAEGqpqjmndmOiQnf9UgO95/53ACRAset2rUD65f
         rQztZvTbiPSCalWLbrHI+IdzXGbdVmLvd5eV6TOvFBcdmYFT9lYFy/GezBPW20awLHmQ
         Kj0Q==
X-Received: by 10.14.179.73 with SMTP id g49mr3761512eem.71.1391102558069;
        Thu, 30 Jan 2014 09:22:38 -0800 (PST)
Received: from [158.75.2.83] ([158.75.2.83])
        by mx.google.com with ESMTPSA id 46sm24878614ees.4.2014.01.30.09.22.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 09:22:36 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CABPQNSZmvPH-J=r57_WNjq3WOS7m8dGyrj0Y84etF+8aGAMSiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241273>

On Thu, 2014-01-30, Erik Faye-Lund wrote:
> On Thu, Jan 30, 2014 at 5:07 AM, Max Rahm <ac90b671@gmail.com> wrote:
>> Github supports google authenticator 2-step authentication. I enable=
d it
>> and how can't figure out how to connect to my github account through=
 git.
>> I've looked pretty hard in the man pages and on google and can't see=
m to
>> find anything on how to set up git to work with a repository with 2-=
step
>> verification. Here's a link to my stackoverflow question with my exa=
ct
>> problem if there's something I'm missing.
>>
>> http://stackoverflow.com/questions/21447137/git-github-not-working-w=
ith-google-authenticator-osx
>>
>> As far as I can tell the feature is not supported. I'd like to be ab=
le to
>> use the 2-step authentication but obviously I'd like to be able to p=
ush my
>> code :D
>
> This sounds like a question for the GitHub support rather than the Gi=
t
> community.

Especially that Git prides itself that it does not do authenthication,
but passes it to appropriate programs, SSH or web server (HTTP).

Own git:// protocol is unathenthicated.
--=20
Jakub Nar=C4=99bski
