From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] close file on error in read_mmfile()
Date: Sun, 26 Dec 2010 11:18:28 -0800
Message-ID: <7v8vzcz6kb.fsf@alter.siamese.dyndns.org>
References: <4D15E5D6.2040800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 26 20:18:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWw78-0003Da-0l
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 20:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0LZTSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 14:18:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0LZTSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 14:18:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC9022827;
	Sun, 26 Dec 2010 14:19:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ZxoF/c
	Qko3P2VapRw7iArJD5VqRB70iI/UkJvGPRX/QZdh3ahYEpf5QEjshtwyv3oD0N+b
	AtpdV5khaKaTcj3QWiLpXortra6Qa2KtBM910rrLL98A/f7+ntyXo3m0pnJ5wJWO
	5MW2y3RkBYZswV3h408RKokYLJllRu5p1XYmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GTjBtOls769ffRnYOMZJv2WLT7wzdtYH
	cmV6tlMDivD1YRcTRmcG3IMCk9VJ1ZQAV8KYXyw5r4RXxms6uQJ8drWQMUnqztf0
	jml3d/qQU8UpMLpJ3+RMvAPC/+PwxK+8f54r3L1MXgVs998fZtXB+MqQyKS69BEN
	N9BdWaeStwo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA7642826;
	Sun, 26 Dec 2010 14:19:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A7C2B2825; Sun, 26 Dec 2010
 14:19:00 -0500 (EST)
In-Reply-To: <4D15E5D6.2040800@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 25 Dec 2010 13\:38\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00E9ACD8-1125-11E0-ADD7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164197>

Thanks.
