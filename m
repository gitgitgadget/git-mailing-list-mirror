From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6044: replace seq by test_seq
Date: Thu, 19 May 2016 08:21:22 -0700
Message-ID: <xmqqtwhuoyz1.fsf@gitster.mtv.corp.google.com>
References: <573C02EB.30801@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 19 17:21:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3PlT-0003DR-3D
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 17:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbcESPV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 11:21:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754228AbcESPVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 11:21:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 047E51B347;
	Thu, 19 May 2016 11:21:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=CZCZVO
	kYH/x0EvNy66UUGHOXnn+Mg1csRCkzGuv+rbZ/H+HgIB8lEQpyWrU2/+CfLM3e3C
	skIpqDl0mMVDs62kWfWTNTZ0jplqRyznpGy3bVDfyFUUGEe5YpDRJUUSoHJ62TM4
	nCfINIw9YcstIN/SP3o6kKGRsk6j6gLJ5SEO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d94RSsZeslnKt7QeM27Y5D0nA0oNZWCu
	rLiYb667T0VMb43fnzoN/Tmgqit83silEsIo/lEqlwyD+s0Prc42QQpjCCrIt2QV
	KA/qYUTOGYwAAWC3o6BiuJu9DQPJfpwI17Vr4R5IVKTlBLJqyhKOkN2cxb39u3cT
	iNTxbxPkHus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEE021B346;
	Thu, 19 May 2016 11:21:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 709611B345;
	Thu, 19 May 2016 11:21:24 -0400 (EDT)
In-Reply-To: <573C02EB.30801@kdbg.org> (Johannes Sixt's message of "Wed, 18
	May 2016 07:51:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 594BE11C-1DD5-11E6-9A2B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295068>

Thanks.
