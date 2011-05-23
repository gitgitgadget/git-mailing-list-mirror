From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Mon, 23 May 2011 09:54:04 -0700
Message-ID: <7v4o4lwe6r.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com>
 <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
 <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com>
 <vpqk4dhzsvh.fsf@bauges.imag.fr> <7vd3j9wll0.fsf@alter.siamese.dyndns.org>
 <BANLkTikax2T3BFs_wac-W8tWeiZ=YHsxvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arnaud Lacurie <arnaud.lacurie@gmail.com>, git@vger.kernel.org,
	Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 18:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOYOf-0007LM-NJ
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 18:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab1EWQyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 12:54:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab1EWQyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 12:54:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B9435932;
	Mon, 23 May 2011 12:56:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fG9if2nL72604gEzVwtTz6tKxBc=; b=oyz5pG
	NJVa7+l5Y7uT6YL0GLR8kHJN3cmuiiaxtFAI4HLBPIz0jzzIGT6PdL4YOqW+Qenx
	tLNKGZrOIaX4ao0W1Ui3/QzFpleGLD4gAljFf/7pEna/daa3nRc5FrES9ICt26JY
	rVeg2C7SrlsBXr459Zq/H/PgwfJ4FVGL8xVH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSa9bE8bg4tubAQ1FSWrGDX5ymgXQbyR
	4M11ymRP2dIK22npErucXQc33gJXQabyeUE5vh/r0DbDV/chM8ZRxgkWwK9Y3/Jy
	livp4MCKap1UVpFXGISbVtwDcFLpuFF6BU5I7/OsOfzvN3qgU/jcJP6aZLPS4LpV
	DU10QPdMvbQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 142D5592C;
	Mon, 23 May 2011 12:56:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 630DA5929; Mon, 23 May 2011
 12:56:12 -0400 (EDT)
In-Reply-To: <BANLkTikax2T3BFs_wac-W8tWeiZ=YHsxvg@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 23 May 2011 08:54:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 950989EA-855D-11E0-AD3C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174252>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> We currently support either:
>
> git clone mediawiki::http://some.where.xz/wiki

Ok, I forgot that we settled on that double-colon prefix.

Thanks for fact-checking.
