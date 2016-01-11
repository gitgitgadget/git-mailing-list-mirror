From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Ensure that we can build without libgen.h
Date: Mon, 11 Jan 2016 14:59:42 -0800
Message-ID: <xmqqpox7vi1t.fsf@gitster.mtv.corp.google.com>
References: <cover.1452270051.git.johannes.schindelin@gmx.de>
	<cover.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIlRF-0005Oc-6h
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 23:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbcAKW7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 17:59:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753955AbcAKW7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 17:59:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2476F3B767;
	Mon, 11 Jan 2016 17:59:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cUTG4L/ou1qeX/x2edcPOf6jST4=; b=O9AenW
	QsYp48ohKEK/uLhPiyzSpXQ7t9p1bnjeAJQvij8wXr+7qQqqQNmqIk8gPhyrUx5E
	ZyXV8FtW2UCZFoBiGHUYcAHyYGcpwQPWcIRTJ/kz1JX8BRltuhZUcOPBd8Q6R/Wg
	AIIKqa/I5MlWYjf7e9FDcyH+4pO6XuxQRWwmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xfxrViHEYh/Ti+6PUOlcytjk9abaapCJ
	axtnLadIY5waddgZSYyct86NViYSTk07N2/vrtcHTLBtnL+Rikcn6OmErIf9UkwC
	SC13T/092LjTSWJmzkNcWiw5z/fzJTOQOHzT5GNV3AdNM/KQQ29Ogy676/9NKyWG
	MajYp8IYl30=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 102453B766;
	Mon, 11 Jan 2016 17:59:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 861823B765;
	Mon, 11 Jan 2016 17:59:43 -0500 (EST)
In-Reply-To: <cover.1452536924.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Mon, 11 Jan 2016 19:29:41 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00BD8592-B8B7-11E5-B3B7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283733>

Thanks.  Queued but I am OK if you agree it is better to replace 3/4
with Eric's.
