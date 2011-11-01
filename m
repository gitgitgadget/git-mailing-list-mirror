From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Compile fix for MSVC
Date: Mon, 31 Oct 2011 20:30:42 -0700
Message-ID: <7v8vo0o6xp.fsf@alter.siamese.dyndns.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
 <CABPQNSaW+ciEzAMruYVgK_y2xf=sExYiFfdbS4xonKe=h-APjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 01 04:30:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL53p-0007rU-2c
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 04:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab1KADap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 23:30:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab1KADao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 23:30:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D133657E;
	Mon, 31 Oct 2011 23:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qFgXpVZbrgBUxqXLXzENuNn+BRo=; b=xykEqd
	PR5ADb6FiKe2iNflJFSNZDDdtA5/Vq7fna2lgu69XhorhWdOTXgm9h86hhR7txIG
	XEIiefON9Ih4FWRZXmyvaz4ebdod/kGY/hT7JNl96e9dse99UsJb34FawROA3vLw
	p3oJsRJhRKBfiXHmxAXvG5Z3Yi6DbO3KWd1HY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OdMreRxdYuNNySi1nXxLuZHLStlkYJKL
	TegfNMN1HfngW56c8PZ0ANBYYDXBm0NCIPo/zED5nvHgKilRp4uBmTYb3YSmH67f
	X3+J8H3aMs/17BQds5+Hqh3ZYOnM1FwCds5oxC6J8LETa/8TxnqFdpCH3ZkU35lN
	Hgjs5U2kBJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E30657C;
	Mon, 31 Oct 2011 23:30:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88FC4657B; Mon, 31 Oct 2011
 23:30:43 -0400 (EDT)
In-Reply-To: <CABPQNSaW+ciEzAMruYVgK_y2xf=sExYiFfdbS4xonKe=h-APjA@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 1 Nov 2011 01:36:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1335E08-0439-11E1-8B38-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184553>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> The result of applying this on top of the current master (1.7.8-rc0)
> compiles and seem to runs fine for me, both with the MinGW supplied by
> msysGit, and MSVC (as outlined by compat/vcbuild/README). Without the
> patches, it fails to build with MSVC. In addition, the changes looks
> good to me. So:
>
> Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

Thanks.
