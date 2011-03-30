From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove "bashism" from
 contrib/thunderbird-patch-inline/appp.sh
Date: Wed, 30 Mar 2011 10:57:07 -0700
Message-ID: <7vmxkco5jg.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
 <4D9103D3.5010403@zoho.com> <7vei5qtnc5.fsf@alter.siamese.dyndns.org>
 <4D9261AE.5070103@zoho.com>
 <AANLkTim+0gxGKZT=vfmX7v0QZrApjRwAzW3PiLePL-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?=C3=81ngel_Gonz?= =?utf-8?Q?=C3=A1lez?= 
	<ingenit@zoho.com>, Victor Engmark <victor.engmark@terreactive.ch>
To: Maxin john <maxin@maxinbjohn.info>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:57:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ze7-0005tr-Dg
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab1C3R50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:57:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab1C3R5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:57:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 637DB4BF3;
	Wed, 30 Mar 2011 13:59:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=82FQmqjUNCOLdpL/2VhgtLWk28k=; b=H5Glot
	3grcnkrPjFL+H7kkF6rzJR/RT30vhG5NpVAgzJsv4sbLj8rDCuhaLt6XYtTDzThQ
	qT9Ioeusv5En6VW0JaPUNf6FudZcSf+uxuDWg2RZBDPLrIE8vkTyCHSOT/to4HjC
	0gOPQZrCBUwaTSwUGADpqi9NWcPThVB5DRhfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwYTzNm2ZIbxVBOjkaOF/AtgGZfafVT6
	zbPgLzBwDqgwdEBrDcw6Ti4ILxpc2QhujwdC3kLTWeJneN3FzvMTT1oExcq4hXRn
	WqAGLxvTIL4wG8Fm+Pc2kcm2lbWU1zeg0/RMzrxgDe4aO8JbFJL63u94Uv/E/+0t
	9GA82acrDbE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C67A4BF2;
	Wed, 30 Mar 2011 13:59:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B0C54BF1; Wed, 30 Mar 2011
 13:58:57 -0400 (EDT)
In-Reply-To: <AANLkTim+0gxGKZT=vfmX7v0QZrApjRwAzW3PiLePL-iQ@mail.gmail.com>
 (Maxin john's message of "Wed, 30 Mar 2011 09:52:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66439D34-5AF7-11E0-8278-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170398>

Maxin john <maxin@maxinbjohn.info> writes:

> So, I have modified the patch by incorporating most of the nice suggestions.

I'd just replace /bin/bash with /bin/sh without any other fuss, perhaps
except for the typofix in the comment, and be done with the topic.

The script in the current version may look ugly to my eyes and others, but
there is nothing _wrong_ in it per-se.  Rewriting them in different styles
is not necessarily improvement, and this is only a contrib/ material after
all.

Thanks, I'll apply the early hunks from you.
