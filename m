From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feedback on submitting patches / here submodule
Date: Sun, 09 Nov 2014 09:38:47 -0800
Message-ID: <xmqqtx28clzs.fsf@gitster.dls.corp.google.com>
References: <D08510BB.15149%th.freudenberg@gmail.com>
	<545F955A.1050700@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tom Freudenberg <th.freudenberg@googlemail.com>,
	git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:38:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWRy-0007KL-2U
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaKIRiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:38:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbaKIRit (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:38:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16CE11AC51;
	Sun,  9 Nov 2014 12:38:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEW2T8B9+o8oy70JGeF26NEdDkc=; b=EnqR5A
	tGXi74gR3cPesxFi7Axx6+kXj/LbM3uAaqsN9phHQG/UypZ27FTOihykiQTfmlVi
	SB2uXdsP0cS+FIv260LuzuuiXCtcq7L3RSzbyq+ll/c7QY5KVDfsmsnbYGNz4Lp1
	tBwaNJ+RiRmwEAEeMEsMxiKYydbVYdFmf5PPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgy3sIMGcmo4K23jCnHuAqLlG0/RI4Hu
	6czL4LGjzXOzis0W3rtGxZRUl1xCtEJjCT0xmV7dv0mi8/DBiyCtdT14lzAQTeV3
	kGarjfgR+/oMYAfxruoaDjduBGkwixvqV70osjoIboOxC+A79L1cjZVulW9Ii/KQ
	UTTKFuEt7RY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B0B61AC50;
	Sun,  9 Nov 2014 12:38:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80F151AC4D;
	Sun,  9 Nov 2014 12:38:48 -0500 (EST)
In-Reply-To: <545F955A.1050700@web.de> (Jens Lehmann's message of "Sun, 09 Nov
	2014 17:24:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 430D4878-6837-11E4-9651-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

> A patch should go to: gitster@pobox.com /and/ cc: git@vger.kernel.org
> (and optinally any people relevant to the area you are touching).

No.  A patch should go To: git@vger.kernel.org and Cc: those who are
involved in the area, and after those involved in the area agree
that it is a good change, please Cc: me with acks from them.

For submodule patches, I am unlikely to be on the To: or Cc: list of
the initial proposal.
