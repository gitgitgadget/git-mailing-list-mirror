From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] reroll of ap/log-mailmap
Date: Mon, 07 Jan 2013 23:39:10 -0800
Message-ID: <7v4nisgm3l.fsf@alter.siamese.dyndns.org>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
 <CALWbr2w8z2iVx2PxM2sn3yDQzB5rTXc4EuZD9GCKSCofHzEzLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsTmW-0003NS-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 08:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab3AHHjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 02:39:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab3AHHjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 02:39:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BAAE6A16;
	Tue,  8 Jan 2013 02:39:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3F0eiqgEEHxbEGCh068ZDwGTXCE=; b=G3gma7
	SiCCvI/eBaQiFeNIw8kSFVPqC4mH3uoja5/vo7I2FlEfTItqjePdiY3mXt3f53fD
	lZJ4Iw7Vz7O8qesEUwnMcshg/1GQ9bs/UOclwYH6LDrO1YFbbULCl9tEFXRqYDr8
	fA+/uYawASjFgP825bpAtVG/63jOfgGWtIHR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qzVuW748zhr9q35DR2j9P4AVlJROJWTL
	5NFqHi2TRP5LL/4qp6ezqcafKvOGTjGS9ZS1EMaInaaCrMTCCjc+YbHZSIrhMTQn
	Yew2jyzuR4EHL3k7DQFGxbHxMEeXH/+hW6ilc2g9Qp6Tt8erIZMcaj+VFTcgYfcS
	hDPx/9u805E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D1B36A15;
	Tue,  8 Jan 2013 02:39:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CDDC6A14; Tue,  8 Jan 2013
 02:39:11 -0500 (EST)
In-Reply-To: <CALWbr2w8z2iVx2PxM2sn3yDQzB5rTXc4EuZD9GCKSCofHzEzLQ@mail.gmail.com> (Antoine
 Pelisse's message of "Tue, 8 Jan 2013 08:27:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EA1A898-5966-11E2-B9A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212943>

Antoine Pelisse <apelisse@gmail.com> writes:

> Have you been able to measure a speed increase due to less copies ?

No.

This topic was not strictly my itch, but I did the rewrite because I
couldn't stand staring at that *_extended() function ;-)
