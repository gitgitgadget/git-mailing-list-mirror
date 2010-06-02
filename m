From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git-request-pull.sh: remove -e switch to shell
 interpreter which breaks ksh
Date: Wed, 02 Jun 2010 16:37:41 -0700
Message-ID: <7vpr099fay.fsf@alter.siamese.dyndns.org>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfP4zZEkPwPt44bpwlkuoHdyyNRTiITmTBE-eGA_-F-7NiaN6W4MRrlA@cipher.nrlssc.navy.mil> <20100602043046.GB8245@progeny.tock> <DuKPgjmjtglLvPhY13WXeTqBXfxpYQxJ0HN4KDdE6zz0PBeoa6gTbg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:37:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxVV-00011i-7I
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301Ab0FBXhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:37:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933294Ab0FBXhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:37:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4818FB7340;
	Wed,  2 Jun 2010 19:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RXpXIOX3kkuD+zWNpcnEJYTkaOw=; b=TjbNkTB+y/jR9HwTYTllEFq
	m2M7FE7iZh3vdaMmAQ6X66HYVD0xl/zC7DuqoEer/kVJ1QEkNE9XUlD8FFcWW3KF
	LD9nm2eggm91KVapI4FSIc3wf2YaQz7Quhkm6BKJt/0JewrTACPG6VatNWVCoSNk
	nm9R3nDI+qZshiTbU1FY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DDO1n13eD+rNrqV5RxR59ZYyc5G/fGl3gErWWKTi8eg8QUiZ0
	EDPh5D7mQNb7rXeURdPbNSfIP0QIBY3V5D8WXw/WpAP0INYMP14I4r8wjXiIR+KX
	f6XZ0DYLPZ97zbiH91s+xhAYlcw6vJHG/MVo5n1RLcBKEnDCYldaUpx1c8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04BA7B733E;
	Wed,  2 Jun 2010 19:37:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31056B733A; Wed,  2 Jun
 2010 19:37:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9F32906-6E9F-11DF-AB23-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148282>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> On 06/01/2010 11:30 PM, Jonathan Nieder wrote:
>> Brandon Casey wrote:
>>  ...
>> To maintain the old behavior, I think we would need something like
>> this:
>> 
>> -- 8< --
>> Subject: request-pull: more explicit error handling
>
> works for me.

Will squash into a single patch; thanks.
