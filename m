From: Junio C Hamano <gitster@pobox.com>
Subject: Re: encoding bug in git.el
Date: Fri, 30 May 2008 13:27:43 -0700
Message-ID: <7vod6nk05c.fsf@gitster.siamese.dyndns.org>
References: <20080520220900.GA20570@diana.vm.bytemark.co.uk>
 <87mymkbo9x.fsf@lysator.liu.se>
 <1f748ec60805210708q34a26bebh915037713caa9a87@mail.gmail.com>
 <20080525134200.GA31990@diana.vm.bytemark.co.uk>
 <20080530122826.GA4937@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clifford Caoile <piyo@users.sourceforge.net>,
	David =?utf-8?Q?K=C3=A5?= =?utf-8?Q?gedal?= 
	<davidk@lysator.liu.se>, git@vger.kernel.org,
	"Junio C. Hamano" <gitster@pobox.com>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 30 22:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BDd-0002MQ-Jq
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbYE3U2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2008 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYE3U2A
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:28:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbYE3U17 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 16:27:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAA8B2397;
	Fri, 30 May 2008 16:27:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 191E12395; Fri, 30 May 2008 16:27:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3881ACC-2E86-11DD-92EF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83328>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-05-25 15:42:00 +0200, Karl Hasselstr=C3=B6m wrote:
>
>> On 2008-05-21 23:08:09 +0900, Clifford Caoile wrote:
>>
>> > Here is a proposed fix.
>>
>> I don't claim to understand any of the design issues around this,
>> but your patch certainly fixes my problem (once I managed to apply
>> it, which involved working around the lack of headers, non-matching
>> offsets, and whitespace damage -- luckily it was just two hunks).
>> So:
>>
>> Tested-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>>
>> Thanks for taking the time.
>
> How are things going with this fix? Junio, I expect you're waiting fo=
r
> a properly cleaned-up patch, possibly with acks from relevant people?

You expected correctly.
