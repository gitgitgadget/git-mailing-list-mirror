From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sun, 09 Nov 2014 09:58:22 -0800
Message-ID: <xmqqppcwb6ip.fsf@gitster.dls.corp.google.com>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
	<20141108110958.GB20750@peff.net>
	<20141108123554.GA90057@melamine.cuivre.fr.eu.org>
	<20141108142753.GA28652@melamine.cuivre.fr.eu.org>
	<20141109095155.GB17369@peff.net>
	<20141109123934.GA50956@melamine.cuivre.fr.eu.org>
	<xmqq389se0up.fsf@gitster.dls.corp.google.com>
	<20141109174738.GA58680@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Quinot <thomas@quinot.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWl1-00034r-0W
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbaKIR6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:58:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbaKIR6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:58:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C88ED19026;
	Sun,  9 Nov 2014 12:58:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7LlCE4+y72NDntgJKte7fuEsgj8=; b=CjQJPa
	jCUQiEAGBq1yjDDAkDzcWP9Wy0A1V/7VDAf/vk3uelDIzXCWE4gs/WWHk55gFcTj
	gnBD281i/TJkEWfUYzitj8NzDmVxhQsd9N8Me7hvAgOsM4CF1p1nQpcRqG4NeqSK
	y4em8RfOE7pQ9ggUBMouzmgjtdrFnDEpZ9iZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OjtUyCYo3GEqGwXPFCVrBn9SkY8gSkam
	R3vT8DCnUEp3vKlAIBN+TzX77VMc3cqwnBt9SRRUGxGtNHX29aDCrlHX5u7UQwzR
	yLNb1/k4nedSVbI5xOkEo5D+p/ZY72eNR0ZGNzS93Ty9FNIB7St/OjlCSdrd18NW
	Q5bNfHHS2hM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF30C19025;
	Sun,  9 Nov 2014 12:58:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 481CE19021;
	Sun,  9 Nov 2014 12:58:23 -0500 (EST)
In-Reply-To: <20141109174738.GA58680@melamine.cuivre.fr.eu.org> (Thomas
	Quinot's message of "Sun, 9 Nov 2014 18:47:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF449D5A-6839-11E4-ADCB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Quinot <thomas@quinot.org> writes:

> * Junio C Hamano, 2014-11-09 :
>
>> Whatever.  I loathe the CMD abbreviation, though.  Why spell out
>> SHELL but not COMMAND?  I.e. GIT_SSH_[SHELL_]COMMAND
>
> No strong opinion :-) GIT_SSH_COMMAND looks just fine to me.
> (GIT_SSH_SHELL_COMMAND starts to feel a bit long...)

Yeah I agree.
