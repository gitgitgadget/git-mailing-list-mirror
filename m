From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/4] Stream fd to clean filter, GIT_MMAP_LIMIT, GIT_ALLOC_LIMIT
Date: Fri, 22 Aug 2014 11:17:45 -0700
Message-ID: <xmqq61hkpewm.fsf@gitster.dls.corp.google.com>
References: <1408716083-9093-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:18:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtPW-0000XY-DS
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbaHVSR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:17:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60131 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517AbaHVSR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:17:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6D3D3297B;
	Fri, 22 Aug 2014 14:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PFi7IS1JZMK2Y8t2ljMmO72vQI=; b=dVEU9z
	FSd4naV7rmMEH017xHMLoALAxi2KTsMzaVTK9Fgjvl1kntkg4+XZfvm79ozMMrih
	I77ESEZI5SCoOOO7YmIyyTZyKV76PD6dYA4rn+5RCp/ifYcJjTGR3toV4pBhummq
	kjaqynNvb2Nca5ALgVNSRt93hbI8336im5ZEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e7Z5GvH2FOtB32ei5vuQpPNwrAeDljFL
	elXarZrTiNt6j7XSR/95Q52QMHSDEAyhbIUOeurnuv3AJTDNA9/34TAI4GWdVWoW
	ntIl37iqzE4Xyh3JIdBHTsqowzO3lfm55ItxeijNGJgaOdSkItR11YC3+AaSj/0J
	MqP5+3Tu4pg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA0F032979;
	Fri, 22 Aug 2014 14:17:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B5013296A;
	Fri, 22 Aug 2014 14:17:47 -0400 (EDT)
In-Reply-To: <1408716083-9093-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Fri, 22 Aug 2014 16:01:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E8590AE-2A28-11E4-89FC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255687>

Thanks; will replace what has been on 'pu' with this one with some
tweaks.
