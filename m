From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/8] Doc: separate gitignore pattern sources
Date: Tue, 18 Sep 2012 20:56:44 -0700
Message-ID: <7vmx0mis1v.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-6-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 05:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEBPI-0005Qv-BS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 05:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab2ISD4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 23:56:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130Ab2ISD4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 23:56:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E04A898AC;
	Tue, 18 Sep 2012 23:56:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tAswoVOwVg7wNqj7zrFnjkowNrY=; b=BqrukG
	tuV1PJ4W7u+Q7hBgwQRA8499uN2U0KT4GH99RqBboxqz8PV5Fp8hRldlo6vSblQN
	bFkZGRTCWiBEG8a17jKmSTJ1Gm8vqUCbjzo+yvx2SSr7e22hLsTl3mCGEIepXKnq
	9xGDAxaVlz1r9pKVEQZGA/8UDhOW8TJl0LysQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lSPCQGlPQQS6tN5ckBXHhfAzCT8oDdt2
	AnX13yf6PZzuSWvGfiOWHxyCu2tHuGmWBR4agQLtN/Q9EloCClne30+qhG3vBuTh
	87HRtkjgr8W7DlGly9drZCcUwwVutM0MfvVVLA2Hz2vJQhw61iH1HonhfgvBOGFI
	1CrTQ2fm/UI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEC7398AB;
	Tue, 18 Sep 2012 23:56:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4ADEE98AA; Tue, 18 Sep 2012
 23:56:46 -0400 (EDT)
In-Reply-To: <1348010734-664-6-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08183746-020E-11E2-AF2D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205903>

Philip Oakley <philipoakley@iee.org> writes:

> Use separate bulleted paragraphs for the three different gitignore
> pattern sources.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>

Thanks.
