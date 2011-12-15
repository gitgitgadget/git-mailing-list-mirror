From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: --ignore-stale option
Date: Thu, 15 Dec 2011 10:21:12 -0800
Message-ID: <7vmxatofvr.fsf@alter.siamese.dyndns.org>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 19:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFvj-00029E-Hi
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 19:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab1LOSVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 13:21:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1LOSVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 13:21:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 798297E96;
	Thu, 15 Dec 2011 13:21:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gw03/TQYiJatgotjQz1NyKgR7Jw=; b=vAB9Vg
	yzfQnMLqjC6bkA04ftOX2FojALogangw37IfftHtuGgjFdMz7Z6bJVfphG2E83rU
	DVi1GtR/AsaIhYdsPq1GmQyGOiTwECPh323xdiaxifQmXl1Dxt2H/gyTlsZuvtQM
	ehEjZmKqU4sCfwBsar8S57LW6BRSGEy4MlXCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YswbUEFohH9qGDU16/FHu9F9+CV+j7m7
	/zSUaFix+h/B5vf1TKZs8luSxf78QyAR06qe2zrLngTjKg/LhnjuGoz18bRhe9c8
	OYzAuMl1BE6I/0GIy+UrzlKF1dXpKhp1TybSxTKdMC8XDb8KgDt6yPN1QMPOKe54
	u0esWxI8aW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 715397E95;
	Thu, 15 Dec 2011 13:21:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AB857E91; Thu, 15 Dec 2011
 13:21:13 -0500 (EST)
In-Reply-To: <20111215073816.GD1327@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Dec 2011 02:38:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 926D1F88-2749-11E1-BCF7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187219>

Jeff King <peff@peff.net> writes:

> But I still see this as solving the wrong problem, and encouraging a
> dangerous workflow.

Yes, that is what I meant, so we are in total agreement that these people
should be encouraged not to use the matching semantics.

How that encouragement is made we may differ, though.
