From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Tue, 03 Sep 2013 12:53:11 -0700
Message-ID: <xmqqob89r8bc.fsf@gitster.dls.corp.google.com>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
	<1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue Sep 03 21:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwfB-0005cC-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760521Ab3ICTxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:53:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755975Ab3ICTxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:53:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BFC63E58E;
	Tue,  3 Sep 2013 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JDtvqQu3zCz6RqbHL1cBiNo2wV8=; b=BhY4rw
	YaPl5WbxVUQHVOj7BiT8+S6P2pQoGpckVRF4Ia59lXDKEVv+RXktm5EEy17TQB84
	P3zukJayK3DwktbYdxSvzruB8gK8S+NSDuIUjNrWE3jdv4RgC81aS+kBpHt1C1YX
	b144mNGCDy4zFBlePY6Vu4UFen9p4kdxpUMVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3vBrFUp2wf+ggnGbuqhatDn+1sl9hzR
	Op54po1kBKeqxKM6czVpnqb/ws/Zs0vEcGCcrcCLpzT8NuzhUF9XU7n4BvdRXTVa
	jYoGvIIYPkBj3ws3Wrp64grswj2YZlEt2E/0zU6Wizx1ZE90fQ+t1koJCeEydLVg
	ZHRkvEs8z1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87A983E58B;
	Tue,  3 Sep 2013 19:53:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 268943E576;
	Tue,  3 Sep 2013 19:53:13 +0000 (UTC)
In-Reply-To: <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 1 Sep 2013 20:06:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 782DE490-14D2-11E3-AE22-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233768>

Jens, I see 1/2 is the same as the previous one you already acked.
Does this update to 2/2 look good to you?  Sorry, but I lost track
of the discussion that led to this reroll, hence a ping.

Thanks.
