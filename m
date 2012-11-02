From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Fri, 2 Nov 2012 09:17:26 -0400
Message-ID: <20121102131726.GC2598@sigill.intra.peff.net>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
 <20121030044609.GA10873@elie.Belkin>
 <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
 <20121031012730.GY15167@elie.Belkin>
 <CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
 <20121031021318.GB15167@elie.Belkin>
 <CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
 <509167C8.6090600@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:17:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUH81-0004yJ-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab2KBNR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:17:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54424 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab2KBNR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:17:29 -0400
Received: (qmail 4023 invoked by uid 107); 2 Nov 2012 13:18:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 09:18:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 09:17:26 -0400
Content-Disposition: inline
In-Reply-To: <509167C8.6090600@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208927>

On Wed, Oct 31, 2012 at 07:02:48PM +0100, Johannes Sixt wrote:

> Am 31.10.2012 03:28, schrieb Felipe Contreras:
> > On Wed, Oct 31, 2012 at 3:13 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >> Felipe Contreras wrote:
> >>
> >>> It's all fun and games to write explanations for things, but it's not
> >>> that easy when you want those explanations to be actually true, and
> >>> corrent--you have to spend time to make sure of that.
> >>
> >> That's why it's useful for the patch submitter to write them, asking
> >> for help when necessary.
> >>
> >> As a bonus, it helps reviewers understand the effect of the patch.
> >> Bugs averted!
> > 
> > Yeah, that would be nice. Too bad I don't have that information, and
> > have _zero_ motivation to go and get it for you.
> 
> Just to clarify: That information is not just for Jonathan, but for
> everyone on this list and those who dig the history a year down the
> road. Contributors who have _zero_ motiviation to find out that
> information are not welcome here because they cause friction and take
> away time from many others for _zero_ gain.

And me, who is trying to figure out what to do with this patch. It is
presented on its own, outside of a series, with only the description "no
reason not to do this". But AFAICT, it is _required_ for the tests in
the remote-hg series to work. Isn't that kind of an important
motivation?

Yet it is not in the commit message, nor does the remote-hg series
indicate that it should be built on top. Or am I wrong that the one is
dependent on the other?

-Peff
