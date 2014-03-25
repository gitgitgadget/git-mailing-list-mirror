From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #05; Mon, 24)
Date: Tue, 25 Mar 2014 09:54:13 -0700
Message-ID: <xmqq1txqnrre.fsf@gitster.dls.corp.google.com>
References: <xmqqr45rpcjm.fsf@gitster.dls.corp.google.com>
	<533161F7.5010508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam <adam@sigterm.info>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 25 17:54:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUcK-0005bF-TY
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 17:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbaCYQyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 12:54:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbaCYQyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 12:54:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE49E7702F;
	Tue, 25 Mar 2014 12:54:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O8GCT4Qj4snDHGpb2H6ERLC95ks=; b=hSNXkf
	75MkL/7Fjb82OC46bgrokJBSgl+xbCMUkzBUc7Rlc1AitUv8P82xeDW+OO5v8js1
	yc3EFsewps6boc60KfXduiDtY25PXkp9qWQXq1+OYJ1mODDA1lijPNw20JViYhFA
	yvShbTqzZw5qiAxp6N/kq44tIfKgoewPlaa1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LwhyAy0wRIq3CKtEwHB4DBxAKZVAb4hz
	OZj0lPMSaoE87oBpIWOuJLsD0PWfyaAOYH1Qe5Lme+PcCEnXm6wzkG/mjHjr3Eb+
	2bPTgS7xzxDQjlRdwjDb1hg95D/+yhXSDx1jXo1SD+TG8qB7uvIzVqQ8tpKHfVWR
	EOGWKbrK0YY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC8A7702E;
	Tue, 25 Mar 2014 12:54:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ECB17702B;
	Tue, 25 Mar 2014 12:54:17 -0400 (EDT)
In-Reply-To: <533161F7.5010508@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 25 Mar 2014 12:01:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1A36E042-B43E-11E3-8FF4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245043>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/24/2014 09:27 PM, Junio C Hamano wrote:
>> [...]
>> * an/branch-config-message (2014-03-24) 1 commit
>>  - branch.c: install_branch_config: simplify if chain
>> 
>>  Will merge to 'next'.
>
> The Signed-off-by line in this commit shows the name as only "Adam".
> Adam, unless this is your full name, please add a S-o-b line with your
> full name as per Documentation/SubmittingPatches.  This is important to
> help us track the provenance of all code in Git.
>
> Michael

Thanks for bringing this up.

But for this particular change, I think there is very little that
could become problematic on the provenance; there are only 34 sane
ways to switch on two independent boolean variables to choose one
out of four actions, and they are all similar and obvious.
