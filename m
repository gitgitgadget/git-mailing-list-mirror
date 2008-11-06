From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3] git add -i: Answer questions with a single
 keypress
Date: Thu, 06 Nov 2008 09:06:59 -0800
Message-ID: <7vk5bgiy18.fsf@gitster.siamese.dyndns.org>
References: <200811042215.31147.sunaku@gmail.com>
 <200811050959.25824.sunaku@gmail.com>
 <20081106084230.GA4407@sigill.intra.peff.net>
 <200811060815.16797.sunaku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Suraj N. Kurapati" <sunaku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 18:08:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8LY-0003gR-HM
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbYKFRH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbYKFRH0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:07:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbYKFRHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:07:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 23A1279A7C;
	Thu,  6 Nov 2008 12:07:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5EA7779A74; Thu,
  6 Nov 2008 12:07:07 -0500 (EST)
In-Reply-To: <200811060815.16797.sunaku@gmail.com> (Suraj N. Kurapati's
 message of "Thu, 6 Nov 2008 08:15:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 605B2FDC-AC25-11DD-91F5-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100247>

"Suraj N. Kurapati" <sunaku@gmail.com> writes:

> On Thursday 06 November 2008 00:42:36 Jeff King wrote:
>> On Wed, Nov 05, 2008 at 09:59:25AM -0800, Suraj N. Kurapati wrote:
>> > Allows the user to answer 'Stage this hunk' questions with a
>> > single keypress, just like in Darcs.  Previously, the user was
>> > forced to press the Return key after every choice they made.
>> > This quickly becomes tiring, burdensome work for the fingers.
>>
>> I think this is a reasonable goal, but I have a few questions/concerns.
>>
>>  - There are three versions of your patch, but nobody has commented.
>>    Clearly we can see what changed, but it is not clear what advantage
>>    one patch has over the other. Care to elaborate?
>
> v1 and v2 make the mistake of setting raw mode, which prevent the user from 
> pressing Control-C to exit the program.  v3 fixes this by using cbreak mode.

When I was reading the last round I noticed the above change myself, but
it is customary to write this kind of "patch changelog" under --- line in
your patch around here.  That way you can save everybody's time.

Thanks.  And thanks, Jeff, for being a good reviewer.
 
