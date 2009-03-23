From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Mon, 23 Mar 2009 16:20:15 +0100
Message-ID: <49C7A8AF.9080500@drmicha.warpmail.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>	 <20090323064242.GB1119@coredump.intra.peff.net> <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 16:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lllz7-0007VT-4B
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 16:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758775AbZCWPUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 11:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758744AbZCWPUf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 11:20:35 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50572 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758765AbZCWPUd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 11:20:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A86502F73F3;
	Mon, 23 Mar 2009 11:20:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 11:20:31 -0400
X-Sasl-enc: Vb0QtcObCR40iTYr6zsyWxpja4UfldIra2QvGIWfvVQp 1237821631
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EC793246D9;
	Mon, 23 Mar 2009 11:20:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090323 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114325>

Felipe Contreras venit, vidit, dixit 23.03.2009 11:31:
> On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote:
>> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:
>>
>>>  tt.literal, code.literal {
>>>    color: navy;
>>> +  font-size: 1em;
>>> +}
>>
>> Isn't 1em already the default size? Or are you trying to override some
>> other size specification elsewhere? It's hard to tell what the goal is
>> because your commit message merely says "improve".
> 
> That's correct.
> 
> The problem is that when the user has a different size for the
> sans-serif and monospace fonts it looks horrible when they are on the
> same paragraph. I thought 1em did the trick, but you are right, it
> doesn't.
> 
> It looks like the only way to fix this is to set absolute sizes.
> 

Also, it seems that everything which is not black is blue, except for
terms, which are green and slanted. I don't think that looks nice
together. How about slanted blue?

Michael
