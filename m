From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Thu, 11 Dec 2014 15:10:01 -0800
Message-ID: <xmqqegs5dbqu.fsf@gitster.dls.corp.google.com>
References: <1418290234-21516-1-git-send-email-mail@eworm.de>
	<5489B90B.6070706@web.de> <5489CC60.7080704@drmicha.warpmail.net>
	<20141211234405.3513d5d7@leda.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCy9-0002Vf-HL
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934394AbaLKXKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:10:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934114AbaLKXKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 18:10:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82F1325D00;
	Thu, 11 Dec 2014 18:10:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CXzAovjjxzy1vgZEeOlH5YPmjko=; b=Lg+1DK
	0GropI18gePHBz9aVEsxr3ebnW4EjFhjyXf7G6OqdTVk8ae7wqg8xOsDl/Yce/Q0
	XF7+3J3vmQ26lNjxpusfb9cT7BNh2WxR27vyW29hfyHTI2m128Nvla9g6ZIxRbB4
	gc559DEmc8nc91f5/ApJYaWwtAzyT6c/QlpeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BrQnFbxlNm37xsJY+lIzYePmyGM114QE
	Xovx3d3Hig8sopK2G9QXcJ73bWfJCedLOLJalk4oIasdvIuTLIR6QxqoWHT+jYHP
	mdoSsfZl/KWHrpFzc3DsOgXAzqgbU6Drn++EmIfetPhYvkhP+8pDX2ghRvuL8rrx
	8rFzAOp0soQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 790FE25CFF;
	Thu, 11 Dec 2014 18:10:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F26B525CFD;
	Thu, 11 Dec 2014 18:10:02 -0500 (EST)
In-Reply-To: <20141211234405.3513d5d7@leda.localdomain> (Christian Hesse's
	message of "Thu, 11 Dec 2014 23:44:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D65FD1A6-818A-11E4-8233-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261303>

Christian Hesse <mail@eworm.de> writes:

> However... Even if GnuPG 2.2.x (or whatever future release) will become next
> stable: It will not reintroduce support for rfc1991.

How certain are we about the deprecation?

It also would make us feel safer if we did not have to depend on the
version or keyfile format (which would not have anything to do with
the decision to support or not to support rfc1991 format) to check
if the feature is supported, but that is a separate issue.
