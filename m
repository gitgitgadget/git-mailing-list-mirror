From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] receive-pack: move execute_commands_non_atomic before execute_commands
Date: Mon, 22 Dec 2014 10:19:40 -0800
Message-ID: <xmqqfvc7a6o3.fsf@gitster.dls.corp.google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 19:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37aB-0006vm-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbaLVSTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:19:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754223AbaLVSTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:19:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86AF928C22;
	Mon, 22 Dec 2014 13:19:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NzjYXr9Vi2c387LvmqWNC8R5KVk=; b=fRTaC4
	pH7LsuBpeEy5PuzgXHSpjuOk8PNt7PkRZFP9LMjCO1aIBGRPUUYV+kqytEEQXw4t
	yM/3O1Jba/dx7SEfLqcam+ilDvcvBsMyAOfNgG4hWAH4uf0dhp8mK0+NaA/o1Lv4
	1kyMWHAmLoTTux1LorF1pz83y4xvRwsGdm3E8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jny7g7e3PDb2+xUg2K5gUzlQyY9NKy/3
	6SJj5NOnBhSoBrL8uwTL4DM8jkzc1BusaBFtlARmkWGuptWOY7JnLK8+sFreNHVQ
	md907ui8firpD/5L+pZasNt7rNlqQl2XvIc2CN+I8XeNh7V5ALY9oxoM8e20A5MU
	oNYWIneQY4Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B15428C21;
	Mon, 22 Dec 2014 13:19:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8D9828C20;
	Mon, 22 Dec 2014 13:19:42 -0500 (EST)
In-Reply-To: <1419017941-7090-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 19 Dec 2014 11:38:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19C1F922-8A07-11E4-B154-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261662>

Stefan Beller <sbeller@google.com> writes:

> Notes:
>     This patch is new with v6 of the series
>     
>     As execute_commands_non_atomic is larger than execute_commands, the diff
>     is not moving around execute_commands_non_atomic, but execute_commands.

;-)

Next time perhaps try "--patience" to decide between with and
without which one reads better?
