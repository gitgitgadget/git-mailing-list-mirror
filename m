From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disconnect stash from its base commit
Date: Wed, 02 Jul 2008 14:04:19 -0700
Message-ID: <7vprpw80bw.fsf@gitster.siamese.dyndns.org>
References: <20080702195947.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0807021447200.9925@racer>
 <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org>
 <20080702195401.GA17214@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE9WW-0000KL-3j
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYGBVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbYGBVEa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:04:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbYGBVE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:04:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2B7B4597;
	Wed,  2 Jul 2008 17:04:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F33394585; Wed,  2 Jul 2008 17:04:21 -0400 (EDT)
In-Reply-To: <20080702195401.GA17214@toroid.org> (Abhijit Menon-Sen's message
 of "Thu, 3 Jul 2008 01:24:01 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 74685432-487A-11DD-BDFF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87191>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-07-02 12:01:35 -0700, gitster@pobox.com wrote:
>>
>> 	But that imaginary "stash branch" command would always give you
>> 	the exact state you were in and creates a clean fork to finish
>> 	what you were doing, and continue.
>
> Nice idea. Something as simple as the appended diff?
>
> I reversed the stash/branch arguments so that one need specify only the
> branch name. Playing with it a little, it feels very useful.

I'd further suggest to delete the stash automatically when you create a
new branch out of it.
