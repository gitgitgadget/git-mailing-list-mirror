From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 14:58:49 +0530
Message-ID: <CAMK1S_jjSQsSXDRcY7f027hCYhhmWUBgH+rC1dZe+6t0wgjTTA@mail.gmail.com>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
	<CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com>
	<20120731031011.GA1685@localhost.localdomain>
	<CACbucKmEAz2BQCA28LObk_4Vk4S+-T2bAHaszNNR6=tH0mj9pg@mail.gmail.com>
	<50179B89.4050106@drmicha.warpmail.net>
	<CACbucK=Ap2SxExLRsuZsqaqOHCovMNfe24Sbz+QAP+3HZz+img@mail.gmail.com>
	<5017A368.3010501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: vishwajeet singh <dextrous85@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 11:28:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw8l8-0005bj-S5
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 11:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab2GaJ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 05:28:53 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43616 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753826Ab2GaJ2w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 05:28:52 -0400
Received: by lahd3 with SMTP id d3so3915198lah.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kMcuAvlohqcWPwNaeVN4LtlM/TudYJCQf7t/E0fPJlc=;
        b=aqRapT3abo4MUYqjYEemre4crphnzky7YLT8k1wYg+5FCffjQbdtAEe5o9+f1ywziE
         SEXb8Zcm9ciB+UqJCeWz4Wg8YAiddSjGEuw66Tok8twDCN5BOphMJSx61OBNJSJE3Xnx
         2eHRPLah5TJHdsvazeFUw4BOXUvEvsVGFbxS4TIed0bFSKGcrZnlCg5ncv2VKF4wpyjA
         CeqWccDRksp3jJVIDhbxjT3ARIEY+PBHlhS3YDQ7/gWFAsJunrXzbT2R0fUcihqXiJbM
         6Qsxx6T3OdYxI1pjL1rPCmvTS16FEp489/EuKnAOfiq80my2EcGFszU5kNqeS2VW0Eyc
         oeeg==
Received: by 10.152.132.40 with SMTP id or8mr14304903lab.24.1343726929412;
 Tue, 31 Jul 2012 02:28:49 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Tue, 31 Jul 2012 02:28:49 -0700 (PDT)
In-Reply-To: <5017A368.3010501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202642>

On Tue, Jul 31, 2012 at 2:50 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> vishwajeet singh venit, vidit, dixit 31.07.2012 11:04:
>> On Tue, Jul 31, 2012 at 2:17 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> vishwajeet singh venit, vidit, dixit 31.07.2012 05:19:
>>>> On Tue, Jul 31, 2012 at 8:40 AM, Konstantin Khomoutov
>>>> <kostix+git@007spb.ru> wrote:
>>>>> On Tue, Jul 31, 2012 at 08:36:07AM +0530, vishwajeet singh wrote:
>>>>>
>>>>>> Just wanted to know the difference between smart http and ssh and in
>>>>>> what scenarios we need them
>>>>>> I am setting up a git server,  can I just do with smart http support
>>>>>> or I need to enable the ssh support to use git effectively.
>>>>>> As I understand github provides both the protocols, what's the reason
>>>>>> for supporting both protocols.
>>>>> http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
>>>>> http://git-scm.com/2010/03/04/smart-http.html
>>>>>
>>>>
>>>> Thanks for the links, I have already gone through those links, was
>>>> looking from implementation perspective do I really need to support
>>>> both protocols on my server or I can just do with smart http and
>>>> what's the preferred way of doing it smart http or ssh
>>>>
>>>>
>>>
>>> You need to provide what your users demand ;)
>>>
>>> Seriously, this is why GitHub and other providers offer both. Not only
>>> are some users more comfortable with one protocol or the other (Win
>>> users don't prefer ssh generally) but some might be able to use only one
>>> because of firewalls or corporate rules.
>>>
>>> From the server perspective, the setup is completely different, of
>>> course. Do you have shell accounts already which you want to reuse for
>>> ssh+git? Do you prefer setting up a special purpose shell account
>>> (gitosis/gitolite) or setting up a web server with authentication?
>>>
>> I already have server setup with smart http backend, was just
>> wondering if my users would really need ssh support or not and I agree
>> to your point it should be based on user demand.
>>
>> While going through the git book I encountered a very tall claim about
>> smart http
>> " I think this will become the standard Git protocol in the very near
>> future. I believe this because it's both efficient and can be run
>> either secure and authenticated (https) or open and unauthenticated
>> (http). It also has the huge advantage that most firewalls have those
>> ports (80 and 443) open already and normal users don't have to deal
>> with ssh-keygen and the like. Once most clients have updated to at
>> least v1.6.6, http will have a big place in the Git world."
>>
>> http://git-scm.com/2010/03/04/smart-http.html
>>
>> Just based on above comment in book I thought if smart http is way to
>> go for future why to take hassle of setting up ssh.
>
> There is no need to set up ssh if smart http does the job for you. I
> don't think it makes a difference performance-wise on the server
> (upload-pack vs. http-backend) but others are more proficient in this area.
>
> I'm sure ssh+git is there to stay, it is just ordinary anonymous git
> protocol tunneled through ssh. So, it's as future-proof as git is.
>
>> I was planning to use gitosis as I have python background and code
>> looks not being maintained from quite sometime, which worries me a
>> bit, I stumbled upon gitomatic
>> https://github.com/jorgeecardona/gitomatic, has anyone any prior
>> experience
>
> No idea about gitomatic. It looks a bit like "gitolite in python"
> (alpha) but doesn't say much about it's ancestry.
>
> There's also gitolite which is actively maintained and used. Basically,
> it's "gitosis in perl". Sitaram, forgive me ;)

oh that's quite alright.  People forget that gitolite was, for the
first 3 days of its life, called "gitosis-lite" :)

-- 
Sitaram
