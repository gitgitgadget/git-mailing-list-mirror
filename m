From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] command-list.txt: fix whitespace inconsistency
Date: Fri, 08 May 2015 12:37:56 -0700
Message-ID: <xmqq8ucylv1n.fsf@gitster.dls.corp.google.com>
References: <1431113375-10410-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:38:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqo60-0003x9-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbbEHTiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 15:38:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbbEHTh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:37:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D34394E366;
	Fri,  8 May 2015 15:37:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aMVJFFLMy/uEF4SjBY3ko1M8Nz4=; b=HC9XK2
	5rJaojx1l3eOqHOzM0W+yFzyZiDLwF9jZ1z8oMYGhkCMIkutzuAMs8UlS6UX6uuh
	ZkbYfaGjCIkC7CQu3Ub5n7ced3OpiYE5K/BElIgwF7g3SWyhE2JgnvNa50iVcN5W
	rCYvJMsIuw5c2Upx4ZDcjhk7tcufe14JZIbHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOawISiVVhHVfJvzFdTvayGXKYb9JZdP
	jMW6h0hEc4HuHb4L7CSpEttvWnoMjKzvtlpzHoYaJM0duc6OCeFtk8c2gtFU3StG
	sDG+ZAqPGtu120PJFNVPAEzZL3caYWC+Wk3uTttHod5Mf3stbsUo9MBThQ/cXl7X
	4w/IZVeQnkE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC6424E365;
	Fri,  8 May 2015 15:37:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42EE34E364;
	Fri,  8 May 2015 15:37:58 -0400 (EDT)
In-Reply-To: <1431113375-10410-1-git-send-email-sebastien.guimmara@gmail.com>
	(=?utf-8?Q?=22S=C3=A9bastien?= Guimmara"'s message of "Fri, 8 May 2015
 21:29:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BAFD4DE6-F5B9-11E4-ACB4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268650>

A good preparatory clean-up to decrease the patch noise in the real
series.  Thanks, will queue.
