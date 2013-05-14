From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 11:57:47 -0700
Message-ID: <7v4ne5jsno.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
	<CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:57:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKQ8-0000wI-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab3ENS5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:57:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758111Ab3ENS5u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:57:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB9F1E345;
	Tue, 14 May 2013 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfKrbAPIEt39AAj/gcFc5cIyPXk=; b=WVIYES
	0Pz9bNCxQu2ztAA+8vMyK14V7RXpsKfog84/bdJjh5GRZudKFszH8JgskCdRLrz8
	r231sNn7jpC2wt8fSQdmO16Vkd/PuDtpuZ5ZFF6DQs9m8YRhZA64AoUpVX7BLpnp
	WKwmt7i/MJ011fGcS/06XC/A4SyL+/zPbTJPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3tvkdbjQZGfq26n7Dg1PMjTiJaR6QbN
	TWoAD+6ABJWn3YN018T0XYxwcBr2VN0hpoMQkrzwu7ozXR4XAP4zdpN+oyH5/N8p
	K1UZz3V43raRa5WnYoNNsMJ5c71D2Wv+A83thMhfh/nnQKln7+pHyLnPEPj/12Y7
	DErNDxhrVoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F301E344;
	Tue, 14 May 2013 18:57:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 636131E343;
	Tue, 14 May 2013 18:57:49 +0000 (UTC)
In-Reply-To: <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
	(Phil Hord's message of "Tue, 14 May 2013 13:44:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C1D89AA-BCC8-11E2-B564-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224315>

Phil Hord <phil.hord@gmail.com> writes:

>     Normally the pickaxe options limit the diff output to those files which
>     contained the changes being searched; that is, those files which
>     had modifications including the search string.  With the --pickaxe-all
>     option, the diff of the entire commit will be shown including files
>     which did not have modifications including the search string.  This
>     is designed to make it easier to review the changes in the context
>     of the whole commit.

I find this very readable, even though "diff output" might be
somewhat misleading (it is not "output for the end user", but is
"passing to the next stage in the pipeline").
