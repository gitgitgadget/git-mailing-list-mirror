From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 16 May 2014 03:08:51 -0500
Message-ID: <5375c7934ccc6_7e7b772f8d5@nysa.notmuch>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
 <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
 <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
 <5373fc12bc5e4_7411589304eb@nysa.notmuch>
 <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 10:20:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlDNG-0001YX-R4
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 10:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349AbaEPIUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 04:20:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64028 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058AbaEPITw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 04:19:52 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp4so2487429obc.8
        for <git@vger.kernel.org>; Fri, 16 May 2014 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/xG0FFd1r1cI2szh5Ds2eMlYTJV+OpBTDl7Jk9I4GO0=;
        b=0oValJDtjyCOFtliwqjFLt+bKtVnJ10AEjBqOSR+cq20wOC9BmiUFmRx4R+V4m6Tm6
         lVgcF6pGkziHhJGqmUQfv6ZC6mx+30uq8f+bedojoA5E/ZO4UgWKatYbcLW1jwwItrD5
         iPVhN9XMA4MnD2M5Qs3fSelXrwV8g5sAqTJWAeZMB5kzVIkdp0O1YPgYHAV3pcOQQ2vo
         j+oMMs3MTlGH99eJ90W0arvvv6wIgHVorMOd+Z1yJ/4UDChUHXkYdapO+B7vP1eDlP2j
         acuexUj1+tOXDAQResYFxSoEyJvTC3Qw9qGsIhYh3tDZFuyUL8LrlLswswBuIXaqMjLc
         wtNQ==
X-Received: by 10.182.33.131 with SMTP id r3mr15432152obi.40.1400228392527;
        Fri, 16 May 2014 01:19:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ar2sm13668642obc.29.2014.05.16.01.19.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 01:19:51 -0700 (PDT)
In-Reply-To: <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249276>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > == contrib vs. core ==
> >
> > This is the only point relevant to contrib vs. core:
> > 
> > >  - We may be painted in a hard place if remote-hg or remote-bzr take
> > >    us to a position where the Git as a whole is blocked while it is
> > >    incompatible with the other side.
> >
> > It will never happen. I already argued against it[1], multiple times.
> > Essentially making the tests optional removes any possibility of
> > blockage (pluse many more arguments).
> 
> I already said that your "It will never happen" is a handwaving, and
> I already saw you "argued against it".

This is a red herring. Ignore the fact that it will never happen (which
it won't), the next point remains a FACT, and you conveniently ignore
it.

ANSWER THIS:

> > Essentially making the tests optional removes any possibility of
> > blockage (pluse many more arguments).

If the tests are optional, it doesn't matter if such change you are
worried about happens or not (it won't).

That's all there is to it. You made a wrong call. The tools *can* move
into the core, and you said they couldn't.

> You may have been interested in contrib/core in the thread, but that
> does not prevent others from considering other aspects of the issue
> and different and possibly better solutions, which was to unbundle.

That is IRRELEVANT to the fact that the tools *could* move into the
core. You are using arguments (refuted) to demonstrate that the tools
*might be better served* by being unbundled, in order to explain why
they *could not* move into the core.

That's a red herring.

> I was very confident back in that thread that the remote Hg bridge
> would not merely survive but would serve its users well as a
> standalone project,

And you were wrong.

> There is a greater risk for these bridges to become unmaintained if we
> do not have them in my tree, and that would only hurt our users.

> But I did not see that particular risk at all for the remote Hg
> bridge.  You have been very interested in maintaining it, and I
> don't think I ever had to prod you to respond to an issue raised on
> the list.  It is an apples-and-oranges comparison to bring up
> git-svn/p4.

In other words; if I had done a poorer job of maintaining these tools,
they would have had a higher chance of moving into the core?

If that's the case I would gladly stop any maintenance on them. Just say
the word.

I worked extremely hard so they could become part of the core, if being
part of the core means I have to maintain them less, so be it.

> Besides, I want to see the "git-core has the best thing among
> competing implementations for a specific niche subtask" perception
> changed in the longer term so that it becomes natural for users to
> say something like "For this particular task, there is no support in
> what comes with core (or there is a tool that comes with core to
> address similar issues but in a way different from what you want),
> and the go-to tool these days for that kind of task is to use this
> third-party plugin",

Where are you saying that? Nowhere, that's where. Therefore every tool
you unbundle, you are throwing to the wolves.

> Things like "git imerge" are helping us to go in that direction.  I
> was hoping that the remote Hg bridge to be capable of becoming the
> first demonstration to graduate out of contrib/ that shows the users
> that is the case, not with just talk but with a specific example.

You told me you wanted them to move to the core, you even moved them to
the core.

Then after years of work you change your mind, AGAINST my explicit will
and with clear strong arguments AGAINST your apparently newly conceived
idea. And idea you didn't explain clearly, and which you didn't give any
chance of being refuted.

In other words; an idea which very well COULD BE WRONG, and which very
well could impact negatively many Git users.

But you cannot even ponder the notion that you could possibly be wrong.

> After seeing these discussions, it tells me that the code is not fit
> for the core (also [*3*]), and I think there no longer is any reason
> for us to still talk only about contrib vs core. As you already said,
> you do not want to see them in contrib/,

No, I want to see them in the core, and you said you did too. More
importantly the vast majority of our users would want to see them in the
core, therefore the discussion of contrib vs. core is pretty much
relevant, but you don't care about them, do you?

As I said, I will complain about this publicly _to our users_, which you
are disregarding completely with this poorly thought decision and the
subsequent ones.

-- 
Felipe Contreras
