From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Tue, 03 May 2011 16:57:43 -0700
Message-ID: <7vd3jzgww8.fsf@alter.siamese.dyndns.org>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com>
 <4DBEC766.8020008@viscovery.net>
 <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com>
 <7voc3jis61.fsf@alter.siamese.dyndns.org>
 <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:58:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHPTc-0008WI-Q2
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab1ECX5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 19:57:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab1ECX5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 19:57:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBF48438E;
	Tue,  3 May 2011 19:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UX8EUqz5hzGp/i0XwdP3W0FasPM=; b=ihMJbt
	OG9pVDqmPy8niMBr5DrusWMpLrakaF3aNqfO41bTogXyXSYszHrtgCrKM+zmJ2s1
	dW+4crO8PH9Mf8zebN1hHa0amMVUC+1AOnxMIlP+Zcp0CnHe5u5gmdwm9oyndyZh
	yKqQreTHBLn+wjuj9xlOouSMvPZA5Qn4aK1gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EJEbfpMuhtnpik1X8LO0KZOPFQHCx92Q
	RSB06ZWXNz8ETRELj0rypaV7j1gGYfL1Q28BJt2YXXnTIuogZSK2Ii2nHmIZE1CV
	vfGde/0pcV7pVGQKT5hUcJBD5KdyqKiOS1VDqzgJK3kWrbbzANKFi4Wsq4zRICjt
	DR0z+GCl0a4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB211438D;
	Tue,  3 May 2011 19:59:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D4E34382; Tue,  3 May 2011
 19:59:49 -0400 (EDT)
In-Reply-To: <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 4 May 2011 06:43:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 707985E8-75E1-11E0-99D4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172706>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Yes. But git still silently ignores some rules in the .gitignore.

Do you want git to report each and every entry in .gitignore saying "this
rule does not apply"?  That sounds like madness to me.
