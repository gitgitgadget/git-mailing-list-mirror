From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 10:10:18 -0800
Message-ID: <xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
	<xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
	<CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
	<52DFE882.2040605@atlas-elektronik.com>
	<xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
	<CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 22 19:10:39 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W62G6-0003hI-3Y
	for glk-linux-kernel-3@plane.gmane.org; Wed, 22 Jan 2014 19:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbaAVSKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 22 Jan 2014 13:10:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbaAVSK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jan 2014 13:10:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484E564340;
	Wed, 22 Jan 2014 13:10:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/+zQzF1wTcTO
	xU3VIm5HW97thEo=; b=hT1rbiqGj3ZA0uGN9Zgplq2ldKAPXkI2+Ci4W8sT7tg8
	QU2tLoeVR2hLAv4Tn0qAKWzDc3TkebUoqdMK+30H1/edBgL2IPUIIkmY0skEOi1B
	NFMuSMyr+FZf/Xcs91P0Aade88J9RIqrX28S9fLWsjd7dxQyGrByjnntyvSGE/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jnF5sP
	4itRC9xHjE1qXMJweEG38MZzN25bS7s7kGQrKXyKiZCZxvJ5GXpdE8LyjvbFukHO
	IUaQP+zcaYQkT1+L0qNQH4KvQ/BnVouUkG786RCgVuRk6Vv0UTlO8qjJVZqw8yBu
	GietZhoj297Svn1cyTa/gMpBzw2MIBNWYmZvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B528C6433E;
	Wed, 22 Jan 2014 13:10:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C86D6433D;
	Wed, 22 Jan 2014 13:10:21 -0500 (EST)
In-Reply-To: <CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
	("Vicent =?utf-8?Q?Mart=C3=AD=22's?= message of "Wed, 22 Jan 2014 18:26:23
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 750812D6-8390-11E3-B8BB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240842>

Vicent Mart=C3=AD <tanoku@gmail.com> writes:

>> Do these consume CPU every time somebody asks for a tarball?  That
>> might be considered "wrong" depending on the view.
>
> No, our infrastructure caches frequently requested tarballs so they
> don't have to be regenerated on the fly.

Thanks.  That is certainly good enough for consumers, and better
than having to manually create and upload for me ;-)
