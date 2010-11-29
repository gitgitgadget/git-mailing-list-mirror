From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Use reflog in 'pull --rebase . foo'
Date: Mon, 29 Nov 2010 15:08:36 -0800
Message-ID: <7vaakrzq17.fsf@alter.siamese.dyndns.org>
References: <1289689102-3507-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, santi@agolina.net, schwab@linux-m68k.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 00:08:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCq6-0005R5-W2
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 00:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab0K2XIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 18:08:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab0K2XIt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 18:08:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2ED913FB4;
	Mon, 29 Nov 2010 18:09:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yPV1KSAH6/jjBrHt/H9rJO91DQ=; b=fiHvnX
	EEc8g0Tx0+MCVfnr05bDaLWI4clYrdXbuZICGSkQAZkzj6Z4JlWHjXvtpJTvMMEQ
	TuYUUwekj7iqJBjfh00iedeW8jwkhNfXLMvqoqsmw+mHg2rPc/atEg1AS9XeRuu2
	kKEIuKxtdCuDL0lZGRZCfE2Nnm+eXy+v5ep38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnZ6gvJqtrQQOa+HPfDtY0M+W88yaREj
	dqzSqGZo1Qj7G6nEgI+R0Odyno69cTAlE2sQm+8ps1Pi7h4KqVHyV1TeADmxIbQA
	G9uEr9S5g1il2GqgzU5PEXIfsv+4Btl64vvlFHFsul2266X1MGmnfSkyZhUMIOYt
	I8i5j/vc4BA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3D0E3FAF;
	Mon, 29 Nov 2010 18:09:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5D5653FAC; Mon, 29 Nov 2010
 18:08:55 -0500 (EST)
In-Reply-To: <1289689102-3507-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Sat\, 13 Nov 2010 23\:58\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6DF9562-FC0D-11DF-90C6-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162448>

Makes sense; thanks.
