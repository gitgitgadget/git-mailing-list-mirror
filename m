From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Advise on a push only repo
Date: Thu, 15 Jan 2015 14:24:28 -0800
Message-ID: <xmqqegqv65sz.fsf@gitster.dls.corp.google.com>
References: <9782FD24F9FA45659CCE5171E73E49E7@black>
	<xmqqa91j7sej.fsf@gitster.dls.corp.google.com>
	<4C328D132E8343F395AA9A72CC3BD4C1@black>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBsqF-0004dc-0w
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbbAOWYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:24:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932110AbbAOWYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:24:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E2DE2F67B;
	Thu, 15 Jan 2015 17:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Snaro+ETy7qATYKG/SsyfdsAx0k=; b=oa96DG
	NgFmrMeerA+ftW3+44jS+7K6bMQ+bEofrbAy4CsA3lfBDrk1ddk5JPZulUCxxiWY
	i+zz6jpgYgX+uZMM10Azk7RRkUOAbxW/WGMuZtkbgS1sjmAG9uSao7wKTeBZ5GcI
	FMwAQdGOMvJUTegpmpwgOW5adYqoIIFowu1rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TkP7eytAnKB4ULZ4v1bMHdNHLix5H73o
	rHH/0GGRkyKvYBI3lIdH+tbarY2YwbL3K00L2i9R1RLYyAGg1Fq9JoXqj9NFsDJd
	cA3GEDDC2/sYT/+z0mzIo/jVQVGMOgRoW+p0w40ClL5g4IMNVsYortWXoZRTgIAb
	0BRXOonu69Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 138482F679;
	Thu, 15 Jan 2015 17:24:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A3872F676;
	Thu, 15 Jan 2015 17:24:29 -0500 (EST)
In-Reply-To: <4C328D132E8343F395AA9A72CC3BD4C1@black> (Jason Pyeron's message
	of "Thu, 15 Jan 2015 17:13:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 459F4D7C-9D05-11E4-ABB0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262512>

"Jason Pyeron" <jpyeron@pdinc.us> writes:

>> Looking at http_config() there, I would guess perhaps:
>> 
>>     [http]
>>         uploadpack = false
>>         getanyfile = false
>> 
>> but I am not sure if the latter is needed (or anybody seriously
>> tested it, for that matter).
>
> Perfect! Had to add receivepack=true for the anonymous part.

Good.
