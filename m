From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Wed, 15 Jun 2016 13:21:00 -0700
Message-ID: <xmqqvb1a5hlf.fsf@gitster.mtv.corp.google.com>
References: <20160612191550.GA14160@elvis.mu.org>
	<20160615051950.GA93388@elvis.mu.org>
	<20160615201556.GA6303@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alfred Perlstein <alfred@freebsd.org>, git@vger.kernel.org,
	Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:21:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDHJG-0001oC-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 22:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbcFOUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 16:21:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753129AbcFOUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 16:21:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3009324451;
	Wed, 15 Jun 2016 16:21:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ar3fuWSo6cH74CSzNIVCNJtH1A=; b=IlIh8T
	kKywuKc54EgRlgOSTbRSRENsJDNVm/7D/Pyrr2Nb5W5zVytFm/JoJGSCJVrtmgGc
	ZehzqCSAkS45It/gvsf3duq4a+t6LXxBYSblheFvZr4+R58KMc+CkR3HQm6c50AA
	qN54vUx4FwCWKEr5F1j8daDBIaffHfSAOOxx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKT8N32udPUtbGe3nkTPT95PqOoxXP1z
	pzmV5r1CFd1wcF+NoG72F3mwv32Brk/RoR/0kEy1f3GYb4lObMKZZspT0iw7wEbP
	3/mUSYmx8Z1A0zUtYIX7Pn+pX0ODttEywwz4djJMmvHUmKvmct3Qq3A1RtjxLnsC
	w5w/H3jBcU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 270F624450;
	Wed, 15 Jun 2016 16:21:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A42CB2444E;
	Wed, 15 Jun 2016 16:21:02 -0400 (EDT)
In-Reply-To: <20160615201556.GA6303@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 15 Jun 2016 20:15:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE4BEC2C-3336-11E6-88FB-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297397>

Eric Wong <e@80x24.org> writes:

> Thanks Alfred,
>
> I've removed the '.' from the commit subject, signed-off,
> and pushed to my repo for Junio:
>
> The following changes since commit 05219a1276341e72d8082d76b7f5ed394b7437a4:
>
>   Git 2.9 (2016-06-13 10:42:13 -0700)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git svn-propset-doc
>
> for you to fetch changes up to f3961b2eba8ba6aa2fddc827ddf5c26b41391872:
>
>   Document the 'svn propset' command (2016-06-15 20:11:22 +0000)

I actually queued it directly on top of v2.3.0-rc0~32^2 (git-svn:
support for git-svn propset, 2014-12-07) so that it could go to
older maintenance tracks.

I will pick up your Reviewed-by: and redo it.  Thanks.
