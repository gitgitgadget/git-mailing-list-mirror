From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 08:28:22 -0700
Message-ID: <7vy5qv70mh.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
 <CACPiFCKbfgSZMnpc6Q_Lg6n5YMHQ2bad-bwQsyASk0eMuiAFTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA0zX-0003lr-In
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 16:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760510Ab2CTP23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 11:28:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758972Ab2CTP22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 11:28:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6557BA1;
	Tue, 20 Mar 2012 11:28:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOhbZg3wZeFZeq5XdJrOhyHwGNM=; b=c8wBmS
	jOdZ7ToLezjKiR1SREcFGtN0lj7YyB5Bfkb0Dv5pvOZqyuHsPitKz+r2yTnDpgNi
	QZkylvbVN9MtESQyyIjswmw7n0nWWO7yR758RL249wXlVS6ePuKzun6KPqJ6prU3
	SwVIov/8Uvr68uNTx4LVBubS8JcMGz/Ivfau4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=phqzvbQVAX3DKtnRg5F8vW0HwjoViuly
	Bah6fI/bPH9Q7qoU9gkDKy0lGLJABm33JC/blniXNd5grOmEtkxvrrB2eYL2lwY9
	1kfn3ldrjxaSP04bFRQUlxko0ERJKt+fR18+MIy1QSqfEfy6GqAyu1RjlsHZfGAw
	Pyoi92O2hyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24D8C7BA0;
	Tue, 20 Mar 2012 11:28:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C4AB7B9F; Tue, 20 Mar 2012
 11:28:24 -0400 (EDT)
In-Reply-To: <CACPiFCKbfgSZMnpc6Q_Lg6n5YMHQ2bad-bwQsyASk0eMuiAFTQ@mail.gmail.com> (Martin
 Langhoff's message of "Tue, 20 Mar 2012 10:12:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 556FBAD4-72A1-11E1-AACC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193513>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> --force should change behaviour, immediately, to "current" or even none
> (forcing the user to name the remote and branch explicitly).

Any "immediately" change is never going to happen merely based on "I
cannot imagine in what use case it is useful".

As many people already said in the discussion before the RFD message that
is at the root of this thread, the name of the option --force alone
already signals it is something you use after thinking twice.
