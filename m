From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit synopsis typo?
Date: Mon, 29 Nov 2010 12:24:20 -0800
Message-ID: <7vlj4b280b.fsf@alter.siamese.dyndns.org>
References: <20101129173758.GA2279@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAH2-0001ij-GX
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab0K2UY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:24:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0K2UY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:24:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 970A53797;
	Mon, 29 Nov 2010 15:24:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+TCGKTcQu/5e6jniwtDC93ToA/M=; b=X29FcTzHwmm4p64Y2GvC+AD
	9MNdJd2O4CnoU8XXjbBq9bJFrDQztCe6a+xdzGuQRQy5wvyK6WM/Y+u1WAbCbO+B
	8vEx8XgAnaJj03mjYu/a4KmBvhc+dTkdPcs8sifSuqzjvPQp5wnPG48t+z9iCA3N
	qx+HeESktDNBMgLzz5i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gEyeM1LJJbfk5YmU5liZA05Tpp6WInlFDxXgfHjlxbfqkFL77
	wzU3L4Y+7z9t6E8egT0eVQe8WiLThoUk5XO+QK/w3ClNgyhQfEddDZlUnYtlazyZ
	WaPCRex6VaAJ+qjeMH36xNPculC/wXnWbg5bbzn4KgowS3S51xkX9zVxbA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A9393796;
	Mon, 29 Nov 2010 15:24:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71D5F3795; Mon, 29 Nov 2010
 15:24:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2C0DE98-FBF6-11DF-8AC9-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162427>

Joey Hess <joey@kitenet.net> writes:

> Shouldn't the -i and -o options be listed before the -- option?
>
>        git commit [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
>                   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
>                   [--allow-empty] [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>                   [--date=<date>] [--cleanup=<mode>] [--status | --no-status] [--]
>                   [[-i | -o ]<file>...]

Yes, please make it so ;-)

Thanks.
