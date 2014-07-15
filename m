From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 2/2] test-config: add tests for the config_set API
Date: Tue, 15 Jul 2014 11:26:37 -0700
Message-ID: <xmqqy4vuv5pe.fsf@gitster.dls.corp.google.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C55FB7.7060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X77RB-0003N7-Ht
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 20:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbaGOS0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 14:26:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58900 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbaGOS0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 14:26:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B691C28E87;
	Tue, 15 Jul 2014 14:26:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syXZXBuITbDmG7TzjTyU9TCrr/g=; b=XRPzvi
	RCRzb0Laoa2jBlWFN/0L4Mh9fwzZYz2zyE/2Eeqvnqn/wp+G7n5Bit5Q4jFZ4omW
	EEs9Y2elvaKXlOxvKrf9xljLUri1B1PVgijpQLKhVh0yaEu474EPLaeMQnvoxaPZ
	GMGUVf6wsi9sB3wWIZus5jegt1CT98yH939tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TX8k/N7Jjs+2sti58YyMShTHFr2+JTDM
	uDzAH+p6t7hqG+rIptWNblB6PuOtJaUtY0wrNyYAzQ+ekLNQ+LoBDlEJh9kkLALb
	2RHoXnsInfx/uL13quhaZtSwhbq8bdnFI64C5ReSv1hpeJ+EzoiM5XxOeopvNevh
	B68qA7S3VRw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA5FA28E86;
	Tue, 15 Jul 2014 14:26:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A8FE28E80;
	Tue, 15 Jul 2014 14:26:21 -0400 (EDT)
In-Reply-To: <53C55FB7.7060405@gmail.com> (Tanay Abhra's message of "Tue, 15
	Jul 2014 22:37:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8507E8A0-0C4D-11E4-A957-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253580>

Tanay Abhra <tanayabh@gmail.com> writes:

> ... I need it for
> test_expect_success 'proper error on error in default config files' '
> which requires me to compare the line no at which the error was found.

I see.  We may want to later rethink the way you validate the line
numbers, but in the meantime I think the version posted should
suffice, if you cannot do better than that.

Thanks.
