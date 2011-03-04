From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Thu, 03 Mar 2011 22:00:27 -0800
Message-ID: <7v4o7j8lxg.fsf@alter.siamese.dyndns.org>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <7v8vwv927a.fsf@alter.siamese.dyndns.org>
 <AANLkTimG7Hg4YxJbMVaXVkZ1CRb0ttK6RAYEoRQ_4iW4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 07:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvO4J-0006Ze-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 07:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab1CDGAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 01:00:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab1CDGAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 01:00:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C1054F89;
	Fri,  4 Mar 2011 01:01:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=izH7PHGB5AZz54uqY/uDKXYRVXM=; b=BaRM62
	TfsCDRsb0/P6dbk//kLbJ/KxHEjN+CJ8G0Kwb6lnCvFAqc1lh5eJdSiuS2Wpm8Ta
	58YFHyvMTLJekxbxLw/OjB8GDKK9gsl0yduLi68AXRXgBNeHF+8Dq8xJLTz+fIVK
	buxBWikBxzeWbKH7md+RTKBCgLdDHc4YeCCaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=duSn3V13WEXBNqWBcygJ7XT8QvX5ze5c
	IhHQAE0iBhQ8KqJay5o7aJd1GAcOYtRx0GzmqCSYJ82NPgifoNNSlwI4d0EwNyt3
	55SNVokxJctorZn9cZaAU3Th+Ehu6J4MyiKtQ2dLqjiUzGttW8owF2hK36PplqFS
	1HgX5owkPTo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 244FB4F88;
	Fri,  4 Mar 2011 01:01:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C32D44F87; Fri,  4 Mar 2011
 01:01:51 -0500 (EST)
In-Reply-To: <AANLkTimG7Hg4YxJbMVaXVkZ1CRb0ttK6RAYEoRQ_4iW4@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 4 Mar 2011 11\:23\:18 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E84A8C1C-4624-11E0-B0E2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168428>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Moving .git away from existing repos/worktrees I have.

You are only saying you want to move it, not saying why you want to move
it.

That is not an explanation _why_ it is useful to be able to do so.
