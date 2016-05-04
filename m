From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Wed, 04 May 2016 01:19:04 -0700
Message-ID: <xmqqshxyi6br.fsf@gitster.mtv.corp.google.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
	<1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
	<1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
	<xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
	<6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com>
	<xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
	<32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axs1m-0006mJ-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679AbcEDITL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:19:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757674AbcEDITI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:19:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6433D120D9;
	Wed,  4 May 2016 04:19:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dqIk3nyLeWjwoW9tc57tJpocl0Y=; b=ikaUlW
	MkFxNtLt2ZHzs5Mrf8QQ3mGRxOpQE5DuDlSgvvo2HDNhP3ahsc5V2rl4yIujrvmZ
	HFTXvW0RmljA/dFjmjmryZitjj+U268VmxpqqJIU7h3j+S7RebKt8ryOIoDEH0tb
	Iin079sDVQVrK6/+caz3HVeonigbIzUZbaxts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CW35iRqSegF9aNcrZi2GJAD5X4+0WGh7
	aKFjuy6U8W0bXdcu6bP/OEHqVFU6XL+1VAOe5yp3YLEJdB64Gn2ahmZk8yYkScoh
	p3FcK7jOUEYnGBA2JLsK+mnq7gTjnobtgcGaPuB+0qVPSsF0QZtjtplOBHhgbY2F
	T3F21a/9mrY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C80E120D8;
	Wed,  4 May 2016 04:19:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90E55120D2;
	Wed,  4 May 2016 04:19:06 -0400 (EDT)
In-Reply-To: <32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com> (Lars
	Schneider's message of "Wed, 4 May 2016 10:04:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE8DA8F8-11D0-11E6-8290-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293515>

Lars Schneider <larsxschneider@gmail.com> writes:

> A quick Google search told me that "dash" from Ubuntu seems
> to be a good baseline as it aims to support pretty much only POSIX [1].

Yeah that is a good and safe starting point.
