From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove "bashism" from
 contrib/thunderbird-patch-inline/appp.sh
Date: Mon, 28 Mar 2011 18:01:52 -0700
Message-ID: <7v7hbiviwv.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6?= =?utf-8?Q?m?= 
	<luksan@gmail.com>
To: Maxin john <maxin@maxinbjohn.info>
X-From: git-owner@vger.kernel.org Tue Mar 29 03:02:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4NK2-0002aD-1p
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 03:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab1C2BCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 21:02:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1C2BCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 21:02:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A32454617;
	Mon, 28 Mar 2011 21:03:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZwYshRdPa8jFq+IheybUDlT/vAk=; b=wn7Q6t
	PuzerYloQ84Bspp9a+PrzgMfrxjL5WCBmvGv4STTJfchgIWgwr/88m8chroP6Wux
	vZzW34U1UByRPQdWkNgnkFiTAQ2Y73igrxFLoMr9hOJuyUmZfUb5uT5GXJ3qfLLC
	3sLekRROv8DHSzeyKcLNwuYj4HvZ4QbK/KCKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2vx3ov/ah5a0B9hK9uQIjhhzfOB+Yuv
	dYl/1x9GYpKZ3g7cz6XBUAj+ROYlkeKEk1/lpg7+AfHp/ijTRvTuCeaR9EHE0T1l
	S83Oyn/ypH7MOiAI16ZTTC7eBDqAtcXZPM3P9a+I+XAjwJ+h+j/Y4eWO4033M1XX
	T5BHsCXkt/c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 724E04616;
	Mon, 28 Mar 2011 21:03:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 57F2B4611; Mon, 28 Mar 2011
 21:03:41 -0400 (EDT)
In-Reply-To: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
 (Maxin john's message of "Sun, 27 Mar 2011 17:37:04 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6582D11A-59A0-11E0-B076-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170211>

Maxin john <maxin@maxinbjohn.info> writes:

> Remove "bashism" and minor corrections for
> contrib/thunderbird-patch-inline/appp.sh

The script seems to only use standard POSIX shell features and nothing
particularly bash specific nor outside POSIX in general that we exclude
from our coding standards (e.g. "local", use of "function" noiseword,
substring expansion ${parmeter:offset:length}).

It is better to explain the patch as

  Subject: contrib/thunderbird-patch-inline: do not require /bin/bash to run
