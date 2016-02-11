From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 0/6] Expose submodule parallelism to the user
Date: Thu, 11 Feb 2016 12:28:19 -0800
Message-ID: <xmqqh9hfvvoc.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYt9bw9MreiBhA_ZQNjS+1Xi71aNGwkjcfC1hwxkOoyYA@mail.gmail.com>
	<xmqqziv91qzi.fsf@gitster.mtv.corp.google.com>
	<xmqqlh6rvvwb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:28:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTxqk-0003xq-7x
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 21:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcBKU2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 15:28:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751062AbcBKU2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 15:28:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4DF541E07;
	Thu, 11 Feb 2016 15:28:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YkiVC+6xS6wcEWWfzg+QtT+wJj8=; b=IQzIB5
	aNsuBgNMlmoqKCX0Fj62if8WaLRF9R/C3Dxi9kjOcsvCTtODn5b5l8NWhjQlKwev
	l8efJgtAJXraJf4yi1WwRnbzFjUON+815aaw03yg7CF8yKTOx0HXyvvVjl/q4jhz
	kmHES44dyatHr2o5uvvZ6qbmJh4xL+MYfbYJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e1noabCC9bHYQXiZ+Bjt4KoW4eCILruh
	+TDkOFnE0K5Utc/iTtVdpQvdZJQR7Z8lnXl1o1e0gwAv9Tcw+HvbTym97i6cmlCK
	Dwh+3idCLj+lazbyJ1c1qcLYdCi4o9AcddSf+AD9wenQHVVCeYrzVsdu//43T5R+
	JkbytiiHrw4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBB5641E06;
	Thu, 11 Feb 2016 15:28:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E9FD41E04;
	Thu, 11 Feb 2016 15:28:20 -0500 (EST)
In-Reply-To: <xmqqlh6rvvwb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 11 Feb 2016 12:23:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD8F8244-D0FD-11E5-A5AF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285996>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, at least for this round, I do not think there is
> nothing to do at this point on your end;...

I obviously meant "I think there is nothing" here.  Sorry.
