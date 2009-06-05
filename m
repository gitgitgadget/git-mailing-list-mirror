From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diesys calls die and also reports strerror(errno)
Date: Fri, 05 Jun 2009 00:12:34 -0700
Message-ID: <7vtz2vnogt.fsf@alter.siamese.dyndns.org>
References: <20090603015503.GA14166@coredump.intra.peff.net>
	<1244081105-7149-1-git-send-email-aspotashev@gmail.com>
	<20090604205055.GB17478@sigill.intra.peff.net>
	<4A28BA3E.3090800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 09:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCTbZ-0002yw-6t
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 09:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbZFEHMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 03:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZFEHMe
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 03:12:34 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42449 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbZFEHMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 03:12:33 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090605071235.WTGO20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Fri, 5 Jun 2009 03:12:35 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 07Ca1c0074aMwMQ047CapE; Fri, 05 Jun 2009 03:12:35 -0400
X-VR-Score: -300.00
X-Authority-Analysis: v=1.0 c=1 a=k8_L9D1VAZ4A:10 a=H2s_CUdDsewA:10
 a=fv-XvKvnAAAA:8 a=RB7-gqc0tDfY2q0_tAwA:9 a=OLldfls-R2qTr9Q0XJDB3_Y5JhEA:4
 a=l9rlz7MJbUIA:10
X-CM-Score: 0.00
In-Reply-To: <4A28BA3E.3090800@viscovery.net> (Johannes Sixt's message of "Fri\, 05 Jun 2009 08\:25\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120757>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jeff King schrieb:
>> On Thu, Jun 04, 2009 at 06:05:05AM +0400, Alexander Potashev wrote:
>>> +void diesys(const char *err, ...)
>
> Am I the only one who thinks that 'die_errno' would be a better name for
> this function?

You are not alone.  I did find diesys() unreadable, but simply did not
think of an obviously better alternative like you did.
