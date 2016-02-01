From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] clean: read user input with strbuf_getline()
Date: Mon, 01 Feb 2016 13:30:51 -0800
Message-ID: <xmqqh9hsunhw.fsf@gitster.mtv.corp.google.com>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB3D.6010309@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:30:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQM3m-0003Vq-1b
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 22:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcBAVay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 16:30:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751897AbcBAVax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 16:30:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F68341234;
	Mon,  1 Feb 2016 16:30:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8dlPSOGVrwyBO+t7qCfOx1TP9U=; b=LKHlSG
	0iGMnv/fJBa06j0V+bUipo9H/uv0HZ5xfxgnoC0Vwu6pOYnRV9WHf1+oxv7twQ8B
	U9c1vhSk29AGfGupBcAMHoawpTUw/gU2wS0Rxd2wz8n47UhYQWGPy+NceeoJk6yA
	4Hh4ZPbZb85TSQurih+A31Zesl6WfTGZPFNck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PbgK9Ooly27/01iZFC8kaSgFj/sLNdle
	ivG94YMVYgDc/G97RdMh8OUqO1AzsYlSJ1kBub1tvjz2hZA+ICGR1Zj6ZryYwKFv
	/DTisgLVPeRxKsDnAIzUi3C+T914NKP1qlECGRNwlUi1lIF+yRFXGMAz5bY/VUYG
	v2su8P2wg7g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65EFE41233;
	Mon,  1 Feb 2016 16:30:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC9B94122F;
	Mon,  1 Feb 2016 16:30:52 -0500 (EST)
In-Reply-To: <56ACFB3D.6010309@moritzneeb.de> (Moritz Neeb's message of "Sat,
	30 Jan 2016 19:04:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 121AC73A-C92B-11E5-AFA0-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285215>

The same comment (including "think if this trim is still necessary")
as 1/5 applies here.
