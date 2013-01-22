From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Replace merge-file.h with merge-blobs.h in
 LIB_H
Date: Tue, 22 Jan 2013 10:48:53 -0800
Message-ID: <7vwqv58356.fsf@alter.siamese.dyndns.org>
References: <50FEC2B3.3010000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 22 19:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxiuN-0007iP-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 19:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab3AVSs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 13:48:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab3AVSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 13:48:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B58C46D;
	Tue, 22 Jan 2013 13:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=v4w9jX
	sgiCMOfGiWm6yOS70J/XhF5h0HsRfP2qKSNzfKIbf/KkvRx/sw20zTGGpxKLSBXN
	lHt2IOYG5HALIN7dEaRuWEv6K01TfjJmFK8jOewECgCiIjmNXp33A9wnb6N63nrO
	iXoDHtXAu7ql4yxhJ6qvvbnMwTgUTcYVrARYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aXAB93VsmSdQQBp/9xUfj2L6109/MnMI
	yVOg7HCPCaGv+bU/Rb+5IQOSg3GAuRALz3BRptwV2MqVy0KgZ5rKcZf6LTS26P02
	brDaQLvsUDpSh7vVnuYojREtDzslAFHnH4YGN6UOMeumzMSXE2A7l8UUkJXr62zB
	nXDoGAg5QEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B8FEC46C;
	Tue, 22 Jan 2013 13:48:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F47DC467; Tue, 22 Jan 2013
 13:48:55 -0500 (EST)
In-Reply-To: <50FEC2B3.3010000@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 22 Jan 2013 16:47:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FB500BA-64C4-11E2-9589-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214246>

Thanks.
