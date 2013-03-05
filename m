From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix `make install` when configured with autoconf
Date: Tue, 05 Mar 2013 08:56:29 -0800
Message-ID: <7vvc95u6o2.fsf@alter.siamese.dyndns.org>
References: <1362487405-32044-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Komissarov <dak@mnsspb.ru>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:57:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCvAg-0002HC-SY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab3CEQ4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 11:56:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab3CEQ4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 11:56:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FB3A4BD;
	Tue,  5 Mar 2013 11:56:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=kJ/xRC
	lfZpD/UAHA4gvAx+d+DwFiwpAFeEaRSjQc0eOda0faOrU18xrB/b9XNUhbolIfXC
	0YQ9QdF+7P4y6CC2+0k0HG1kvAFdDDdd599pqAjbms83MrMaFfMmiX1Hp8iPZ3aI
	ZMSz624GKHERiQynduys6MAibhF5qcSGAjLMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aopiq/JG5srmTQg7tTt/eFuyaQKCl/lX
	VoSHRP2rvBP/zCkIW4ZQS1WnMheWudCArKFIhlaOqeFEjYgi2qMchOI6QdZR2kk4
	plhZMzu53IRp6oiJrKFMYFVO1V62+RAHkaDuIbTBjjGpqlqMwt0ACNnMa0+k6rG8
	Blshz37RFAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C24BA4BC;
	Tue,  5 Mar 2013 11:56:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C437EA4B7; Tue,  5 Mar 2013
 11:56:30 -0500 (EST)
In-Reply-To: <1362487405-32044-1-git-send-email-kirr@mns.spb.ru> (Kirill
 Smelkov's message of "Tue, 5 Mar 2013 16:43:25 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0D03918-85B5-11E2-9B20-099C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217466>

Thanks.
