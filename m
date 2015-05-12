From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Tue, 12 May 2015 13:58:56 -0700
Message-ID: <CAGZ79kZG=9BkEGB_GOsg7F-2mN5iTjmTFK+vUohj_7wJLfPtig@mail.gmail.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	<xmqqfv73f420.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
	<xmqq7fsd201d.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0k-=ESEu-7jhf8Y5wz+5A=MHsjtMnC7YJv_DRi30TmDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:59:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHGd-0004lL-TE
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 22:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbbELU7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 16:59:02 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36195 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbbELU65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 16:58:57 -0400
Received: by igbpi8 with SMTP id pi8so120774147igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DEhLFG2DQaFDx197GXmrwvudqsLfQvN57T75cO4TR34=;
        b=ES/2a1feBFL/YbyCZ3HQdajbq7RlvWhtD0RmjLIRIeyDS3/CEJmx1nRx9ZbcJ3lUj6
         Jbq+v/gDB8xwVTj5zBZ25Mymoa7GHVk+z7D5FVcgdM39HtqMx02UE5OUSgIeztlYyif8
         IU7vVGisQWBxHSK66vS+i3qVSfiJMGvzKBk6LXD091J3/+z6NPe4NW33qYcji8z2RvH1
         wKlyOdCigMinD17ias0XNYvXxjnBBUmKAtU/pnDwFnppBwKki+lQy1SsqSSl7VHRiQlf
         YuV5WSQ2DrjI4A5Dk2IR7ZMMdTbzyV/PWEFybQTNxr7ikUhjHwfti06IOs36dAvIcw/3
         armg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DEhLFG2DQaFDx197GXmrwvudqsLfQvN57T75cO4TR34=;
        b=Z0uhC1aeSHdirWcySwqlIMJ2rl+kEKPETivk+ZMwYipvt0hYX91jcPlsuAfidbQAb0
         Nw2h+B4SEH0v4TcI/7Gv/EYFo35EHEXO2gOiOWmxYRj1O9NTuUe3MOPiM1j/I/H7notY
         4AnZHw6bvEAEb3VDlZZ/ltOLYn2hlYR3uQ5AuH6MspwBSldtKUvu2tf1IkyEEXHElweT
         bbPufYyyCTgunvLqBgn4slnKHXs0g/nLR1VxTnlAVQSoTbBA+/fVrrPKEelCA4p8Qu2d
         forP4qRbiBU1rivvSzJkPmz3IIhTZMpazVquPI8RtO06PNMMjI0NvjWzUtW3ELcnYWxp
         V4kg==
X-Gm-Message-State: ALoCoQlN4s+sPxNgz9L6CkbPoj4bT4iVIlqYjQAJNviDez9CefEgZe8HYcP7MDaXbY/+acUzJSI0
X-Received: by 10.107.170.40 with SMTP id t40mr2420432ioe.2.1431464336191;
 Tue, 12 May 2015 13:58:56 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 12 May 2015 13:58:56 -0700 (PDT)
In-Reply-To: <CAP8UFD0k-=ESEu-7jhf8Y5wz+5A=MHsjtMnC7YJv_DRi30TmDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268882>

On Tue, May 12, 2015 at 1:43 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, May 12, 2015 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> On Mon, May 11, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> To be bluntly honest, I think the current one is sufficient as a
>>>> good-enough default.  The first thing I would do after seeing that
>>>> message is to either "git checkout <commit-object-name>" or "git
>>>> show <commit-object-name>", and the current full 40-hex output gives
>>>> me an easier mouse-double-click target than the proposed abbreviated
>>>> one, so in that sense the original proposal may even be a usability
>>>> regression.
>>>
>>> Yeah, it might also be a regression if some users have scripts that
>>> depend on the current behavior.
>>> ...
>>>> It is tempting to say that the output can be eliminated by always
>>>> checking out the first-bad-commit (i.e. only when the last answer
>>>> that led to the first-bad decision was "good", do a "git checkout"
>>>> of that bad commit), but in a project where a branch switching is
>>>> not instantaneous, that might be problematic (unless the first step
>>>> the user would have done is to check it out anyway, of course).
>>>
>>> Yeah, and speaking of regressions, elimiting the output might be a
>>> more serious regression.
>>
>> I am getting somewhat annoyed by this line of thought.
>>
>> Who said bisect output is meant to be parseable and be read by
>> scripts in the first place?  If that were the case, we wouldn't be
>> having this discussion thread in the first place.
>
> Well "git bisect run" is all about automating bisecting and we know
> that some people have been using it for a long time.
>
> See for example this message from 2007:
>
> http://lkml.iu.edu/hypermail/linux/kernel/0711.1/1443.html
>
> where there is:
>
> "Today we can autonomouly
> bisect build bugs via a simple shell command around "git-bisect run",
> without any human interaction!"
>
> So it is reasonnable to wonder if some scripts might be parsing
> the output.

This reasoning sounds to me, that the lack of a plumbing counterpart
to bisect(porcelain) made it a de facto plumbing command,
which is unfortunate for discussing changes like these.

So how to proceed here?
* one way would be to ignore the scripts out there, "because it's
  porcelain, so nobody sane would have written a script using it anyway"
  but this attitude is not well perceived in the community I'd assume.
* declare the current bisect command a plumbing layer command and
  introduce a new porcelain command, how about "git find" which can address
  a variety of issues such as also having the capability to find a fix
instead of
  just regressions (make good/bad markers less confusing)
  Depending on the implementation this may be a lot of work
  -> copy/paste is fast and involves less work now, but more in the future
  -> or having a new plumbing-bisect header making calls from the porcelain
      to the plumbing bisect tool.
