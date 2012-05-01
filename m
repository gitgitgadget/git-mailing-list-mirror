From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.10 doesn't show file pushstatus
Date: Tue, 01 May 2012 10:33:43 -0700
Message-ID: <7vd36najrc.fsf@alter.siamese.dyndns.org>
References: <20120501010609.GA14715@jupiter.local>
 <20120501065832.GA17777@sigill.intra.peff.net>
 <20120501073326.GA21087@sigill.intra.peff.net>
 <20120501084048.GA21904@sigill.intra.peff.net>
 <20120501093230.GA22633@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	dfowler <davidfowl@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Paul Betts <paul@github.com>,
	David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 01 19:33:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGxV-0005Jh-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174Ab2EARdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:33:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758034Ab2EARdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:33:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 208D1632C;
	Tue,  1 May 2012 13:33:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=llJkM4
	gRTtGEHkeuq1bouO0s9BzkdhajuynJYNSPPO3K/uAoF7HeqZocXami2FoeLwZyik
	Y5UHKBsEKlH9Q1EkI2ZIcLspVgELFtmbKTrAOn3OLskDMfPMhY4Kv+RLtYCBb+Sr
	IoexLZK+PhJjvcn+7ydJDDR6gGQFvxb8lHmvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aOEomRsOQKORNlflRg8Scytr6YC51RG9
	86NwH3pxKobzwMlqoNI3rf0Yyoo7AL6RdzLhXhSDWIDe2drHci/C/lQUEcihRSSl
	sipBtBfbVe91NE/QN4LzAKfewRwzbxG+UNxnDVypIipklNSMowzbP4pxI7JPxxMb
	/NzUpDUzJYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16921632A;
	Tue,  1 May 2012 13:33:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BB866327; Tue,  1 May 2012
 13:33:44 -0400 (EDT)
In-Reply-To: <20120501093230.GA22633@ecki.lan> (Clemens Buchacher's message
 of "Tue, 1 May 2012 11:32:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD13194A-93B3-11E1-8756-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196710>

Thanks, both.
