From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 14:09:33 -0700
Message-ID: <7vzk5uzgqa.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <502D5D97.3020906@kdbg.org>
 <7v4no21raw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@suse.cz>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 23:09:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T27K2-0000ut-UA
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 23:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353Ab2HPVJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 17:09:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab2HPVJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 17:09:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 366928ED2;
	Thu, 16 Aug 2012 17:09:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vp9ro5rY1E7Ftfx/PEur17wMeuU=; b=Q6jzli
	TbtUYnVBZE0x3xMYuouksUumoRBeQELavsB6ULXZAtJ+kHGMXSdRElDTRO9FSk7S
	omfELtkYIFb5ZwaJTgw6Ngofz7Ul8lgrb7VN66jedJ7R3yxrSrUTeQuTxmRaZrZd
	TDQId/gYI1SXlyo4ppMB4oO+AAXCVjKc81OmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xu7+Gz4mo6RRbC7j3i9xQUR3tYXrpdB0
	9az6kzthbx2edxBscZIU4eaYpP+kj/fpkunxPQKaEZ7ERfgq2iSmF1wdGJDX4eyw
	0jOK5dHUqSc2Dtg6eCN2GS27c+6OiIPwYH6FN7NB4C1xu3ePEjLPhmDo1152yJSy
	zioBoav4cdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 232F78ED1;
	Thu, 16 Aug 2012 17:09:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BA458ED0; Thu, 16 Aug 2012
 17:09:34 -0400 (EDT)
In-Reply-To: <7v4no21raw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 16 Aug 2012 14:05:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE03E804-E7E6-11E1-AC42-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Are you sure? This adds '-r', not '--r', i.e., the single-letter option
>> 'r', to the documentation, which is not something we want to hide, usually.
>
> I actually think "--rebase" squatting on short-and-sweet "-r" was an
> accident, and we are saved by not endorsing "pull -r" by documenting
> it.  We can still use "-r" for "--recurse-submodules" if that proves
> to give more value than "--rebase" to our users.
>
> So I dunno.  I personally do not think either deserves a short-and-sweet
> single letter option.

I guess the above needs a bit of clarification.

The reason I do not think "pull -r" gives much value to the users to
trigger "pull --rebase" is because the use of "pull --rebase" is
very project specific.  If you are working on a project that forbids
merges, you would _always_ want to run "pull --rebase", which means
you would likely have it configured and would not be typing from the
command line.
