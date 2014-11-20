From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Thu, 20 Nov 2014 10:05:07 -0800
Message-ID: <xmqq1tox4ujw.fsf@gitster.dls.corp.google.com>
References: <20141120011136.GC6527@google.com>
	<1416505150-1913-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sahlberg@google.com, git@vger.kernel.org, mhagger@alum.mit.edu,
	jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrW6Z-000800-NU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbaKTSFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:05:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756740AbaKTSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:05:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 818561ED75;
	Thu, 20 Nov 2014 13:05:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2WQhEYrYIfW2A+MtkpYEEyA31ZQ=; b=j4EQzF
	y1KgmHqR3E6cDo3yVlPLTxnAmzwytWNqUEPae/2YruIoh3UHJDE8PTp1yMej3paJ
	Y/e+35OM1XF730Q1TBk5CLJfS3fl+GmNXHKR/7X91kMFc6AGyc5S8UgNGKmq085r
	Ti/eKPrDTx3kRnfW8aG+jLaxGyQHWCEIStvuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x1BLBbM4ZPizlk7Tk5/8Jk3gy2vq7Klf
	J1zZDepT/dA2wN8cTF869WN4UGkVyvq2fv2/T6O8MWqIaMwDCeR8JLRl+Y0pHvfo
	lPTjAWr3VEgGssZtk4y3/Nza6EsP4xWmnxBdFN9v4w2xrc1fTlp49UgPPPxibCyJ
	SlINvxd9oAk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E8F31ED73;
	Thu, 20 Nov 2014 13:05:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB9331ED72;
	Thu, 20 Nov 2014 13:05:08 -0500 (EST)
In-Reply-To: <1416505150-1913-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 20 Nov 2014 09:39:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C38846A0-70DF-11E4-99BE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks; I think these match what I locally amended just now ;-)
