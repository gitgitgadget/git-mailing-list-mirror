From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/t9001-send-email.sh: fix '&&' chain in some tests
Date: Tue, 04 Jan 2011 15:56:31 -0800
Message-ID: <7vei8sdxzk.fsf@alter.siamese.dyndns.org>
References: <1294174618-14571-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Wed Jan 05 00:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaGkA-0003i6-78
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 00:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1ADX4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 18:56:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab1ADX4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 18:56:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 336BC373A;
	Tue,  4 Jan 2011 18:57:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Elv5tl
	QDKkg0qcADL5Syehg/QS/TugKr7vLir7X0wAVYooJbH1KnCuCE4VOhFCzCj/d2JX
	5R7o/wTovkDA3j+hrEhy9hesWuHIiZHvESYKxfO/qwTd/8/1x29su8h/hxcEE2vf
	0bs7laOELt/xcdsHsqwrne/PyE7IDnBdwNOTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYvs/fsmVh2+32v8QBXvsqtvsgJQwNhF
	4hwNjq9POBeMCdarnwxYsbRmn5iBdnRdS5pXark8PU48SfeOUt5UszZ80cuuzk3+
	SFBaQ/fVZ0fwvGsM4TeBu3qndsPcui/VBgBMYeMmJ1+Cn8HXcVAnYfcqlb4FnyZF
	hhjAUj+wyG4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 020C33739;
	Tue,  4 Jan 2011 18:57:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DDF1C3738; Tue,  4 Jan 2011
 18:57:10 -0500 (EST)
In-Reply-To: <1294174618-14571-1-git-send-email-ospite@studenti.unina.it>
 (Antonio Ospite's message of "Tue\,  4 Jan 2011 21\:56\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AC05AA0-185E-11E0-B63C-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164528>

Thanks.
