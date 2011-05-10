From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --interactive commits order
Date: Tue, 10 May 2011 15:56:41 -0700
Message-ID: <7vbozai2qe.fsf@alter.siamese.dyndns.org>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
 <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvrK-0007za-5j
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab1EJW4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:56:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1EJW4s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:56:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E93E64AC4;
	Tue, 10 May 2011 18:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HTh3ZYd4BaOVjs3P7MKZDgFFwPY=; b=pRP7Ks
	48fCUoWy1yiBGdnCpwn6dnOGP23OnMNI50cscG/l/BLEbF/XLf2cdwmPTRXpOHF7
	hKqiXceYMsnSSAiucRmxnQ+iJq/h09ULcovV3l69K43ZS0XjZb2h866U78egcowX
	chBiiDMt1TF8kF3RF9TaN0Rq/CeLTeCJDIAz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qP0WROGSbr47FxOBx3DGorRFIbWIXKOQ
	NPhUBLSeciikOiDLm1EP3TSjSf9aF90z51nrB48y3XN5IjBUDfHOwJ2rMWv3v4Z/
	t3Wg2BScAfWx2inI+ybvVSboPRWUzLi8EZ6S7u7Q8ZggM30YIqkMfMRjkCLwQmDX
	BUH6mj9ig7w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C74964AC3;
	Tue, 10 May 2011 18:58:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB7054AC2; Tue, 10 May 2011
 18:58:48 -0400 (EDT)
In-Reply-To: <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com> (Philippe
 Vaucher's message of "Wed, 11 May 2011 00:20:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12B68852-7B59-11E0-9D7F-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173379>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> So, sounds like most people agree with me.

No. You have to realize that happy majority are usually silent.

It is just most people including me know better than reading your thread
and filling the thread with the same "I have been completely content with
the current order to read from top to bottom when reading text at the
beginning of the screen (i.e. in the editor); do not change it".
