From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git stash -k show the help message for diff-index
Date: Wed, 05 Oct 2011 10:43:02 -0700
Message-ID: <7v4nzn8hcp.fsf@alter.siamese.dyndns.org>
References: <vpqfwj7v5cx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:43:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVUu-0002iS-Na
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935160Ab1JERnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:43:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934662Ab1JERnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:43:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2C15224;
	Wed,  5 Oct 2011 13:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vVdT5Se2xQRqd5OWX9RSv0QGhMY=; b=nwRWYI
	Q8Xnk21VfvxTku925nkswYoIBBEEsxhcJxyXBVqjfJ28s/K/Cw/J8eF0TyVC4afF
	1lXAUKsO+ZdV5OrFFcviI7n63rG6KjICmsaBkyec9H8IYJL9bUd7kpwKGsOsCmsN
	B2S/Pjfeg3H6lGhekQO4VOrH1UFreh2xKWWKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mHkTLMK4prtulvo9NC4EHLzReWqLAdi5
	lXvWVZ8Z19W/ZFbxzl7npgEgMUGTbszv/JOgqgtGUVdd6juSuikGxBxTAF10Zbff
	PalyEjWAF/FfrrMPVOhxjZObVgQsR0qENljpwRSla5T4vkbww8G36bbFZLdwAjRw
	IZ4J0yZs/vg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 588085223;
	Wed,  5 Oct 2011 13:43:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEA5F5220; Wed,  5 Oct 2011
 13:43:04 -0400 (EDT)
In-Reply-To: <vpqfwj7v5cx.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 05 Oct 2011 17:13:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A970E3A-EF79-11E0-BBD6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182868>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Everything is in the title. No time to bisect/fix this now, but:
>
> $ git status
> # On branch master
> nothing to commit (working directory clean)
> $ git stash -k
> usage: git diff-index [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]

Hmm, does not reproduce.

: alter victim-2.git/master; git status
# On branch master
nothing to commit (working directory clean)
: alter victim-2.git/master; git stash -k
No local changes to save
: alter victim-2.git/master; git version
git version 1.7.7
