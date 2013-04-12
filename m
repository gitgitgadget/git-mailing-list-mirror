From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] completion: reorg and performance improvements
Date: Fri, 12 Apr 2013 11:54:23 -0700
Message-ID: <7v38uveg0w.fsf@alter.siamese.dyndns.org>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 20:54:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQj7H-0004g4-4z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 20:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab3DLSy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 14:54:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab3DLSy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 14:54:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB84E161B7;
	Fri, 12 Apr 2013 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=39UzF46+WjtYmeRCcagz3sZt1m4=; b=C83USf
	2T8npfAaHglzBm/mgf6leL7nwmbxisYOpv+tEX4x2s0/3f521NcWFtJoG6bAxUI4
	PAthfMq2r8kXUzSqasi0xY4pufpD9dBPZQQ5bTtaY58mMemXjuRXz5bKrhDuhXw/
	xccEF8b2lDj8/oFWeV6rtJj6bWs/krqUWGe+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUrWvAq1hH7pH6B7mc+wxSo44DwNlHoB
	6Kv9dSVei1Qpb752bdKdwxrZXHVTYQMVFgjCVYtdT1vNTWNHZfWdq9GH/152YwAF
	pPsNe4FYZEIwyH3/OutJBAQK9SxcpN2rQfSi/DTj/DW+kVjICNLCRXNA+X6pt0TS
	5ot2KStXxxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F47E161B6;
	Fri, 12 Apr 2013 18:54:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21788161B5; Fri, 12 Apr
 2013 18:54:25 +0000 (UTC)
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 10 Apr 2013 01:57:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6524B866-A3A2-11E2-89F5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221013>

All patches in this series and the other cherry-pick one looked
sensible, with a fix to [3/7] I suggested in the other thread about
protecting against "set -u".

Queued.
