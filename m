From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] git-cherry-pick: Add keep-redundant-commits
 option
Date: Wed, 11 Apr 2012 13:47:48 -0700
Message-ID: <7v62d6j8qz.fsf@alter.siamese.dyndns.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 22:47:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4SL-0002qu-6u
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 22:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761172Ab2DKUrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 16:47:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab2DKUrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 16:47:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3AE360C1;
	Wed, 11 Apr 2012 16:47:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fqatr/mrcgHa9jgiGrz2uz1AXbc=; b=v/M4+e
	3H5uDYnK73b+GPlUmtUXnYRp4jwGMxjIdTNYGBvPSegKjDKndVb8nNvT6Hl+Fqd9
	aXrZGYZv0Qz7dgUQGeZBoqX4D9ebAItCU6w/6xcLrBw2JROKBFGwhTyRAtu1bRjv
	PqqTEq5ZcyV1bKfqkDqSmA9QDfLd8y8LteOig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKicwWe38A6+ox8gRekyTPPmLAewfcsv
	B/4y/OxrSZ9K/M90m3ehvz8RiKLPEG4sCpKa7JXlVQ9EcTSEJtpcoeNMlJ/wzP3K
	1FsdIgj2eQ3Mu1wTf60Qg8SdWVyKJPXzlf+PLV0UlMFH257tt9t/gZvbHTtk3KLf
	z1NMmS9OuGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB40460C0;
	Wed, 11 Apr 2012 16:47:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F09E60BF; Wed, 11 Apr 2012
 16:47:50 -0400 (EDT)
In-Reply-To: <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Wed, 11 Apr 2012 16:21:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A1F71EC-8417-11E1-AE74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195252>

You inherited the following from your previous round.

Applying: git-cherry-pick: Add keep-redundant-commits option
/srv/project/git/git.git/.git/rebase-apply/patch:115: space before tab in indent.
 			 * The head tree and the parent tree match
/srv/project/git/git.git/.git/rebase-apply/patch:116: space before tab in indent.
 			 * meaning the commit is empty.  Since it wasn't created
/srv/project/git/git.git/.git/rebase-apply/patch:117: space before tab in indent.
 			 * empty (based on the previous test), we can conclude
/srv/project/git/git.git/.git/rebase-apply/patch:118: space before tab in indent.
 			 * the commit has been made redundant.  Since we don't
/srv/project/git/git.git/.git/rebase-apply/patch:119: space before tab in indent.
 			 * want to keep redundant commits, just skip this one
warning: squelched 3 whitespace errors
fatal: 8 lines add whitespace errors.
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 git-cherry-pick: Add keep-redundant-commits option
