From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/2] git-remote-mediawiki: import "File:" attachments
Date: Thu, 14 Jun 2012 10:47:58 -0700
Message-ID: <7vhaudeqep.fsf@alter.siamese.dyndns.org>
References: <1339676798-6286-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfE9W-0005K1-RG
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab2FNRsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:48:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756047Ab2FNRsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 13:48:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4460F89FF;
	Thu, 14 Jun 2012 13:48:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IwXlFOpcZDOBj6W2TAkHBtWe3NI=; b=B1WIs3
	32ZNkLU9KxsN7W92M3twTH2j/cqDj35w9PRf1Tlqei7BTwklyDk9xA9g1PKyn2oH
	XrQYv61fTOSU69QkaqU2W0pMX3GeR+YFVce1orf+1xHl9jX/NDFKuXWf2DDmSl0G
	zXg0/rL+gwlJeGKoaDLsRo4uTdGL9k5A3+d7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sjcw6m7LTnzyLz8FppRrgE2Uh4GMjbJO
	0dj/0Rl7sbb2t/kUmERUqqEWKp8rZ+9961Oi1+6/akG2q4ocx4o/pKVUByzCwIB3
	ESbRzqAEeYy7fUyPETPWFdc4Uq+yiFwFI5YHEOXSXd0K6iWWkpBBof4x02xmg+/L
	CCiaoa1EGLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36ABB89FE;
	Thu, 14 Jun 2012 13:48:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B514589FD; Thu, 14 Jun 2012
 13:47:59 -0400 (EDT)
In-Reply-To: <1339676798-6286-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
 (Pavel Volek's message of "Thu, 14 Jun 2012 14:26:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14E95EFC-B649-11E1-9487-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200026>

It appears to me that 2/2 should come before 1/2 so that addition of
attachment support will build on a cleaned up codebase.

Also a part of 1/2 that teaches the get_mw_first_pages function not
to feed too many titles at once may be better done as a separate
patch that is done before addition of attachment support.  There may
be other things 1/2 does that should be separated into a series of
preparatory clean-up patches, but I didn't read it very carefully.
