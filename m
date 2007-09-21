From: David Brown <git@davidb.org>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Fri, 21 Sep 2007 14:24:43 -0700
Message-ID: <20070921212443.GA14983@old.davidb.org>
References: <119022570352-git-send-email-git@davidb.org> <20070920151637.GA26873@old.davidb.org> <7vodfxj6db.fsf@gitster.siamese.dyndns.org> <200709211220.05434.simon@lst.de> <7vfy17iuu9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYpzq-0002gn-VZ
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbXIUVZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbXIUVZE
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:25:04 -0400
Received: from mail.davidb.org ([66.93.32.219]:45121 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbXIUVZC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:25:02 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IYpzP-0003uv-UR; Fri, 21 Sep 2007 14:24:43 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfy17iuu9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58882>

On Fri, Sep 21, 2007 at 02:15:10PM -0700, Junio C Hamano wrote:
>Simon Hausmann <simon@lst.de> writes:
>
>> On Friday 21 September 2007 00:53:52 Junio C Hamano wrote:
>>> David Brown <git@davidb.org> writes:
>>> > On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
>>> >>On Wednesday 19 September 2007 20:15:03 David Brown wrote:
>>> >>> git-p4 was missing the execute bit setting if the file had other
>>> >>> attribute bits set.
>>> >>> ---
>>> >>
>>> >>I'm fine with this, so unless you find a better way:
>>> >>
>>> >>Acked-By: Simon Hausmann <simon@lst.de>
>>> >
>>> > I sent out an improved version of this patch yesterday
>>> > <1190232768445-git-send-email-git@davidb.org> that I'd like to get
>>> > approved.  I guess I'm not quite sure what happens at this point with a
>>> > patch.
>>>
>>> I still have that *768445* message as "the last one proposed as
>>> better than previous ones" in my mbox.
>>>
>>> Simon?
>>
>> Indeed, the new improved version is much better :)
>>
>> Acked-By: Simon Hausmann <simon@lst.de>
>
>Thanks.  This should go to 'maint' (part of v1.5.3.3) right?

Sounds good by me.  I've been using it on a few other repos, and haven't
had any problems.

David
