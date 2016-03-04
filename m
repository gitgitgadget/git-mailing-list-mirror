From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stripspace: add --line-count flag
Date: Fri, 04 Mar 2016 10:49:04 -0800
Message-ID: <xmqqk2liyt7j.fsf@gitster.mtv.corp.google.com>
References: <1457116723-20206-1-git-send-email-tigerkid001@gmail.com>
	<56D9D750.1030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:49:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abumn-0004sd-5S
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389AbcCDStI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:49:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755989AbcCDStH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:49:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E7C946B79;
	Fri,  4 Mar 2016 13:49:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ww5mGM1fUOmoQHCPXCh6k8aZc80=; b=GGZXjA
	5mljVGG5KdU2S8RF0hwdCjS8MMirhstYVHcvxASFGcUgBISbUPNGvI+8qx4jCsr8
	5yAclTU6Rjv63DXOg40U4jq+crPIDCN4NAsNA8Y8ce5VDmsFpDdGHElp5nx7WM+Y
	IFBvjUi20DafVRwMqyRQT6QSBjT+EUO7ifo4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qlCN3LR2/WlNYmyWdYuYF5DIP29Gbgv7
	WWIC48oo6AmM4ehP/8U0QnRIN7/EV+LPRabaNKX1muNzabFq4wy0FE+65XOpCn5F
	LJD2eNAh5ANyUodBxScfQSdgKYxx1rrvDcuZVLDpDeC5YJgyOn2Im9BM0/QhQW89
	dZyQadeWzVc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06D4346B78;
	Fri,  4 Mar 2016 13:49:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D36A46B76;
	Fri,  4 Mar 2016 13:49:05 -0500 (EST)
In-Reply-To: <56D9D750.1030703@gmail.com> (Sidhant Sharma's message of "Sat, 5
	Mar 2016 00:13:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5441E20-E239-11E5-B1BF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288269>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> This is my first attempt at the small project listed here: https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27.

> Comments?

Isn't that page somewhat stale?

http://git.661346.n2.nabble.com/PATCH-0-3-stripspace-Implement-and-use-count-lines-option-tt7641360.html#none
