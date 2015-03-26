From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify "preserve" option wording for git-pull
Date: Thu, 26 Mar 2015 13:22:27 -0700
Message-ID: <xmqqsicry0e4.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuMcKAhW+_Ho8X1kzZd3B57ogu2Anb1nuPmKwRQD=OYrZQ@mail.gmail.com>
	<xmqqh9t7zmkt.fsf@gitster.dls.corp.google.com>
	<551467E9.8080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 21:22:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbEIW-0001my-5o
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 21:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbbCZUWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 16:22:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752993AbbCZUWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 16:22:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8099423ED;
	Thu, 26 Mar 2015 16:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rohnCL9ggr89HPSF8WuCk82TLxE=; b=wYKds6
	G9RkY7WEC9zstUqJzn6X/HJ1UQfDnIph9XaXm6ZENjIorVKu9Jh/8Kkfo+yBMWdF
	afqBqaNbA0ewAsYrBhfxsWRZTpmnG1/ExthzO4DnKe15n5GYHJylI0OOM9MvvDBq
	iW/qfUObUhiS7D3rSi37a39a8qS8nwieVwovE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCIyjsQDfRUIyRJCfZprHN5OSV70fbfg
	J2KaPPBVtQFV1nnLkwV4Hz+3w/r6Cyt41g44xRIlXQ31ONOTgoJ7vL3g6tzsCb8A
	KB10rKCSrgX5xbJw9L5fyDjm/+FN+ytUeL57/Co5qhj85NlDKofIi7IKnYtN6pus
	QqnOVyp1xX0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFF29423EC;
	Thu, 26 Mar 2015 16:22:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DC4D423E9;
	Thu, 26 Mar 2015 16:22:29 -0400 (EDT)
In-Reply-To: <551467E9.8080409@gmail.com> (Sebastian Schuberth's message of
	"Thu, 26 Mar 2015 21:11:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D340DB92-D3F5-11E4-AFB6-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266344>

Thanks; this time I do not see whitespace breakages ;-)

Will queue with a minimum tweak of the log message.
