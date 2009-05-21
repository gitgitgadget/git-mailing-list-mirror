From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Wed, 20 May 2009 22:18:01 -0700
Message-ID: <7viqjvdofq.fsf@alter.siamese.dyndns.org>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
	<20090507072326.GA13123@vidovic>
	<7veiv0cvdt.fsf@alter.siamese.dyndns.org>
	<20090508042814.GA30031@vidovic>
	<94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>
	<20090514160609.GA12910@vidovic>
	<7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
	<20090521041529.GD8091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 07:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M70fh-0007mx-Kh
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 07:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbZEUFSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 01:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbZEUFSL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 01:18:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35313 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbZEUFSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 01:18:11 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521051800.VIVL2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Thu, 21 May 2009 01:18:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id u5J11b00G4aMwMQ045J1Tg; Thu, 21 May 2009 01:18:01 -0400
X-Authority-Analysis: v=1.0 c=1 a=YDhzBoFtm8wA:10 a=AYFEWzs_8uQA:10
 a=PKzvZo6CAAAA:8 a=e5mUnYsNAAAA:8 a=PT7kt1FLhZEvE2uRGRgA:9
 a=ZdoAREB6MMi4u3apyXYA:7 a=wXKOXeNJnWDSTW657DBCDhBZbaEA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090521041529.GD8091@sigill.intra.peff.net> (Jeff King's message of "Thu\, 21 May 2009 00\:15\:29 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119656>

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:
>
>> >> http://people.freedesktop.org/~felipec/git/user-manual-general-improvements/
>> >
>> > Thank you very much Felipe to take the time to upload the patches there.
>> > I already have a copy there and I'll look at it soon.
>> 
>> Has anybody looked at this?  It's a bit large-ish and touches all over the
>> place, so I am finding it a bit hard to concentrate on it myself really
>> nitpicking, but from the cursory look after formatting the result looked
>> Ok.
>
> I started to, but the first commit message is lacking something that I
> think would make reviewing much simpler: what are the general classes of
> changes that are being made?
>
> I see some doublequotes becoming backticks, and some becoming single
> quotes. And some becoming tex-quotes (``...''), and even some becoming
> doublequotes _with_ single quotes. It would be easier to verify that
> they are doing the right thing if the commit message briefly described
> the rules it followed for changing each one. I think they are something
> like:
>
>   - tex-quotes if it was really a prose-style quotation
>
>   - backticks (causing monospace) for branch names, commands, etc in
>     prose
>
> but that leaves me confused. Some things which I thought should be in
> monospace backticks are in single-quotes (causing emphasis). Like
> 'master' or 'linux-2.6'. And some things are emphasized and in double
> quotes in the prose, like '"o"' or '"branch A"'. What is the rule to
> decide which text should have visible doublequotes but also be
> emphasized, as opposed to just having double-quotes or just being
> emphasized?
>
> Maybe this was even discussed earlier in the thread (I didn't go back to
> look), but it should definitely be part of the commit message.

I do not think there was any discussion, as the original patch never made
to the list.  And I realize that the difficulty I had while reading this
was exactly what you described here.  Thanks for saying it very clearly.
