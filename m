From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 09:32:56 -0700
Message-ID: <7vzkabwsav.fsf@alter.siamese.dyndns.org>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org> <20120416160729.GM5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:33:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJorQ-0004aY-Om
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab2DPQdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:33:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab2DPQc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:32:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4A57F4D;
	Mon, 16 Apr 2012 12:32:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dqlkuhdKY07mYqpArwUAeOp7WZU=; b=FwivRX
	aPc/zMjDAjGBxjGl4+RSvvPZ0bxQYx6K5VOUUChgRv1XZ8vWAMONpIdmIxE/gjH1
	zX/0itDKWuWTMHSkL5HOdmb5Q0MupxaQObAxksHl7oI1OsjkYxB6gVqHVMQRHHXO
	fTHkkwAf6A92Lk2SNytTKmei8NC5Bp8TmqAyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jKeVUjJnV34RNGjP0ULE5TbN7d5fVcYv
	893t6zEnWBCxi62PhauaDn92LztLFgPB4rxHtyoHe+d0SwiWnMMa0EDgUb2K4XgK
	ySgTXfTs5F49XnFHf4nE6u0PWQCEeEue9tpmsqjwvFUKOsoDCfSKmTmYboPW9CSS
	x69bMqgCZP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43DC17F4C;
	Mon, 16 Apr 2012 12:32:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D18FE7F47; Mon, 16 Apr 2012
 12:32:57 -0400 (EDT)
In-Reply-To: <20120416160729.GM5813@burratino> (Jonathan Nieder's message of
 "Mon, 16 Apr 2012 11:07:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3354C2C-87E1-11E1-AF92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195661>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Because of these considerations, the convention is that every
> identifier provided by a completion script, including public ones,
> starts with an underscore.

OK.
