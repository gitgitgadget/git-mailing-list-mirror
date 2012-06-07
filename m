From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Thu, 07 Jun 2012 10:54:27 -0700
Message-ID: <7v3967huss.fsf@alter.siamese.dyndns.org>
References: <m24nqoohss.fsf@gmail.com>
 <CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
 <4FD05B45.2090006@alum.mit.edu> <7vd35bjcd6.fsf@alter.siamese.dyndns.org>
 <m23967vynk.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Adam <thomas@xteddy.org>,
	John Wiegley <jwiegley@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scguo-0001Js-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759782Ab2FGRya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:54:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756560Ab2FGRy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:54:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FBF28239;
	Thu,  7 Jun 2012 13:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8MLjkbpbZ9i8xyaIdd/jTNG1rQE=; b=e/7rMB
	pwg3FPQjtE0LvYZkCmMWIKhaIk/bdVpz1WPRpYUnqc1OfZne///HLymf5Kidh/sB
	t8n4P/4i3aJepgu42aAPOzhKk6E7wKzwG/PYrOjf0ZCIcpm0/HDqEJxFAGCnRJbl
	F6lQ4ZMrV9yTSZhCS1CE6yGZwn/1Cz/TpH1JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IlnboNT9TCuZFdBW1pEWHMkG0ZQ+tmED
	aRzEK7Wkuc9kdUhr3NMFbEpCeFP6jqkCmwsM6ZX27XIJGG/YmKSh1fEba6a8y3Bq
	l1EddPs8ku3J6HOfjRuMwaOQ5SgQGsOsaj74PNoXs2Sw97wrhfSXP7+01iaWLUcl
	u2qRacw+y/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0632B8238;
	Thu,  7 Jun 2012 13:54:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 941958237; Thu,  7 Jun 2012
 13:54:28 -0400 (EDT)
In-Reply-To: <m23967vynk.fsf@igel.home> (Andreas Schwab's message of "Thu, 07
 Jun 2012 19:07:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3CD3454-B0C9-11E1-BA89-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199428>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Only if the conversion is restarted from scratch.

Yes, that was the use case I was the most worried about.

Often a re-import is one way to validate what you have (and worse
yet, what you based your recent work on), so unmatching commit
object names are red flags.
