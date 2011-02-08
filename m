From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] make open/unlink failures user friendly on
 windows using retry/abort
Date: Mon, 07 Feb 2011 20:34:20 -0800
Message-ID: <7vfwrzqh4j.fsf@alter.siamese.dyndns.org>
References: <20101214220604.GA4084@sandbox>
 <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
 <7vmxo6pxyi.fsf@alter.siamese.dyndns.org>
 <20110207204818.GA63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 05:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmfHq-0005X1-L0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 05:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab1BHEel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 23:34:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1BHEel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 23:34:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADB1F466D;
	Mon,  7 Feb 2011 23:35:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Vz9PGU0iRQ1UqxbxM4h7U+QcRTg=; b=f5a5AsqeqHqsxUaw2dPzZoT
	jdiEJ71Utdo8BzQ69h7DUsbUMfE1k7t70De+Hgk2siZyk157RhGERF7KuAkv1XGO
	S5UjbwHnUN/kHtoyNsgKeH6pzkyzx6kiANMUlJY7/46qmfoLhZa2HYeEhx8rkjsw
	gPWt4r5SpP0ADy8xh/Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ehKt6RpbSTuQgOqMJrrJqUkBIctoXouoSJZJhey9kU2phQqbb
	gdfuhT+j/223JyluF81B8Oew8XzABI4knacu1DvfUgojLv9vXmqisFyOuCLDWMd7
	cVgnVlDyqRa5j/FWJH97ndYp5adhYZdp/593y3+Zf4oO3tICG8nsqAhRrU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DEB3466C;
	Mon,  7 Feb 2011 23:35:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E3754668; Mon,  7 Feb 2011
 23:35:21 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DBF0C36E-333C-11E0-A060-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166333>

Thanks, will queue (with a handful of minor style fixes).
