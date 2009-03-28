From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 18:30:42 -0700
Message-ID: <7v8wmq5t8d.fsf@gitster.siamese.dyndns.org>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <20090327090554.5d6160f2@pc09.procura.nl>
 <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 02:32:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnNPp-0006Xf-NW
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 02:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbZC1Baw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 21:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757074AbZC1Baw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 21:30:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbZC1Bav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 21:30:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DE12A5565;
	Fri, 27 Mar 2009 21:30:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5E1CA5562; Fri,
 27 Mar 2009 21:30:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 118CE756-1B38-11DE-8000-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114930>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Fri, Mar 27, 2009 at 12:50 PM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
>>
>> what made me wonder is this (about item 1): I thought I've read that blobs store
>> content and attributes, so very obviously I wondered why not store thr "right
>> attributes" (i.e. the time of the file). My reasoning: You make some changes, then
>> test them (which might last several hours or days). The if I'm happy I'll
>> "commit".
>
> With Git, you usually commit your changes immediately (without waiting
> the result
> of testing), because you can always undo commit until you publish your changes.

Heh, "can" and "usually" are somewhat different.  I don't.
