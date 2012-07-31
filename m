From: vishwajeet singh <dextrous85@gmail.com>
Subject: Re: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 17:01:59 +0530
Message-ID: <CACbucKnDWs9bnLe7k5_AH984DyXXq8V3YPrnDHTxTZErAbBTvg@mail.gmail.com>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
 <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com>
 <20120731031011.GA1685@localhost.localdomain> <CACbucKmEAz2BQCA28LObk_4Vk4S+-T2bAHaszNNR6=tH0mj9pg@mail.gmail.com>
 <50179B89.4050106@drmicha.warpmail.net> <CACbucK=Ap2SxExLRsuZsqaqOHCovMNfe24Sbz+QAP+3HZz+img@mail.gmail.com>
 <5017A368.3010501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 13:32:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwAgc-0000iU-K8
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 13:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab2GaLcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 07:32:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61318 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2GaLcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 07:32:20 -0400
Received: by yhmm54 with SMTP id m54so5910609yhm.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uocl1VUBBAd1jMo/S3ehKwkBMb4F5cA/6Rd3x5BQT/0=;
        b=rk+TyUZNpsLG2ALp3pzQZmQwy+uaN6TEUkWER71RmfPI7AxCvoauhY3VGfwFDshEMt
         bKhy12KE4NyB9hXP1zzl7khJUzhbZpXzRhL7yHvuahF+/nd4wk/hNM+7OGrbpT7WahOt
         9rAUvTfBCzN2VBEYny0H45OrIIovxXrwD/d1HwU7pInGhMw/oC9Pf6OOAkttGYCx4v51
         wdc8aiDPQ5nu6RTWdExbbPfcBezweNEIDp9NBtygr4N0ifXaHY60xHA9gHQ6y5p8VOTB
         /mM/RqxKCKBGY+9Ugzgsqcogw3RiD9YTN6Y7JWzIBlOHx6Lhhoif94QHBwNkkwazzqrv
         BNcA==
Received: by 10.50.104.228 with SMTP id gh4mr278718igb.71.1343734340225; Tue,
 31 Jul 2012 04:32:20 -0700 (PDT)
Received: by 10.64.15.70 with HTTP; Tue, 31 Jul 2012 04:31:59 -0700 (PDT)
In-Reply-To: <5017A368.3010501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202646>

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

Now I think I should add ssh support :-)

let me know anything I need to be careful about from security
perspective while implementing this and any general pointers, mean
while I will go through the docs as well.
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

I am looking for something based on python, I gave up using perl long
time back and there's no going back.
Will explore gitosis code and see if it can be used

Thanks for your answers it really helped me.
>
> Michael



-- 
Vishwajeet Singh
