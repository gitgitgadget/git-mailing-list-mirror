From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 04:28:46 -0700
Message-ID: <7v4p3jl6a9.fsf@gitster.siamese.dyndns.org>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
 <20081011074604.GA23883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 11 13:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kocfo-0001XH-9N
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 13:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbYJKL3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 07:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYJKL3B
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 07:29:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYJKL3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 07:29:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7ED98893DF;
	Sat, 11 Oct 2008 07:28:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 62722893DE; Sat, 11 Oct 2008 07:28:49 -0400 (EDT)
In-Reply-To: <20081011074604.GA23883@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 11 Oct 2008 03:46:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CBB6558E-9787-11DD-A100-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97970>

Jeff King <peff@peff.net> writes:

> On Sat, Oct 11, 2008 at 07:37:04AM +0100, Alex Bennee wrote:
>
>> I've just tested/reviewed a patch of someone elses and I want to
>> forward it on the appropriate mailing list. I gather for Linux you
>> just add the appropriate tags to the commit. Does git offer a shortcut
>> for doing this or do you have to do a reset HEAD^ and re-commit with a
>> copy&pasted and modified commit message?
>
> Try "git commit --amend" to edit the commit message. There's no
> automatic way of adding acked-by or tested-by tags with git; most people
> who do those things often would probably configure their editor to make
> it easier.

These Distimmed-by: fields are cumulative in nature, so once recorded in a
commit log message you cannot add new ones without amending, which means
you cannot exchange such commits by pushing or pulling but by forwarding
patches via e-mails.  I thought people added these in their MUAs.  IOW, I
share your "would probably" with s/editor/MUA/.
