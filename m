From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: handle lines containing only whitespace better
Date: Tue, 19 Oct 2010 23:16:10 -0700
Message-ID: <7vzku9wfrp.fsf@alter.siamese.dyndns.org>
References: <1287549978-54280-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 20 08:16:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8RyI-0007TZ-CR
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab0JTGQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 02:16:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758000Ab0JTGQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 02:16:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF486E0D3E;
	Wed, 20 Oct 2010 02:16:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2nw00rVLXSXSqYlqgZDOA1yOkmQ=; b=NP2rJs
	Yg+gujMlFOUUu8L5/BsvbBmat+wI/dVJ3ihsSS8iKksCr7govjx6alJpwO5SJ+dt
	k+SOkN4qJnof0uWc0t4ca3LWbDdYuA/1lx5TLW+M/nKs0iPuJCKImTe0lwlL+6WR
	UrXJmMUGi8FS6Fny4rsvO/+ElK5/O/zUHzNfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=awhlaemnxXDSXyafnVZI1ubGAJk4uUT9
	Fn5KcmG0+B8HksPDwknuEa7brv/TumwUJpPudIJ4YvM5GnqEnU/KYeulO9Sk9B4b
	0wPsbuM51jgwiz5tAu9w8fmRO4XbkBfC0nyOxEEzx61DuiReJzaPspzYK2FSL8lR
	knKxaO0RJmQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7816E0D3D;
	Wed, 20 Oct 2010 02:16:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1920DE0D3C; Wed, 20 Oct
 2010 02:16:11 -0400 (EDT)
In-Reply-To: <1287549978-54280-1-git-send-email-kevin@sb.org> (Kevin
 Ballard's message of "Tue\, 19 Oct 2010 21\:46\:18 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8AE56B46-DC11-11DF-9A41-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159394>

Hmm, tests?
