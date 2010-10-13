From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/ciabot: git-describe commit instead of HEAD
Date: Wed, 13 Oct 2010 12:24:09 -0700
Message-ID: <7vzkuhlwva.fsf@alter.siamese.dyndns.org>
References: <1286179362-23597-1-git-send-email-sven.eckelmann@gmx.de>
 <7vd3rp97f7.fsf@alter.siamese.dyndns.org>
 <201010111243.25375.sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Eckelmann <sven.eckelmann@gmx.de>, esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Oct 13 21:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P66wA-0000Ve-KD
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab0JMTYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:24:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0JMTYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:24:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D660DDE6E9;
	Wed, 13 Oct 2010 15:24:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IfcWblo0yK+7yi+j5qYXUgMmWSw=; b=PsXvaJ
	Egtsu3QEKLa1WXkvr8/S5fzGmAsWw71wprmp/vwkp0bsd5mUXS4kwGdz9jh2Y1PM
	bT+WjX1N6xNrOtDkAjpMDZ4fGTOIBgF0NcKHz2YN4tdGaGvjcOeQ3dxB9hosZBqX
	UyTyMaC2wiu1xfI9dgBJlQv6i4si0ACufxfSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxThG+h7Ou6vgQr1iqpklkFLciEV9xlE
	F9R0RCXW4ZfVjFYELpNGht83up+HN308/CsHkzZkuxe6Dv+Ked24ZkGvexrW/CvR
	6+KjBf/qmpuUZrTRM3nA/qrFztohmiWBvxNXZxV95herEosDzRKG5RIPiEtGH6fu
	dbCXwSqTQPU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A11E0DE6E4;
	Wed, 13 Oct 2010 15:24:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93378DE6DF; Wed, 13 Oct
 2010 15:24:11 -0400 (EDT)
In-Reply-To: <201010111243.25375.sven.eckelmann@gmx.de> (Sven Eckelmann's
 message of "Mon\, 11 Oct 2010 12\:43\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 779F22C8-D6FF-11DF-B934-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158963>

Sven Eckelmann <sven.eckelmann@gmx.de> writes:

>> Anyway, Ok, so it _is_ used.  And it needs to be fixed.
>
> Yes, it is a little bit confusing when reading through it, but still it is 
> used. :)
>  
>> I was hoping that Eric who took over the maintainership of contrib/ciabot/
>> directory in April would give his blessing sooner, without me having to
>> look at the script.
>> 
>> Ack?
>
> Hm, just be sure, because I saw no other replies since this message: You 
> expected reaction after that "Ack?" from Eric Raymond and not from me, or?

Yeah, Pinging ESR again now...
