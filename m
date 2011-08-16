From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Tue, 16 Aug 2011 15:45:02 -0700
Message-ID: <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
 <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 17 00:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtSOQ-0004QT-8M
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 00:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab1HPWpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 18:45:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab1HPWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 18:45:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287E156B3;
	Tue, 16 Aug 2011 18:45:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rqr4Bb98Yodv4PGvzzFpBdv0CIE=; b=TopA16
	kY3ewWkqoVsXnzpkAOtebQlPFBBMze0npO3LWA4RA02H67yBfR8AeAUh1O9qsvUX
	le0eBDFR2mFsIR6mnmGdVvvX+eVQxBAF98ZsTR1W8LVXpwZmpMBMQ8LEA1+edfMs
	IGGJgmssKWUdMGLoKJqIroNe2rd8QxXOBSJYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFGa3rJooBKwHA2awBwn8BYANcyedneL
	jDX+VYsd3A46kAwz1NLuiCkXxirvIpmF42XKcMKDVdYnj3TcSkQc/H4KVQBSWev1
	ZdLvoVFI5HK4gtfyOmsGHKO8U+gTdRX1DYXIJUji0iL/lSQYuuyaXXGAk6jwHKJE
	fnctd96+bTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1282C56B0;
	Tue, 16 Aug 2011 18:45:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C37456AC; Tue, 16 Aug 2011
 18:45:04 -0400 (EDT)
In-Reply-To: <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sat, 13 Aug 2011 00:36:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61E6C818-C859-11E0-BCED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179481>

All the changes except for this one made sense to me, but I am not sure
about this one. How often do we look into different submodule refs in the
same process over and over again?
