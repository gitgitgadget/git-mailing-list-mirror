From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: --list option for git-branch
Date: Thu, 16 Feb 2012 10:07:37 -0800
Message-ID: <7vpqdezm6u.fsf@alter.siamese.dyndns.org>
References: <1329338218-9822-1-git-send-email-ralf.thielow@googlemail.com>
 <4F3CCC4A.5010100@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Feb 16 19:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry5kA-0006lS-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 19:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab2BPSHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 13:07:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab2BPSHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 13:07:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B752B7889;
	Thu, 16 Feb 2012 13:07:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=21Azl5uVGTCe
	MwoVxyWs0J3uT08=; b=tyxWm5/n4uZGXbbEoW3ztdgAWqjD015B7C3LXrAuGknx
	D9ww/4BTENWC+2PobzO4G8NrcvFpfdGN+5Kga5+gfDAMYnrZOd2lyVK+qbNmLXAG
	i9VeqXmDnGF0dzi018UknaR003nK+Xzobm0+17g2cbnrehCiyvQv/Ua7MbxQxe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uhRz8Q
	ACVy5GaFDAKKqNrXQyx3pdTAWC0wOas1nqePIgE7OybQ9hCSCZx2WsKhjm7TIjzu
	dJJ1uEAv6Mh+r5S/xHjxCx3NzbPLWNIgmbO/w3TV6URgVf2H1gqhmf+zut9egGG/
	cBzhMnqxB/iC2MdICzSBsAxzcnv0LXp9G8dWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE4757888;
	Thu, 16 Feb 2012 13:07:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FCF77885; Thu, 16 Feb 2012
 13:07:39 -0500 (EST)
In-Reply-To: <4F3CCC4A.5010100@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 16 Feb 2012 10:28:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CC384FA-58C9-11E1-950B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Normally one would use just a bare 'git branch' to list branches.
> Why would you want to use --list in an interactive environment (as
> opposed to a script)? Isn't it better not to clutter the completion
> options with something that the user actually has not need for?

        $ git branch jc/\*
        fatal: 'jc/*' is not a valid branch name.
        $ git branch --list jc/\*
          jc/advise-i18n
          jc/advise-push-default
          ...
