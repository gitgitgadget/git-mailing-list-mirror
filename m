From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add option to preserve user names
Date: Thu, 05 May 2011 22:07:40 -0700
Message-ID: <7vy62k2z8j.fsf@alter.siamese.dyndns.org>
References: <1304577819-703-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri May 06 07:07:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIDGh-0001dF-4t
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 07:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab1EFFHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 01:07:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1EFFHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 01:07:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EE632013;
	Fri,  6 May 2011 01:09:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4VkhlvGjGOXhI/JilWOsI3wy718=; b=BqXU5A
	1JQi/qXfli3c4KKj1s9yPmfQNPNq/FZrNz1CHaFpgY0wEx4E4j2FsOiUf9vO7YVu
	EsGIwh1SgQjda4WqddGdrZigW3NiqO1xUZTy6uAdoYKmQduDZ6837rmOoZe/TJET
	4nGiZyaVGabUkFU9tR11wOO0+J9m1DHe+/A60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZ5f9etYgsOXKbf+UuuA9YFcXddkYOAj
	5i5EL27Rij3HnxEp8sLu+HHaPuZaxHS2XFGyZuaDv4zNCBiNcJjOrN41EqwR0Tq7
	Tiguieoi1IVXOYDVaWh11IgDsEhB2IyMzRWUyBbloXyYUKIGfKMcSmvpzQfzRvqr
	yLvYQJbPzf0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DADA2011;
	Fri,  6 May 2011 01:09:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3D3C22010; Fri,  6 May 2011
 01:09:44 -0400 (EDT)
In-Reply-To: <1304577819-703-1-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Thu, 5 May 2011 07:43:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11251A3E-779F-11E0-9030-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172940>

Luke Diamand <luke@diamand.org> writes:

> This is version 3 of my patch.

The previous one from Apr 21st is already on "next" with Ack from Pete.
