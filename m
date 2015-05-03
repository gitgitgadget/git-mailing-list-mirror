From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch] Added http-protocol for git in the Documentation folder
Date: Sun, 03 May 2015 10:56:52 -0700
Message-ID: <xmqqlhh5v923.fsf@gitster.dls.corp.google.com>
References: <CAKB+oNsPzoBRUn6rD3Bb8soHEub3quT76MB25KyWfcEC1smdJg@mail.gmail.com>
	<CAPig+cSJWdrS-bBXcHE5ZmpZ3Aj8tKehXgFan6=4qxzrNKG8zA@mail.gmail.com>
	<CAPig+cTVMhSwQ_z15GLCn6AmAsm6Pv0RJuGxpVg2CnX8whp8Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alangi Derick <alangiderick@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:57:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yoy8Z-0006Mv-5O
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbbECR45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:56:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751409AbbECR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:56:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 248A74C243;
	Sun,  3 May 2015 13:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5zfyxkiLecb9ZudZ8K75USXDQDc=; b=Gj977T
	A4xkD+qdv0QMx1Fldls94KYfjo3w0SsChoHcFUh4UlMhMASXO+jLKUPadBlVOX1T
	KjGXkcq96efS9yKv+1syBL3nGb7639nypmxeW71ZCiHN/Dx+Ol3Kyxhzoj23KTo/
	NmDL0ugYUdbJX/k0p+VI8u+WPBRNiYunhdmsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x5AxOtIET6VbuICEuhx6NFvN4Pooc5nz
	770kzLP/2LH2fLUpAnQ/iPygZDBKH3esdPUJoGfhTuvmhySPIQxAyueegB6uo7He
	8CrEQ7rAYlgmHhHcCzRucF1L+V1Gy3kM5RZevJeSjo9an/cU/TUzdG5RC+ioOuTE
	LJNp9YJAeSA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19B444C241;
	Sun,  3 May 2015 13:56:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 915314C23E;
	Sun,  3 May 2015 13:56:53 -0400 (EDT)
In-Reply-To: <CAPig+cTVMhSwQ_z15GLCn6AmAsm6Pv0RJuGxpVg2CnX8whp8Yw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 3 May 2015 13:15:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C817D316-F1BD-11E4-A074-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268280>

Eric Sunshine <sunshine@sunshineco.com> writes:

> By the way, the entry in Junio's "Leftover Bits" isn't about importing
> http-protocol.txt, but rather about fleshing out all the TODO items
> which are still present in the document.

Thanks for saving my time ;-)
