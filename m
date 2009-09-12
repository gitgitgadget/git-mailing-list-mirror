From: John Tapsell <johnflux@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sun, 13 Sep 2009 01:21:43 +0300
Message-ID: <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
	 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
	 <20090912103156.GA30385@dpotapov.dyndns.org>
	 <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
	 <20090912214428.GB30385@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmb2F-0001df-Ca
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbZILWVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbZILWVm
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:21:42 -0400
Received: from mail-yx0-f176.google.com ([209.85.210.176]:53388 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZILWVk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 18:21:40 -0400
Received: by yxe6 with SMTP id 6so2926854yxe.22
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4DxQkdn/KqVtPOkWItlYNJt6okAZxCerGTw8DGZ8saI=;
        b=M0lkU674jMF1tkJPLC0/6BRbnd25EPpIinh234nOog9Hg1ntDY6HhV0BGfGnljcfAZ
         z0MD5PiTl1yGPnIcq21Il99O5l4m4t0hrG0sK9KIj+8KMBOOr1dPIA/8pgEK79fBGlMj
         EwkFu3dOYnVIik+V/y0V9I3hUKBIEft2KB3bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i9ghIORGhYzF6AxaH0TqygcUzJtnFGz0hHrf18aPh01RY5vRj+qu4W+tyywBOdT/HX
         0xU8oRrYIE74+Wcdo6ZmfCo/1pyCO4XhIGRXwEiIRdPfc+Gxm2CatuDQRqhvtZtzKUIt
         5Z6DuEJdxFomGoQ2u1v9ZwKcbCnf62361Wpn4=
Received: by 10.150.32.8 with SMTP id f8mr7384367ybf.118.1252794103257; Sat, 
	12 Sep 2009 15:21:43 -0700 (PDT)
In-Reply-To: <20090912214428.GB30385@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128304>

2009/9/13 Dmitry Potapov <dpotapov@gmail.com>:
> On Sat, Sep 12, 2009 at 09:32:09PM +0300, John Tapsell wrote:
>> 2009/9/12 Dmitry Potapov <dpotapov@gmail.com>:
>> > On Wed, Sep 09, 2009 at 05:09:31PM -0700, Brendan Miller wrote:
>> >> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com>=
 wrote:
>> >> > Brendan Miller <catphive@catphive.net> writes:
>> >> >>
>> >> Is the goal of interface design to make
>> >> it difficult so I need to learn a lot of things, or easy so I can
>> >> remain blissfully ignorant but still do what I want?
>> >
>> > Neither. You cannot get what unless you have specified what you wa=
nt,
>> > and for that you have to learn how to say that. Having good defaul=
ts is
>> > very important, but the problem with choosing them is that people =
have
>> > different preferences about them. For instance, you wanted the def=
ault
>> > prefix for git-archive to be $myproject. For me, a good default wo=
uld be
>> > either $tag_name, or $myproject-$tag_name, or empty (as it is now!=
). So,
>> > what you propose is *never* a good default for me. Moreover, chang=
ing
>> > any default will cause a lot of pain for other people who use Git =
now.
>> > Besides, writing something like --prefix=3D'' is very ugly. So, th=
e
>> > current default makes perfect sense.
>>
>> Ah, great logic. =C2=A0You can't find a default that will suit every=
one,
>> therefore don't bother.
>
> I did not say "don't bother". On contrary, I said that defaults are v=
ery
> important, but, in this case, the current default makes far more sens=
e
> that what was proposed by Brendan.
>
>>
>> >> Yeah, I've been reading them. I'm saying that the docs are a crut=
ch.
>> >> RTFM is the problem not the solution. It makes the user do more w=
ork
>> >> to avoid fixing usability issues.
>> >
>> > A usability issue exists when a person knows how to do that, but i=
t is
>> > inconvenient or error-prone; or when a learning curve is too steep=
=2E
>> > But when someone cannot use, let's say, a compiler, because he or =
she
>> > refuses to read to learn the language, it is not a usability issue=
=2E
>>
>> It's a usability issue when it doesn't just do the right thing in th=
e
>> majority of cases and lets you specify what you want it to do in the
>> rest of the cases.
>
> It does the right thing for me, and not just in most cases, it does s=
o
> in _all_ cases, because it does exactly it is told to do. And it is a
> very important characteristics for any VCS, otherwise you can mess up
> things easily. What is also good about Git is that it does not requir=
e
> much keystrokes to do even rather complex stuff. And many defaults an=
d
> commands are configurable, so you can adjust it to your workflow. So,
> I am not sure what your problem is.

Because I wouldn't call this just a few keystrokes to do the common cas=
e:

    git archive --format=3Dtar --prefix=3DHEAD/ HEAD | gzip > head.tar.=
gz

I honestly don't understand the backlash against Brenden's point that
this could be made a bit simpler.

John
