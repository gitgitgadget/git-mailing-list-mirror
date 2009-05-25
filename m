From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Mon, 25 May 2009 14:41:47 +0200
Message-ID: <4A1A920B.5000206@drmicha.warpmail.net>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>	 <20090507072326.GA13123@vidovic>	 <7veiv0cvdt.fsf@alter.siamese.dyndns.org>	 <20090508042814.GA30031@vidovic>	 <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>	 <20090514160609.GA12910@vidovic>	 <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>	 <20090521041529.GD8091@sigill.intra.peff.net>	 <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>	 <4A155643.5030804@drmicha.warpmail.net> <94a0d4530905210857y51c22909ke65d643abd3e8cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 14:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8ZVV-0001qc-V6
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbZEYMmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 08:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZEYMmA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 08:42:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60998 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750756AbZEYMl7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 08:41:59 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 43B5E3463E2;
	Mon, 25 May 2009 08:42:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 25 May 2009 08:42:01 -0400
X-Sasl-enc: VxnqXP0f7GvwD4dNXsFtlMoaWmEoBLRTAh8lq19184mS 1243255320
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1C7863251A;
	Mon, 25 May 2009 08:41:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090522 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <94a0d4530905210857y51c22909ke65d643abd3e8cee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119932>

Felipe Contreras venit, vidit, dixit 21.05.2009 17:57:
> On Thu, May 21, 2009 at 4:25 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 21.05.2009 09:17:
>>> On Thu, May 21, 2009 at 7:15 AM, Jeff King <peff@peff.net> wrote:
>>>> On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:
>>>>
>>>>>>> http://people.freedesktop.org/~felipec/git/user-manual-general-improvements/
>>>>>>
>>>>>> Thank you very much Felipe to take the time to upload the patches there.
>>>>>> I already have a copy there and I'll look at it soon.
>>>>>
>>>>> Has anybody looked at this?  It's a bit large-ish and touches all over the
>>>>> place, so I am finding it a bit hard to concentrate on it myself really
>>>>> nitpicking, but from the cursory look after formatting the result looked
>>>>> Ok.
>>>>
>>>> I started to, but the first commit message is lacking something that I
>>>> think would make reviewing much simpler: what are the general classes of
>>>> changes that are being made?
>>>>
>>>> I see some doublequotes becoming backticks, and some becoming single
>>>> quotes. And some becoming tex-quotes (``...''), and even some becoming
>>>> doublequotes _with_ single quotes. It would be easier to verify that
>>>> they are doing the right thing if the commit message briefly described
>>>> the rules it followed for changing each one. I think they are something
>>>> like:
>>>>
>>>>  - tex-quotes if it was really a prose-style quotation
>>>>
>>>>  - backticks (causing monospace) for branch names, commands, etc in
>>>>    prose
>>>>
>>>> but that leaves me confused. Some things which I thought should be in
>>>> monospace backticks are in single-quotes (causing emphasis). Like
>>>> 'master' or 'linux-2.6'. And some things are emphasized and in double
>>>> quotes in the prose, like '"o"' or '"branch A"'. What is the rule to
>>>> decide which text should have visible doublequotes but also be
>>>> emphasized, as opposed to just having double-quotes or just being
>>>> emphasized?
>>>>
>>>> Maybe this was even discussed earlier in the thread (I didn't go back to
>>>> look), but it should definitely be part of the commit message.
>>>
>>> The rule I followed is: change it to whatever looks best.
>>>
>>> I followed some guidelines such as: make common text monospace, such
>>> as gitk and master. And emphasize whatever needs emphasizing, such as
>>> fb47ddb2db. Examples are both monospace *and* emphasized.
>>>
>>> Sometimes the end result still didn't look good so I just used
>>> whatever looked best.
>>
>> I think that's a bit of a "quick and dirty" approach. Man pages and user
>> manual should use semantic markup. The matter of "looks" is up to the
>> documentation tool chain, i.e. the style sheets etc. for the various
>> backends.
>>
>> So we would need:
>>
>> - a documentation "style guide" which tells you how to do the semantic
>> markup, such as `cmd` for commands, 'foo' for emphasis etc.
>>
>> - maybe some changes to the style sheets etc. which make the semantic
>> markup "look good"
>>
>> The standard transformations which come with asciidoc/docbook can serve
>> as a guide.
> 
> There's already a guide: the asciidoc user-guide... you can only go as
> far as asciidoc lets you. `` for monospace, '' for emphasis, ``'' for
> double quotes.

I am sorry but I don't think you fully comprehend the documentation tool
chain. Asciidoc translates the *.txt according to config files which
come with asciidoc and can be (and are, in our case) modified. It
translates into xml (for man pages) which is semantic markup. Even at
that step, there are more options - the standard asciidoc.conf (asciidoc
8) has:

[quotes]
# Constrained quotes.
*=strong
'=emphasis
`=monospaced
``|''=quoted
ifdef::asciidoc7compatible[]
\##=unquoted
endif::asciidoc7compatible[]
ifndef::asciidoc7compatible[]
\#=unquoted
_=emphasis
+=monospaced
# Unconstrained quotes.
**=#strong
__=#emphasis
++=#monospaced
\##=#unquoted
^=#superscript
~=#subscript
endif::asciidoc7compatible[]

So, you see we could use quite a few more quote designators if we wished
to. We only needed ' and _ to be different, for example.

Backend specific config files determine what "emphasis" is translated
into: an <emphasis> tag for docbook-xml, an <em> tag (with attributes)
for xhtml.

Then, for man page format, docbook style sheets are applied (using
xsltproc or such) to the xml files. The final appearance is determined
by those sheets. (For html, it's merely css applied by the browser.)

The asciidoc manual really only explains example usage with the default,
unmodified config files.

> 
> I have a problem with clear-cut rules such as: `cmd` for commands.
> 
> Do you think all these are the same?
> The `git clone` command allows you to...
> You can do that by doing '"git commit -a -m Example"'
> Please refer to linkgit:git-add[1]
> 
> If you are reading the text you'll see that the 3 usages have different intents.

Yes, which is why I said "for example", and why a guide needs some
thinking. Or I would have come up with one...

> 
>>> Have you actually looked at the end result?
>>>
>>
>> No. My attempts at doing systematic changes (rather than modifying
>> single pages without a clear target) have failed, so I've been keeping
>> out of this business...
> 
> It's one click away:
> http://people.freedesktop.org/~felipec/git/user-manual/user-manual.html
> 

I guess you completely misunderstood my remark (and I may very well be
the one to blame for that), and it doesn't matter in the context of this
thread. I have no problems formatting the user-manual, thanks to the
recent addition of ASCIIDOC_NO_ROFF ;)

Michael
