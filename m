From: vishwajeet singh <dextrous85@gmail.com>
Subject: Re: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 14:34:40 +0530
Message-ID: <CACbucK=Ap2SxExLRsuZsqaqOHCovMNfe24Sbz+QAP+3HZz+img@mail.gmail.com>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
 <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com>
 <20120731031011.GA1685@localhost.localdomain> <CACbucKmEAz2BQCA28LObk_4Vk4S+-T2bAHaszNNR6=tH0mj9pg@mail.gmail.com>
 <50179B89.4050106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 11:05:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw8O8-0003os-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 11:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab2GaJFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 05:05:04 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40308 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2GaJFC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 05:05:02 -0400
Received: by gglu4 with SMTP id u4so5803609ggl.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bvw88OYhICemH3t7nf6QjI+1D09JE0zZjDP6jS8TDys=;
        b=ouOdBMxCTcRpfPKMksQwSmw8Kl0tUTBaxbwiFiLxMTrKTNSC4PR1zRlztqM6YDNKDD
         3vCccxfa5ELakb73xEQkZ+aIjHO9z1YFC9Z52Scrf8Oxx7p3w+NVe4XfRJdAvY+tasDo
         1icqFKbhRRiMM/GvUmXKumJ3JeDSvsNHnY1A9v+ivjoCo6u/X5Yg1aHSzrczo8F0hxIi
         IyN2d/OGcxhEgDWCTj9ZlQsEwm3QvqGEXagBxuIYWNAzZsWQfc1qE/bb7audc3tNIqgF
         xQMJPT5dI449bp/3GmHl+d1V8bZx1xNuzhh9cGnQSk96S2CxSZAXaNGcWdkHakNQl272
         C37g==
Received: by 10.50.170.3 with SMTP id ai3mr74876igc.9.1343725500832; Tue, 31
 Jul 2012 02:05:00 -0700 (PDT)
Received: by 10.64.15.70 with HTTP; Tue, 31 Jul 2012 02:04:40 -0700 (PDT)
In-Reply-To: <50179B89.4050106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202639>

On Tue, Jul 31, 2012 at 2:17 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> vishwajeet singh venit, vidit, dixit 31.07.2012 05:19:
>> On Tue, Jul 31, 2012 at 8:40 AM, Konstantin Khomoutov
>> <kostix+git@007spb.ru> wrote:
>>> On Tue, Jul 31, 2012 at 08:36:07AM +0530, vishwajeet singh wrote:
>>>
>>>> Just wanted to know the difference between smart http and ssh and in
>>>> what scenarios we need them
>>>> I am setting up a git server,  can I just do with smart http support
>>>> or I need to enable the ssh support to use git effectively.
>>>> As I understand github provides both the protocols, what's the reason
>>>> for supporting both protocols.
>>> http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
>>> http://git-scm.com/2010/03/04/smart-http.html
>>>
>>
>> Thanks for the links, I have already gone through those links, was
>> looking from implementation perspective do I really need to support
>> both protocols on my server or I can just do with smart http and
>> what's the preferred way of doing it smart http or ssh
>>
>>
>
> You need to provide what your users demand ;)
>
> Seriously, this is why GitHub and other providers offer both. Not only
> are some users more comfortable with one protocol or the other (Win
> users don't prefer ssh generally) but some might be able to use only one
> because of firewalls or corporate rules.
>
> From the server perspective, the setup is completely different, of
> course. Do you have shell accounts already which you want to reuse for
> ssh+git? Do you prefer setting up a special purpose shell account
> (gitosis/gitolite) or setting up a web server with authentication?
>
I already have server setup with smart http backend, was just
wondering if my users would really need ssh support or not and I agree
to your point it should be based on user demand.

While going through the git book I encountered a very tall claim about
smart http
" I think this will become the standard Git protocol in the very near
future. I believe this because it's both efficient and can be run
either secure and authenticated (https) or open and unauthenticated
(http). It also has the huge advantage that most firewalls have those
ports (80 and 443) open already and normal users don't have to deal
with ssh-keygen and the like. Once most clients have updated to at
least v1.6.6, http will have a big place in the Git world."

http://git-scm.com/2010/03/04/smart-http.html

Just based on above comment in book I thought if smart http is way to
go for future why to take hassle of setting up ssh.

I was planning to use gitosis as I have python background and code
looks not being maintained from quite sometime, which worries me a
bit, I stumbled upon gitomatic
https://github.com/jorgeecardona/gitomatic, has anyone any prior
experience

Any thoughts or suggestions are welcome.

> Michael



-- 
Vishwajeet Singh
+91-9657702154 | dextrous85@gmail.com | http://bootstraptoday.com
Twitter: http://twitter.com/vishwajeets | LinkedIn:
http://www.linkedin.com/in/singhvishwajeet
