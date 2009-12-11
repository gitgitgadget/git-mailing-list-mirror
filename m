From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 18:50:53 -0800
Message-ID: <7vk4wu6x6a.fsf@alter.siamese.dyndns.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
 <m34onye3h8.fsf@localhost.localdomain> <4B21AC4D.2020407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 03:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIvb8-000426-HX
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 03:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762244AbZLKCvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 21:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762237AbZLKCvA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 21:51:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762225AbZLKCvA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 21:51:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70086A55A1;
	Thu, 10 Dec 2009 21:51:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KBbr3qjK3wX1qSxxTzKIfRb1zIQ=; b=wfcTxs
	z9tN4T3YdMQAELgnXp4uUsFQ45rQ7OSgK10dHwnFS51aLG+25UcYpPK7GqBLZFsr
	8EdwzKvGL0aw2fpPR9H2YxR/0nryByuAo7k2PwQTcGp1tcVLPNZJpw7fOz1Mc1Zb
	fVVpvpf02Wwl5Eb6vLZBrlr/v5S71rEjWauzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l8UHtfwdNQ0LEFs8o9owhl6k12GcDSTW
	GRjGtR+r+TAc1OET/MjA9FV17eqb1M+MPultoq3NcZaqieqWxKW9P4LeRShadiUQ
	xQhMYt1DyAeeGawjXRQpVxshYjlNIx+49007nCh1ojJkiL/U8kZnSuonuDBJaSv4
	JfwjG/CRdPs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31E92A55A0;
	Thu, 10 Dec 2009 21:51:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B94B1A559F; Thu, 10 Dec 2009
 21:50:55 -0500 (EST)
In-Reply-To: <4B21AC4D.2020407@kernel.org> (J. H.'s message of "Thu\, 10 Dec
 2009 18\:19\:57 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 042513CA-E600-11DE-89AC-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135067>

"J.H." <warthog9@kernel.org> writes:

> It was intended to be the most minimal possible, mainly get in, get
> out. Also not sure the die_error existed in gitweb when this was
> originally written.  Probably worth switching to it now since it's
> there either way, and I don't think using it would add enough overhead
> to matter.

Thanks; all sounded a reasonable response to the review.  Are you
re-rolling the series anytime soon (I am asking because then I'd rather
not to queue this round especially because I didn't see 5/6).
