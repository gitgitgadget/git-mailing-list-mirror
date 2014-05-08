From: David Kastrup <dak@gnu.org>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Thu, 08 May 2014 23:32:01 +0200
Message-ID: <874n10ot2m.fsf@fencepost.gnu.org>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<20140508212647.GA6992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVvF-00041r-1V
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbaEHVcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:32:04 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41503 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbaEHVcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:32:03 -0400
Received: from localhost ([127.0.0.1]:40544 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WiVv8-0003TC-CL; Thu, 08 May 2014 17:32:02 -0400
Received: by lola (Postfix, from userid 1000)
	id E4EADE0A47; Thu,  8 May 2014 23:32:01 +0200 (CEST)
In-Reply-To: <20140508212647.GA6992@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 8 May 2014 17:26:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248450>

Jeff King <peff@peff.net> writes:

> On Thu, May 08, 2014 at 01:52:38PM -0700, Junio C Hamano wrote:
>
>>              (                                         103) 
>>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>>              (                                         105)         test...
>>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>>              (                                         107)         test...
>> 
>> which does away with the misleading information altogether.
>> 
>> I myself is leaning towards the latter between the two, and not
>> overriding "-b" but introducing another "cleanse the output of
>> useless bottom information even more" option.
>
> Though I rarely use boundary commits, this one makes the most sense to
> me (when I do use them, I just mentally assume that the information in
> the boundary line is useless; this is just making that more apparent).

It is unclear to me what "this one makes the most sense to me" is
referring to, in particular whether it encompasses the "and not
overriding" part of the paragraph.

-- 
David Kastrup
