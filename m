From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tests with broken && chains in pu
Date: Sun, 04 Apr 2010 14:28:13 -0700
Message-ID: <7vochy7vrm.fsf@alter.siamese.dyndns.org>
References: <201004042208.58939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 23:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyXMx-0007v9-8E
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 23:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab0DDV2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 17:28:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab0DDV20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 17:28:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 058C6A847C;
	Sun,  4 Apr 2010 17:28:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AY0ZT0sTVN9N5SGxAnJdSQeccXw=; b=ONmtw6
	erfIk0PZ6ID0/TfJ2ibasEt6ERP+4qy7TdOVcWTsjDPx0rt0tzMbQRfMlBbpsKo5
	YulNSO6hKDZ/zxbw2juWaq9XRfbJAP/oY/kdK6RGVNBMWnTPW0mCVXiHfcKNypql
	sK31b6b7Ll7GegB5pVTV6jFulFSjkgvePWiA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V7cedUySrZgAJnv6XZ78tR0uv9lPQZIk
	SKkc3qnyl6fW35wLewrKxczb+yefvGzOlQptridyK1OeAHx/7fwum1umdVwQRiOV
	scD3sqx+G4f7qG1Qka3IbzsXZyYOj7BGrQBbsgPOC/ECtMhnifTfkQLBVK3UXkk/
	xLQ7nG5Si3Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA42DA8469;
	Sun,  4 Apr 2010 17:28:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E82E1A8467; Sun,  4 Apr
 2010 17:28:14 -0400 (EDT)
In-Reply-To: <201004042208.58939.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 4 Apr 2010 22\:08\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FDEF31DA-4030-11DF-8AC2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143948>

Thanks; will squash these in and rebuild the topics.
