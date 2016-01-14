From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 12:12:35 -0700
Message-ID: <CAGyf7-H2jSW0vJZ7ng1OcN7X5tvs+sEuGUH4yMSpJ_-wwUcoTQ@mail.gmail.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
	<20160114213113.c700484c7e3acddc467d0e75@domain007.com>
	<CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: pedro rijo <pedrorijo91@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:13:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJnKd-0004Ar-AU
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 20:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbcANTMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 14:12:38 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34197 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbcANTMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 14:12:37 -0500
Received: by mail-wm0-f44.google.com with SMTP id u188so361594949wmu.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=72VFFg9KhQT41Qzrw50Cqnppib8XDYCAOhep6ECgkBQ=;
        b=jMpMQSTHHHxiwjjMpDeaeymFDElgPZotiEKEHoHi13LDvJxY2HPlplGYuZcZvOFkAN
         YHEh3Jtj7X37nEnhaQgQXm1pdfksp5Gd7Le0JgID1JpDJgEoVMvM0UJbOoY7ZPiTSXMG
         N2kifxJMFYotOSknhaFmu0wVUxPMh73yxP2lDtMfGhDxmOi7NCz2/qGPwLe47p2EKFM2
         Zwho+jGFyQGr1db9sGgB5xZYSUsrqz68DBWNrBhXmu+zhgcA20Yp5PNr0LsmYDGKWIp3
         14/CHp1olCahfYVeRRMefhlFPWwIMZmjrxSScAxt+DViVoTYqtgo2kQYoTs+XLBpoVra
         3fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=72VFFg9KhQT41Qzrw50Cqnppib8XDYCAOhep6ECgkBQ=;
        b=VRNUvNkQvc71qWSLPui+CBfHyR6aktzL67trBVjay+LSp5hZWiV0ydjG8HLnpAfsip
         MaUhUSAE6usRHRqpC9Y+G2WV0SLkqp/hE1Enu5aImF+HPhGbf+K5z8xd8t1Ubds41Zab
         qyv1i7mdb8kWzmQxbM4kMWbEvsYiVKS4HWaorIv1pXc3ljfQyZuq8ntIfs8DRHRRkO0F
         REbTcIPQYDcBKeVdcqrYGAwTy6Zi1OcNRnpvdVL1SGTKwesH4roboqcqD3uRX4FdOMOM
         JYCCrSLfNwoaR6In5Gh71GYF5NEfFNVa1OWAJMkgrNM48oChEmMO6w8a7jhJJr8jrrs9
         y6qA==
X-Gm-Message-State: ALoCoQlacxKvk6AF85TLrOcFlXbER1n4o47JsQnLboakuT3/+6wako5N9ZTkPbxsc5Dq3EESim+WC8DNlp8c4vdrlEjxtB/xowRHY4RDpv8uU8x4IsaKGNg=
X-Received: by 10.194.60.231 with SMTP id k7mr5703905wjr.61.1452798755574;
 Thu, 14 Jan 2016 11:12:35 -0800 (PST)
Received: by 10.28.137.2 with HTTP; Thu, 14 Jan 2016 11:12:35 -0800 (PST)
In-Reply-To: <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284082>

On Thu, Jan 14, 2016 at 11:40 AM, pedro rijo <pedrorijo91@gmail.com> wrote:
> Stefan Beller solution is based on the server, which may not be very
> easy to do when dealing with Github/Bitbucket/Gitlab and other God
> knows which provider.
>
> Konstantin ls-remote solution is the one I'm already using, but if I
> have several branches on that commit, I will not be able to decide.
>
> I thought that the 'main' branch information was stored in git, and
> possibly with some way to access it with a git command

It is, but unfortunately it's not stored in a way that a remote client
can (easily) retrieve using porcelain commands. The HEAD ref on the
remote is the "main" branch, but, as Konstantin's ls-remote command
shows, the actual wire protocol data for HEAD is the SHA-1 of the tip
commit for the branch, not the name.

As Stefan indicated, the way this is messaged to the client from the
server is in the capabilities sent. There's generally not a good way
to see this. However, one thing that you might try (assuming the
you're using HTTPS to talk to the repository and you're on MacOS or
Linux) is to manually run git-remote-https. For example, here's output
for the atlassian/atlassian-refapp repository on Bitbucket:

bturner@ubuntu:~$ git remote-https
https://bitbucket.org/atlassian/atlassian-refapp.git
https://bitbucket.org/atlassian/atlassian-refapp.git | head
list
@refs/heads/master HEAD
d9330a80b50b92b91bb82834f052e9c86ed55452 refs/heads/2.14-beta1
db3dbe4b6549d0ac1437415dbf1ffb750e33e28b
refs/heads/JDEV-32966-fix-xsrfrequestvalidatortest
e0331e00e5e73cd463f12c2947ef567edbb6b9f8 refs/heads/atlassian-refapp-2.2.7.x
e0e562acf9fbdf5255a503a0916a06c52fc456be refs/heads/atlassian-refapp-2.2.x

(Note that the repetition of the remote URL here is necessary.) "git
remote-https" is an interactive process, so when you first run it it
won't do anything. "list" is a command I sent to the "git
remote-https" process that's running. That leading "@refs/heads/master
HEAD" means the remote HEAD is a symbolic ref pointing at the master
branch. So master is the "main" branch.

The same thing works for GitHub. Here's the hazelcast/hazelcast repository:

bturner@ubuntu:~$ git remote-https
https://github.com/hazelcast/hazelcast.git
https://github.com/hazelcast/hazelcast.git | head
list
@refs/heads/master HEAD
988810c4b5c5195412c65357e06cbb0e51173258 refs/heads/3.1.8
bddfb328e4779bccec6f7788c94960f6292b02c9 refs/heads/3.2-fix-eacg
84e7d1006cd342c39afdf0ac520b5b04b8233d75 refs/heads/3.3.6
2e4ffc4f593de0869f0db9f7224f964f72dac15d refs/heads/3.4-gem
d0a7d416b1220ef4badd98e42991dabe34c7beeb refs/heads/3.5.1
6a13721d33bdb07de23f5c505b689e2ee50d5abb refs/heads/3.5.3-ercssn
56676b20baae8668e731f17c9f3b9844ddd486d0 refs/heads/3.5.4

I'm not aware of a simple equivalent for SSH. Also, note that this
"git remote-https" trick won't work on Windows. When you hit Enter
after "list" it writes a CRLF, so the "git-remote-https" process
compares "listCR" against its list of known commands and finds no
match.

Hope this helps!
Bryan Turner

>
> Thanks,
> Pedro Rijo
>
