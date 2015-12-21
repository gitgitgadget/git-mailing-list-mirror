From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/3] git-p4: fixing p4ChangesForPaths
Date: Mon, 21 Dec 2015 11:27:33 -0800
Message-ID: <xmqqlh8nfvq2.fsf@gitster.mtv.corp.google.com>
References: <1450517980-1744-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Sam Hocevar <sam@hocevar.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 20:27:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB67g-0004CE-EX
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 20:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbbLUT1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 14:27:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751696AbbLUT1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 14:27:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE760334AD;
	Mon, 21 Dec 2015 14:27:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9isH/qJmDVPeF/Ithlm1xZH88Sg=; b=Ky4MvX
	ydYnE8aPH454A7rEhavtaLYGEf3D8PUvA1x7fRpO/ZtUzMap8Hft1koy3x40gOEv
	LE0ZmDjEe4VkkTOzhQI/7aYXiSe0o2diXyfh/EsJMsk1AQxddLocKmRaXm95YysZ
	mrkssX8ZAw3/VN6SxyRMVO5Os/q1xq5a73ji4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/w7kK7w48sb/HtrTdu/iIwfatKDp9O5
	uHDxAahGMXkLQjuyW1DahI6RHLrRYeVeqqIrT/Qh/1yT5DLaeTEe39oidSNOb/dA
	56U4SDSzwbyL34uiLfGbUvCJwX8Qx8AIwjn4lFzOYRqdW3HVvS2D9NiUi9JHOL+Z
	efIv73g+2vo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D64C6334AC;
	Mon, 21 Dec 2015 14:27:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 307A6334AB;
	Mon, 21 Dec 2015 14:27:35 -0500 (EST)
In-Reply-To: <1450517980-1744-1-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Sat, 19 Dec 2015 09:39:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3615B30-A818-11E5-97A5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282810>

Thanks, will replace what was queued on 'pu'.
