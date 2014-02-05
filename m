From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/13] Makefile: drop *_SQ variables
Date: Wed, 05 Feb 2014 11:14:08 -0800
Message-ID: <xmqqiost4bjz.fsf@gitster.dls.corp.google.com>
References: <20140205174823.GA15070@sigill.intra.peff.net>
	<20140205175859.GJ15218@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7vN-0005tc-G0
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbaBETOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:14:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaBETON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:14:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EE6A69ED7;
	Wed,  5 Feb 2014 14:14:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3pjq5cZJKnf59fhLaqX4L48LZC4=; b=O7DDo9
	cOaMX/iWzy+SClD93HYYBj3deH04oM+oTNUggjhv+T+h6FVTpgh+dN7h27nYcA0h
	XLcEuP4ybXCESUJbnUY/IJJweBYVAKkvndDYk2RHsa35NdPQ6SUF/LXn+FHFcDIh
	Eh6d97MU88MQF76bzKdMLxGKFs/SAoZTlD+Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fHc3jKqV1hEYfETWbA1NPkl9Bqz1q9w+
	iuZNdvCihLGv3Q8pa3Dl8v+EEXpukYghuXI5HIx6FBO7eZXy/DcBaEiQExHtMbyU
	2Z1Lsa5KAVnL7SC6MSp9n9+v2KozcmESw2Wm1Rx4vV48tMmNtAqlMHFi+a9hls+m
	MEIfKYUCH9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 843B469ED6;
	Wed,  5 Feb 2014 14:14:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86A1069ECD;
	Wed,  5 Feb 2014 14:14:10 -0500 (EST)
In-Reply-To: <20140205175859.GJ15218@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 12:58:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B137D318-8E99-11E3-BB09-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241640>

Again, Yay!
