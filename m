From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] submodule: Improve documentation of update subcommand
Date: Mon, 02 Mar 2015 15:05:34 -0800
Message-ID: <xmqq385n9f0h.fsf@gitster.dls.corp.google.com>
References: <87k2yzrpm8.fsf@steelpick.2x.cz>
	<1425337078-24154-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSZPC-00028X-GS
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 00:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbbCBXFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 18:05:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753786AbbCBXFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 18:05:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E83C43D2D0;
	Mon,  2 Mar 2015 18:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqIeD3T+CuPFWuu/tHxn0Ru7ANA=; b=jNmWjv
	0Am2XIx6WJ/6RhkrEJDnBjYByCbE9AA0Rfbo3on7M15hkFSV85ebgwpYVbWNJKLV
	r0WdkrjxtyCNTeefAq09yinkDktWLHNZYUduqIiZ0/2CYxdG+x5N74cAyuo+fO1x
	NJreBHIPT5HjlW7cmnBl4hNkxUz/D8NKQVKsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oeOUVpz+TNrWpja5LUSbNr0xChQLTYz0
	8MEZDL1mADOUyTnTl27yK8ttlxovPPMi1vzZ80IBfguCSN6gEzSthea6nc+zmce4
	/MpcHz5OD8IoBp/GHuNV0zU1v1HFhk1AhpdYr0XqdJxbZbnR3ztyZNDpXdFm0Qu1
	cPq1URsdkFM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDD3E3D2CF;
	Mon,  2 Mar 2015 18:05:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64F5A3D2CD;
	Mon,  2 Mar 2015 18:05:35 -0500 (EST)
In-Reply-To: <1425337078-24154-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
	Sojka's message of "Mon, 2 Mar 2015 23:57:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A25947A8-C130-11E4-AE29-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264632>

Thanks, will queue.  I think this round should be ready for 'next'.
