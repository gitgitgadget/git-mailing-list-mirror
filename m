From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Graph log and orphan branches
Date: Wed, 30 Dec 2015 11:54:14 -0800
Message-ID: <xmqqziwremqh.fsf@gitster.mtv.corp.google.com>
References: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Carlos Pita <carlosjosepita@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEMpI-0002po-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 20:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbbL3TyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 14:54:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbbL3TyY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 14:54:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3091835EC6;
	Wed, 30 Dec 2015 14:54:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+bV/ulBRBXApArT2qZyKFpWN3uo=; b=ufRSOC
	iLr9x9wjKa8QRQgsqerr0r9+mpBA8wKNK8UOLBbaUjIi8gjzaXHmFreYWIbe5E26
	MJ1cEgXVYXeZWxFu9dqmupDmyPjTpw/HMsAv2FTe9SSR4JIc8DxVViv8/Vpq6tIV
	epe+OSkodbpZAPcbzUvl3DQzMG+l4N7sgVufA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGKpibSUPXTqNKdSUL94Pl5N9mOdJQ9n
	ie1x4jvQBBwABbZjpXxuG0JQqIcjytzulbGT7ILojJ51opx3I81ZvesI9ri5kbLz
	A1hXO6SObS5VI41siGlLTmbf6C2OnYzGyq8LnITPqMKrRmx/2UxLO5bXxexQhdho
	r+Pz0I5TFyY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26D0F35EC5;
	Wed, 30 Dec 2015 14:54:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9756A35EC4;
	Wed, 30 Dec 2015 14:54:22 -0500 (EST)
In-Reply-To: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
	(Carlos Pita's message of "Wed, 30 Dec 2015 16:46:08 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F312C22-AF2F-11E5-93F8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283193>

Carlos Pita <carlosjosepita@gmail.com> writes:

> the graph output of log show orphan branches in a way that suggests
> they have a parent.

Reminds me of this ancient RFH topic

  http://thread.gmane.org/gmane.comp.version-control.git/236708/focus=239580

which unfortunately got no help...
