From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sat, 14 May 2011 20:21:15 -0700
Message-ID: <7vd3jkr6ms.fsf@alter.siamese.dyndns.org>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
 <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
 <20110514192154.GA17271@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Osamu OKANO <okano.osamu@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 05:21:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLRts-0000pd-H1
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 05:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab1EODVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 23:21:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab1EODVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 23:21:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58CCE5AAA;
	Sat, 14 May 2011 23:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F9PIGU6pYjl3x1bnqvc5Qlb6z8g=; b=G0wfN6
	G9LT/Ic3kDYwvW7KmbYkvE/GZx8h1w1YGAWZvDq4cQehubbAkSmUKji5DrJXWDFT
	5r+ONIB0iHAU09ZP38C8sHHGHaaKKe4TDhhTTKRXjI61J2rAn03/7WdZxzx8IaKi
	yG8haGQAv/67S8gnYYqnuj5IvX3uVarK2LlSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bUpJW0JiLmghulmseXzrOWozVwlOfW3r
	eOUPVLvTCilQWXzvsumgouV+K3QHZSkS3aNV3GQfBR6zTzLoF0mcHgJUNIwpXEK/
	9zxR99EGh41hz+bCPFEC+VCCLk7b9GFN9GVMp9k/je2q6ixbBB1FFDDQ/u4L3Cg3
	/X7wg9Ji7Mk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 183095AA9;
	Sat, 14 May 2011 23:23:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 832085AA8; Sat, 14 May 2011
 23:23:28 -0400 (EDT)
In-Reply-To: <20110514192154.GA17271@elie> (Jonathan Nieder's message of
 "Sat, 14 May 2011 14:21:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6F184A2-7EA2-11E0-A811-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173615>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Another thought I have had occasionally is that it would be nice if
> the versions committed did not have line numbers while the working
> copy had line numbers, so an ordinary 3-way merge could be more likely
> to work for integrating changes[1].  But this second thought is less
> fully cooked. :)

I would rather see that done as a customized content-level merge backend,
i.e. at the same level as binary and union merges are specified. Losing
line number information just for the sake of the generic merge that does
not have domain knowledge (read: "stupid") is a way suboptimal solution to
the problem, I would think.
