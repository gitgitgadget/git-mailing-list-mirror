From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use "--no-" prefix to switch off some of checkout 
 dwimmery
Date: Mon, 19 Oct 2009 00:25:46 -0700
Message-ID: <7v63ab7slh.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <20091018210222.GA5371@blimp.localdomain>
 <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
 <81b0412b0910182307n53b4a51cvaa14829ea8b40207@mail.gmail.com>
 <81b0412b0910182312h583e74e4v2678eb4375164c34@mail.gmail.com>
 <7vhbtv7vsr.fsf@alter.siamese.dyndns.org>
 <81b0412b0910190017o2e6dfd47v868517404d362843@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 09:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmdG-0008Pp-IH
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbZJSHZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbZJSHZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:25:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbZJSHZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:25:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEB6B7D8F6;
	Mon, 19 Oct 2009 03:25:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2mVhWAIzGNEFe4LGCSKnHcl2IY=; b=IbHVEc
	+0EFqaV8XhiKGPnjp2xwXxnjHwpY/Su2XiNSdkGHq6FxZNTRgzSZoiU3NQOMiSSl
	VLrjOmUWWPGQ7IXMBKm54x/fD6yuSS0NIDRPGG0mu8azGwckN7eXvOul1hnZ4v9V
	JwANRubLfeeF7UA8HckneX6jxXtnuj+HprSo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=onY25MjrHKD7qT2fTusc2UVw2CMe1xfy
	9eYn1vOn84EQA8dsbpu/KVStex7i65LIcBxR8dRsc1DGzRdB7mjBgt4/sjwgu0Bf
	JuyLNdnGZHed0xTJFg1j31hermOlFMbPwb/Ou9XlBzxgLLBixqeQ2MyeA2e5Wg8s
	6oKronmoi8k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A70EA7D8F3;
	Mon, 19 Oct 2009 03:25:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16F737D8EF; Mon, 19 Oct 2009
 03:25:47 -0400 (EDT)
In-Reply-To: <81b0412b0910190017o2e6dfd47v868517404d362843@mail.gmail.com>
 (Alex Riesen's message of "Mon\, 19 Oct 2009 09\:17\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A32153A2-BC80-11DE-A8FD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130665>

Alex Riesen <raa.lkml@gmail.com> writes:

> BTW, why is the option an ...INT? Where a future extension planned?

No, in my original I wanted to default to 1 and an option to set it to
zero, only because I did not want a variable with negative name.
