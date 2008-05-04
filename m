From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when
 they do a merge and see "file.txt: needs update".  "file.txt: has changes" is
 much clearer.
Date: Sat, 03 May 2008 17:08:23 -0700
Message-ID: <7v63tvszgo.fsf@gitster.siamese.dyndns.org>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
 <alpine.DEB.1.00.0805031509170.30431@racer>
 <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
 <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 02:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsRnP-0003xL-Ty
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 02:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbYEDAIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbYEDAIf
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 20:08:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYEDAIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 20:08:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2508410F;
	Sat,  3 May 2008 20:08:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6E40E410E; Sat,  3 May 2008 20:08:26 -0400 (EDT)
In-Reply-To: <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com> (Tim Harper's
 message of "Sat, 3 May 2008 14:10:48 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AF411FE-196E-11DD-AE78-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81120>

Tim Harper <timcharper@gmail.com> writes:

because it is very hard to follow the flow of thought.
Please do not top post.

> On May 3, 2008, at 10:57 AM, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Sat, 3 May 2008, Tim Harper wrote:
>>>
>>>> -			printf("%s: needs update\n", ce->name);
>>>> +			printf("%s: has changes\n", ce->name);
>>>
>>> How about "local changes"?
>>
>> Aren't there Porcelain and end-user scripts that relies on the
>> output by
>> doing "sed -ne s'/: needs update$//p"?

> I ran all of the tests with the patch apply, and they all pass.  Is
> that enough indication?

Of course not.  Where does end-user scripts come into play when you are
running the testsuite?
