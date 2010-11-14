From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 11:15:56 -0800
Message-ID: <7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
 <1289747245-23263-3-git-send-email-avarab@gmail.com>
 <20101114181605.GI26459@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 20:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHi3i-0002QT-VW
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 20:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab0KNTQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 14:16:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab0KNTQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 14:16:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 339993853;
	Sun, 14 Nov 2010 14:16:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eYto4ie+MtZ5ubbV9uYOcdSrPbE=; b=t1LXvs
	IGYIvECAUfsqVgig6sNFrG6m5aTiYFuFWPa+Stna7AuU+i+uRiz3CBmzgCwFY4qm
	T41NYl/+QjPKkumd6yX3hRxqFqQxGDcO1Oi7UyA3wHNzso5VW91Tmse+Ym99M6QE
	LlcamlQLGXoPQ81TM5CTe061FBAKu6UehftrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KxZ9wv6ui5g2jrAtc1usJH98I8ijWzkF
	2tOxUvz4cSB6UdYpFxyE0AGUGpUCAdrT6dMBvtPH/DyadYZcXwFSGpeYkRdj8pYJ
	iplNhxQeprpkf6pAjQ2AK5S8FZ+QvzqdXm7pYOQov7PYpclh+8weq4YJGPbivVPn
	SER+lcNuTzg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E545E3852;
	Sun, 14 Nov 2010 14:16:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CF093850; Sun, 14 Nov 2010
 14:16:04 -0500 (EST)
In-Reply-To: <20101114181605.GI26459@burratino> (Jonathan Nieder's message of
 "Sun\, 14 Nov 2010 12\:16\:05 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A34ECE86-F023-11DF-9016-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161435>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nit: can this be moved to a subdir?  Maybe po or i18n, or even
> envsubst.  This could make it clearer that the code has an upstream
> and should be updated when upstream is.

IOW, just like "xdiff/" is a separate directory.  I think that is a sane
thing to do.

Thanks.
