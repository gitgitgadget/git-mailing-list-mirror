From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 07/25] contrib: remove 'git-jump'
Date: Fri, 09 May 2014 11:13:14 -0500
Message-ID: <536cfe9ab8c66_ce316372ecf6@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
 <20140509020350.GD9787@sigill.intra.peff.net>
 <536c399454062_741a161d31099@nysa.notmuch>
 <20140509152005.GB18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 18:13:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WinQL-0004ud-6S
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938AbaEIQNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:13:21 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:42052 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929AbaEIQNU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 12:13:20 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so5037342oac.25
        for <git@vger.kernel.org>; Fri, 09 May 2014 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GOzxuJplsFMPITbMB/5zQ8I4sBK2pGihuMMhP7b4E+U=;
        b=iftwSNXBCS1CVCIj0uliCnlU4lBhh6jCVJiiSY6FonH77Zo+8hOHS2TeQjGyqtezEw
         gNlOGyDHfT6PSKGk0uOZGDnsIlVZzNfz/D9ElVvCtbD698nNPobf1IhLPO7E18hvjWmg
         ep3r33UdxuE46aHyMBv/bO8hWb7pUm9o6S0tDDMcw4Sxmham+LH/wCj1es3ya0z1m+K/
         y8FBdwxk0FvGJ24VGeFW4hHryXrBNheyaG8YOpxLjK8zgTsR2f1tqKomoPZFZyW1yePf
         tXteddAQRH+jJMKpDoeF8zAkH8F0MsjdMJaNvVmuMLws5jqwvJih9OVH8j5r7d/7peva
         5p5w==
X-Received: by 10.60.159.5 with SMTP id wy5mr15286411oeb.58.1399651999570;
        Fri, 09 May 2014 09:13:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cu7sm17478547oec.12.2014.05.09.09.13.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 09:13:18 -0700 (PDT)
In-Reply-To: <20140509152005.GB18197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248580>

Jeff King wrote:
> On Thu, May 08, 2014 at 09:12:36PM -0500, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> > > On Thu, May 08, 2014 at 07:58:18PM -0500, Felipe Contreras wrote:
> > > 
> > > > No activity, no tests.
> > > 
> > > Like diff-highlight, I don't think "no activity" is a useful indicator.
> > > I use this daily, and several people have commented off-list to me that
> > > they use it, too.
> > 
> > Add tests then.
> 
> I don't really feel like spending time on it right now. There are better
> uses of my time.
> 
> I thought on this for a while before responding. Am I simply being lazy
> and a bad programmer not to write tests?

It depends how you define "lazy". Some people think laziness is a good
quality in a programmer.

> Am I propagating a double standard where I do not have to write tests?

Only if you are imposing those standards onto others. It doesn't seem
like you are doing it, but Junio is.

> Here's the conclusion I came to. Sure, some tests are better than no
> tests. But the code works, empirically; I use it every day. It is not
> changing, so the chances of regression are low. I can spend an hour
> writing tests that demonstrate what I already know. I can even spend
> several hours trying to come up with torture cases that might
> demonstrate a potential failure that nobody in the real world
> experiences. But why?
> 
> Because YOU, who have no interest whatsoever in either this script or
> diff-highlight, have decided to demand that I write them, or spend time
> spinning the code into its own repository. Sorry, but I have more useful
> things to do than appease you.

Nobody is forcing you to do anything. If you don't want to write tests,
move the code out of git.git, there's hundreads of tools out there
out-of-tree, and they don't have tests either.

The purpose of contrib is very clearly defined in contrib/README, and
nowhere does it say that tools belong there if Peff uses them. You need
more than that to belong in contrib.

> I have no problem with cleaning up cruft in contrib that is broken and
> nobody uses; it is a potential hazard and time-waster for people who
> look in that directory. But when people say "no, this is maintained, I
> use it, and it works", I really don't see the point in you arguing with
> them. Nobody benefits.

Then you need to talk to Junio, because it really doesn't make sense to
have such abismally different double standards.

> > It this is never meant to move to the core, then it should go
> > out-of-tree anyway.
> 
> "should" in your opinion. I know, I know, you will quote contrib/README
> at me.  If Junio wants to enforce "contrib is only for things which are
> meant to graduate" in his tree, then I will abide by that and maintain
> these scripts out-of-tree. But I would rather see an actual decision
> from the maintainer on that, and not an 8-year-old README which clearly
> has not been followed in the intervening years.

Exactly. Junio has to decide what is the standard for contrib, and what
is the standard for the core. And right now we have incredibly crappy
and unmaintained tools in contrib that nobody uses, as well as
production ready which are in better shape than some tools in the core.

This huge discrepancy should not be.

> And speaking of wasted time, I do not plan on responding further to you
> in this thread. I am telling you ahead of time that this is the case,
> because elsewhere[1] I saw you complaining that Junio did not respond to
> your emails,

Respond or not, the issue about the discrepancy of standards remains.

> which you seemed to think was because he cannot admit that he was
> wrong.

Why he didn't do it is irrelevant, the fact is that he didn't do it.
Other people wonder what is the reponse to these questions. If he
doesn't do it, that's on him.

-- 
Felipe Contreras
