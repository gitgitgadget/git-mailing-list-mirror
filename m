From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 (for maint)] git-completion: fix regression in zsh
 support
Date: Tue, 10 May 2011 10:17:49 -0700
Message-ID: <7vr586jwzm.fsf@alter.siamese.dyndns.org>
References: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:18:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJqZV-00053N-UD
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 19:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab1EJRSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 13:18:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1EJRSC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 13:18:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D5724771;
	Tue, 10 May 2011 13:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b2B2eb7LdKR3BLn9YuYMlfuaSZw=; b=IhcEB9
	4gW26mXWoZh4hmYepkvkn4q9xQgAh6rQ8RcF2fizvLVWiKbUdwO0NFgZhWQFb58o
	GMW4XrU+UAiDSr3my2aR5UWbAk5NvIJ1CtBMM5u4DhfamYP1B+tawic8oKDY3oG2
	VdRumMiojnmxFbCObDIjO3HrV3wpy4/t4ZL+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kMxIbBGwbLK9EjQ1lWNL1pFDJLPehq+X
	z3G1kNTuS3HPrxktq14AsKR+HAoYgPhTpCSHtUWo6Vkt/fGseQrPTRSPw5dSGOnB
	dQKBBWOgymXKDoyW47/FtSKocoOGcqPJajEkkMCwWs2VMndMkOk7ZbUUayQr++4z
	Pla7IRvSviU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFB314770;
	Tue, 10 May 2011 13:20:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 749A5476F; Tue, 10 May 2011
 13:19:57 -0400 (EDT)
In-Reply-To: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 10 May 2011 15:20:39 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDBE384C-7B29-11E0-8025-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173342>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Right now zsh is quite broken;...

Yuck--sounds like zsh as a whole is broken, but certainly you didn't mean
that ;-) Could you also clarify "Right now" a bit?

Is "The git-completion script in contrib/ in 1.7.5 is broken for versions
of zsh before 4.3.12" a good rewrite of the above?

No need for resend if that is the only change required.
