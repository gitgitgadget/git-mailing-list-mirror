From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Typos: t/README
Date: Wed, 30 Mar 2011 11:58:34 -0700
Message-ID: <7vd3l8o2p1.fsf@alter.siamese.dyndns.org>
References: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
 <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
 <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
 <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
 <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50bS-0005Qq-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab1C3S6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 14:58:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab1C3S6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 14:58:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8CA364423;
	Wed, 30 Mar 2011 15:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cojuNM5TGTwl8Ybqqf1DsF/qCA4=; b=GTfa8c
	8VznIRVvQCYBTXfILNIzbX+ap7BtTqyiwljOdvCRc8zYJeFCjgykNk6bvgtfM4s1
	+7ae3NGWDD1nnKYaQpNxugySD8VWvO3gAFm1COXSyzShTDX5tk+YefqJ8tfPRhHb
	qP+67JmqSGYuOtPRBYmA6yZg57PItMHwi/yHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1FhAaHl6M6bQ3C8ZpYwWciJAyaJdGSS
	35NvNMoBUFujgT9wUQJlfcJtrG3g0L6z4F2l4IZbz4GYUxHKS4Wl26v/5qAPOG5i
	rCPz0HIr4QeSQv9Lb4nAJfMx2ipzAHaRC9r5FygpzM69fm4asOSnBiIttMgbqXCc
	afwlN0y3A+A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A4F14420;
	Wed, 30 Mar 2011 15:00:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7FC02441F; Wed, 30 Mar 2011
 15:00:23 -0400 (EDT)
In-Reply-To: <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
 (Michael Witten's message of "Tue, 22 Feb 2011 17:15:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F91A882C-5AFF-11E0-A405-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170406>

Michael Witten <mfwitten@gmail.com> writes:

> @@ -248,7 +248,7 @@ This test harness library does the following things:
>     consistently when command line arguments --verbose (or -v),
>     --debug (or -d), and --immediate (or -i) is given.
>  
> -Do's, don'ts & things to keep in mind
> +Dos, don'ts & things to keep in mind
>  -------------------------------------

A quick googling seem to indicate that both forms are accepted and widely
used (72k hits for "Do's and Don'ts" vs 45k hits for "Dos and Don'ts" in
www.google.com/books search), so I'd rather drop this hunk.

But all others are unambiguous improvements.  Thanks.
