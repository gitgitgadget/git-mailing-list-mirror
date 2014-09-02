From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] MinGW: Update tests to handle a native eol of crlf
Date: Tue, 02 Sep 2014 13:49:53 -0700
Message-ID: <xmqqk35lzr0u.fsf@gitster.dls.corp.google.com>
References: <5402447B.3080700@web.de>
	<xmqq1trt25zt.fsf@gitster.dls.corp.google.com>
	<54062052.3070106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:50:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOv1d-0003gD-F2
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 22:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbaIBUt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 16:49:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56601 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183AbaIBUt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 16:49:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55C3737405;
	Tue,  2 Sep 2014 16:49:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u2aupzJaf61T
	OnzKx1R8d5mo6qM=; b=fff/ABznJrLY/N/rY2m1F1kR1VX8tWBd9mcx64FsdWFR
	LGVnqxyWBIjmWvvmZ71skpeYPh2siBT36lcTDrA+Y8XGB2d1IHpV6IFyVsSY5stp
	aU/fwhgTu72VQVYIuPb6DRhpTqhOboSI2cItssnNfWalK9s10rPyD+Ybbne008Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=edeCXT
	ORatS2fPYAt4M+CKolrphcFz0RiV+LQy0pKPGw/IkMrJmKbiHMyOxXOlVlYD1tkS
	7/sjAdoKHepbYfpACAmJR0UvqXpdNdBTg4SOWJBoaU+8P9dnBAGtyG5jeqTYFUmM
	YDIXYqiKSeDR71ZpJwD7TfbwCT0eD3SYi7Omk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C9C637404;
	Tue,  2 Sep 2014 16:49:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCA2B373FF;
	Tue,  2 Sep 2014 16:49:55 -0400 (EDT)
In-Reply-To: <54062052.3070106@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 02 Sep 2014 21:53:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B202F802-32E2-11E4-A766-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256344>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Should this be marked with "From: Brice Lambson <bricelam@live.com>"=
?
>>=20
>> Thanks.
> Yes. If possible please squeeze.

OK, thanks.  Please double check the result on 'pu' in several
hours.
