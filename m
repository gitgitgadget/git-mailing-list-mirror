From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 09:29:21 +0100
Message-ID: <49C899E1.6060809@drmicha.warpmail.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>	 <20090323064242.GB1119@coredump.intra.peff.net>	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>	 <49C7A8AF.9080500@drmicha.warpmail.net> <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:31:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm22S-0004te-Qi
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbZCXI3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZCXI3k
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:29:40 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51533 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007AbZCXI3j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 04:29:39 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D71A92FC05B;
	Tue, 24 Mar 2009 04:29:37 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 24 Mar 2009 04:29:37 -0400
X-Sasl-enc: nz0wI6MN46OYa76/U4wb6GOke7MpaElE+CjL3hm4+kyI 1237883377
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FA594DC09;
	Tue, 24 Mar 2009 04:29:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090324 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114425>

Felipe Contreras venit, vidit, dixit 24.03.2009 01:21:
> On Mon, Mar 23, 2009 at 5:20 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 23.03.2009 11:31:
>>> On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote:
>>>> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:
>>>>
>>>>>  tt.literal, code.literal {
>>>>>    color: navy;
>>>>> +  font-size: 1em;
>>>>> +}
>>>>
>>>> Isn't 1em already the default size? Or are you trying to override some
>>>> other size specification elsewhere? It's hard to tell what the goal is
>>>> because your commit message merely says "improve".
>>>
>>> That's correct.
>>>
>>> The problem is that when the user has a different size for the
>>> sans-serif and monospace fonts it looks horrible when they are on the
>>> same paragraph. I thought 1em did the trick, but you are right, it
>>> doesn't.
>>>
>>> It looks like the only way to fix this is to set absolute sizes.
>>>
>>
>> Also, it seems that everything which is not black is blue, except for
>> terms, which are green and slanted. I don't think that looks nice
>> together. How about slanted blue?
> 
> What's wrong with having 2 colors?

I don't mind having 2, they just don't look good together over here, on
my screen and to my eyes...

Right now we have "plain old asciidoc look" which doesn't look that old
after all. You pointed out a deficiency, and I'm all for fixing it. I
just think that introducing new colors is something that may require a
ground up rethinking of the theme being used: make it informative but
unobtrusive. Also, I'm against over-emphasizing: use slanted or a
specific color, but not both. Unless one color means emphasizing and
slanted means file, for example.

Michael
