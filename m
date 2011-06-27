From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] rebase --rewrite-refs: tests
Date: Mon, 27 Jun 2011 14:02:36 -0700
Message-ID: <7vy60nugwj.fsf@alter.siamese.dyndns.org>
References: <cover.1309133817.git.greg@quora.com>
 <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jun 27 23:03:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbIxT-00005x-4M
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 23:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab1F0VDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 17:03:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab1F0VCj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 17:02:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B02315A95;
	Mon, 27 Jun 2011 17:04:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XNQH7B5ahZc/q8Pmzd3kOaLQsHw=; b=bE22ed
	rnOTBY/95WimVPjuAeKxLiozFTB1qxSQK9TeV9PCaPe+8nZnwyHt2wBwELoNjwaf
	Q/S0s6I52639mZI1wo9+6bUw9yxU8d6rCgCD2AXR5nyKgHTR4+d9AUMs8b88kFGf
	mne/uZ7sKqDkWb6O4oN3D/0rLI1W6u1h9UKGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yWh6ZafTbxVsL04ZAZ0BcZGtf2FgisjP
	llHzv/SmC/PWQIhYDaS7uCPpud4DiAjBYPsDacmxt8cIY1qLU1593/NU+2ohPLs5
	uIDHWNutcfgp6dQyUPhaWACXD5B/AlF+WyR41QGTo7rYqHpePTjnTcqAoWDQnul7
	rtK4FCHZjf8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9BC275A94;
	Mon, 27 Jun 2011 17:04:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A2285A93; Mon, 27 Jun 2011
 17:04:50 -0400 (EDT)
In-Reply-To: <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com>
 (Greg Price's message of "Sun, 24 Jan 2010 21:28:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 192C8542-A101-11E0-8366-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176369>

Greg Price <price@MIT.EDU> writes:

> diff --git a/t/t3420-rebase-ref.sh b/t/t3420-rebase-ref.sh
> new file mode 100644

Forgot the executable bit?
