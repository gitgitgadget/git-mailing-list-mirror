From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Fwd: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 16:38:27 +0400
Message-ID: <20080628123827.GM5737@dpotapov.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com> <20080628021444.GI5737@dpotapov.dyndns.org> <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com> <20080628040344.GK5737@dpotapov.dyndns.org> <9af502e50806272320p23f01e8eo4a67c5f6f4476098@mail.gmail.com> <9af502e50806272331vfdbf35ap10fc4375518de946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 14:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCZiE-0005gG-W6
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 14:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbYF1Mie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 08:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbYF1Mie
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 08:38:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:57980 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYF1Mid (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 08:38:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so437524fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i8dlK4zCeHVJWzKq/vT0efKqczEwIvSTpvRa23+4krY=;
        b=H59SQYDVs3AcaSONaCnTwmi+RRlpQkc7n3HmlDq9v/vhW+S+vcECBwevBtPVGUQ2j9
         YIheerWqMlG0nSkQDpnJEDA1gWWeBSwuBJ4FpD3itb8pZTpJE9WQ3jVgkCZpQMybOTd7
         oYwAR28zSK/tuQc4HwfTnibjIC0aGAoic9mxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uxiT7fcybbxWE9e4kAXRAUZiEgf5MqCBeqY4J1pwAKilmZjZx6ajVgGIj67dXGBMm2
         ICXPq6OSOLjweLcirQwJJPMhZa8xyhMYVai/EnbiAbsbA5dkCoUkoVM4+TrTJtiXl/2z
         d4uXBMVubi1Lhf7pShaCC2d8LLwLdu1iXDIqM=
Received: by 10.86.80.5 with SMTP id d5mr3501421fgb.26.1214656711665;
        Sat, 28 Jun 2008 05:38:31 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id l12sm4780716fgb.6.2008.06.28.05.38.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 05:38:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9af502e50806272331vfdbf35ap10fc4375518de946@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86715>

On Fri, Jun 27, 2008 at 11:31:24PM -0700, Robert Anderson wrote:
> On Fri, Jun 27, 2008 at 9:03 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > Do you think commit only tested changes is a common policy among
> > Git users?
> 
> I think there are various flavors of "tested" for which the answer is
> certainly yes.  I think that a line of development which always
> builds, for example, is very, very common.

Well, I don't think it is very common. Almost always builds, yes. As I
said before, with Git commit means more like saving your changes in
logical steps. Making sure that they are good enough to be publish is
done later, and it usually includes testing and may include something
else like code review, and code review is much easier if your work is
recorded in small logical steps, and when you can share these changes
easily and continue your normal work while your changes are reviewed.

> >> This is enforcing a two-step process where there only need be one the
> >> vast majority of the time, to require that commit and publish be
> >> separate operations.
> >
> > I don't see it is a problem.
> 
> Fine, you like doing extra work for no benefit.  Enjoy yourself.

I don't see where you find this extra work. Maybe, pressing a button
to save the file is also extra work? As to benefit, they are real for
me as it saves a lot of time and allows me to work more natural, in
the same way as you edit document. Your first version of document
does not have to be perfect, you can review and improve it later,
instead you focus on main ideas you want to express, and later, you
will proofread and rearrange things, but it is very important to
being able to save your changes even if they are not perfect yet.
Extra work like pressing the save button is negligible comparing
to everything else.

> > You have your working directory let's say on Linux, and you have to
> > test your changes on Windows. So what do you do?
> 
> I rebuild on about a dozen platforms simultaneously on a cross-mounted disk.

Does it work for MS Visual Studio? The last time I tried, it did not
allow to build the project on a shared disk. Anyway, your compilation
time is going to be worse due to network latency, and simultaneously
building on different platforms will be more difficult to organize.
With Git, you get everything for free. You committed your changes
and they immediately available everywhere, and when all tests passed
you can push changes to the main branch, or send to the integrator a
request to pull, or to send a request to code review. It all depends
on your policy...

> > I don't see why git should know it.
> 
> Clearly not.  Example 1:  is it ok to publish?  If temporary commits
> exist, git should stop you.  But git has no idea if temporary commits
> exist or not.

There are no such thing as temporary commits in Git. There are changes
that are ready to be accepted to the main branch and those that are not.
It could be different reasons why these changes cannot be integrated to
the main branch now.  Maybe, you should receive feedback from someone
who does code review your changes.  Maybe, these changes deem too risky
to be integrated now. Maybe, they will clash with someone else's work,
which has a higher priority, maybe something else.  So, I don't see how
you expect Git to know all of that. It is like to expect that your word
processor to know what whether your document is good work publication or
not, and don't let you to send the document out if it is not.

Dmitry
