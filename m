From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/18] Allow demoting errors to warnings via receive.fsck.<key> = warn
Date: Wed, 10 Dec 2014 09:52:06 -0800
Message-ID: <xmqqzjavie9l.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<d81653ce9ef73a54a71613c3e9828ad21f2391d7.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 18:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylQt-0008J5-6S
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 18:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbaLJRwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 12:52:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932268AbaLJRwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 12:52:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1735822552;
	Wed, 10 Dec 2014 12:52:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BsT1aP1IdioseS409Stw0307B0g=; b=WP+ut8
	Nw6+TLEn0lQyl8bxd4qgz4tYT/p+lD9TO0Vr8wjyXMIC383Pm1p28G+lqqLyUgwp
	BLUscis+ZkiwG7G3REjukR08X7i52kE7l98HyjHyAUorrh1A3tHvkFpgM0so/bW4
	GlTiUXy0x0rIcv8u+In17tZ95eEiclLgmSUAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HrPM+wGoc/yIwYAzqNiFEd5LA8cCDddO
	6v/drrLuq8Bssl95BLutz0N9eJDvTc0eeRA1snJcaHrCnRxh56Gd+v4aFxjCnbak
	KCuxlKbpXTMPbTkzD4UmYRFUEl8yoDMj6xwYKEWGxYG4e90j1OOwtD4VlYttejD1
	Xk07ya3pNoM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E14F22550;
	Wed, 10 Dec 2014 12:52:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CA3B2254F;
	Wed, 10 Dec 2014 12:52:08 -0500 (EST)
In-Reply-To: <d81653ce9ef73a54a71613c3e9828ad21f2391d7.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:14:36 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42AED8BC-8095-11E4-B997-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261226>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> For example, missing emails in commit and tag objects can be demoted to
> mere warnings with
>
> 	git config receive.fsck.missing-email warn

No punctuations in the first and the last level of configuration
variable names, please.  I.e. s/missing-email/missingEmail/ or
something.
