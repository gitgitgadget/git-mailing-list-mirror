From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/15] config: make git_config_set die on failure
Date: Tue, 02 Feb 2016 12:58:42 -0800
Message-ID: <xmqqpowerfr1.fsf@gitster.mtv.corp.google.com>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQi2F-0001Id-47
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbcBBU6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 15:58:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756688AbcBBU6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21E8840995;
	Tue,  2 Feb 2016 15:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=24i7qfJ+uBKdTWa9GM8PcSWmHto=; b=eq0NSn
	sZPnIIA6SvEv3gnX4MeB9OGIuuZqLSBh9udrKXXeC/art3NUo1ii7vejbJZMtY6m
	R/pVmf/QGfk8NHdsuWh5rbli/VHK/7vPbNuVKDFytEs9yEHBxHQpmlRgIY9u1B2B
	9vCYLAjC+i8g96tiCBkSHUxf7WHW+pxSFDBjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PLT13fDLgz+mSjuTu3F0z1G/IsHPG1/j
	C5qrihbPhliUGKzkeOCPwb0bLvxcqyTqrsgWnvHiaPhyEsKL5RozIFjrV/s6F37T
	3n+Q66XvLgwvB9jgZL2qJkExqlLKNuyk+MIEVB7cJ6NL8jhm5Q3tziAY7JeVPgSe
	Uog6Z1Ryfvk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1826540994;
	Tue,  2 Feb 2016 15:58:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88D1340993;
	Tue,  2 Feb 2016 15:58:43 -0500 (EST)
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Tue, 2 Feb 2016 12:51:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE89E72A-C9EF-11E5-8F5F-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285308>

Patrick Steinhardt <ps@pks.im> writes:

> Patrick Steinhardt (15):
>   config: introduce set_or_die wrappers
>   branch: die on error in setting up tracking branch
>   branch: die on config error when unsetting upstream
>   branch: die on config error when editing branch description
>   submodule: die on config error when linking modules
>   submodule--helper: die on config error when cloning module
>   remote: die on config error when setting URL
>   remote: die on config error when setting/adding branches
>   remote: die on config error when manipulating remotes
>   clone: die on config error in cmd_clone
>   init-db: die on config errors when initializing empty repo
>   sequencer: die on config error when saving replay opts
>   compat: die when unable to set core.precomposeunicode
>   config: rename git_config_set to git_config_set_gently
>   config: rename git_config_set_or_die to git_config_set

They mostly looked sensible; I commented on things that I noticed,
but I don't think I spotted anything that needs a huge fix.

Thanks.
