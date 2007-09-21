From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Fri, 21 Sep 2007 14:15:10 -0700
Message-ID: <7vfy17iuu9.fsf@gitster.siamese.dyndns.org>
References: <119022570352-git-send-email-git@davidb.org>
	<20070920151637.GA26873@old.davidb.org>
	<7vodfxj6db.fsf@gitster.siamese.dyndns.org>
	<200709211220.05434.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYpqQ-0008MC-30
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763544AbXIUVPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763416AbXIUVPT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:15:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762216AbXIUVPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:15:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DAEC13981E;
	Fri, 21 Sep 2007 17:15:34 -0400 (EDT)
In-Reply-To: <200709211220.05434.simon@lst.de> (Simon Hausmann's message of
	"Fri, 21 Sep 2007 12:20:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58881>

Simon Hausmann <simon@lst.de> writes:

> On Friday 21 September 2007 00:53:52 Junio C Hamano wrote:
>> David Brown <git@davidb.org> writes:
>> > On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
>> >>On Wednesday 19 September 2007 20:15:03 David Brown wrote:
>> >>> git-p4 was missing the execute bit setting if the file had other
>> >>> attribute bits set.
>> >>> ---
>> >>
>> >>I'm fine with this, so unless you find a better way:
>> >>
>> >>Acked-By: Simon Hausmann <simon@lst.de>
>> >
>> > I sent out an improved version of this patch yesterday
>> > <1190232768445-git-send-email-git@davidb.org> that I'd like to get
>> > approved.  I guess I'm not quite sure what happens at this point with a
>> > patch.
>>
>> I still have that *768445* message as "the last one proposed as
>> better than previous ones" in my mbox.
>>
>> Simon?
>
> Indeed, the new improved version is much better :)
>
> Acked-By: Simon Hausmann <simon@lst.de>

Thanks.  This should go to 'maint' (part of v1.5.3.3) right?
