From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: plug memory leaks upon "rerere forget" failure
Date: Thu, 19 May 2016 13:05:15 -0700
Message-ID: <xmqq60u9izk4.fsf@gitster.mtv.corp.google.com>
References: <xmqqpossi31p.fsf@gitster.mtv.corp.google.com>
	<573E1758.8090801@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 19 22:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3UCC-0000f3-2F
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 22:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbcESUFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 16:05:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753942AbcESUFT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 16:05:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5E781CC7D;
	Thu, 19 May 2016 16:05:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=VBNClp
	u1vWXNd3V26LwpnIc4dBzrme7vTA9RI11F36dQGnNJayfAv1EgPRu82D4nvyJxUT
	v8kTU06fnLBHqpYF70vtKANyE6epS8wyh/xyG4Jy5BXHtl4cf+/p+yAIgQb5/9WH
	d8OY4Zw2Me1PJJbYqMjJ/D5tyVKz3xNsmcgeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATdU0UR4hSSIL/NL7jcifidHZAJpcdVw
	gDbVV8RVgNJk+8dKr3Fyry47ZcHv7DWWGLNsYn2YoczPl5RW3qlBCfTtXRbrMcMP
	abdYhy7zR5HpkDncke3QLRZ+gKUsFzcsNQralITDhZmVcAwHKc61M9SoIGr0ZbbE
	ixQL+LIEEsQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93E411CC7C;
	Thu, 19 May 2016 16:05:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 136811CC7B;
	Thu, 19 May 2016 16:05:17 -0400 (EDT)
In-Reply-To: <573E1758.8090801@kdbg.org> (Johannes Sixt's message of "Thu, 19
	May 2016 21:43:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0186BBF0-1DFD-11E6-8E5C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295096>

Thanks.
