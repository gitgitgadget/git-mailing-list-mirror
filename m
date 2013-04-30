From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:05:53 -0700
Message-ID: <7v4nendbry.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CALkWK0kUOEygRE8uMJbW=fOV6iGPAap+mbS7mysTHT3Ri+9eGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:06:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGoK-00044i-VN
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306Ab3D3UF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:05:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933258Ab3D3UFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:05:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C1121BB7F;
	Tue, 30 Apr 2013 20:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vo7DzaIzVyDDg8c01Ou37WfDuyY=; b=kRB8OJ
	M/7+Z/meCRaLaCsAVoUvTdNKc42l7IU7xX2gZNMGvm3u356mhE9kJvVKBMOUWsbg
	PQLb1CNMtukOOlMY19Ng92NfWWXIbF8JKj5VR1UaCFERkGavBr2wIsQNHIhKBE8U
	O4arN/L9ihvDzyS3HVrXNUGGOkhYMSFY/2UoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLqE4orbLl/Y4yFHv76DVYaRw1c6q3op
	Lw9tb1czh3TKUi0VHcnH8oA062VLC3U6CUSLJY1rvzyW+7H7FVKtrXe9Kf+mkF6q
	n1qnM7aDXUUvmmyf25/G0brwjfG8434P2A4+WJ1LRz6StbjQse5qlmz5zikLKYgp
	fijikOweL34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E2751BB7E;
	Tue, 30 Apr 2013 20:05:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9A1E1BB77;
	Tue, 30 Apr 2013 20:05:54 +0000 (UTC)
In-Reply-To: <CALkWK0kUOEygRE8uMJbW=fOV6iGPAap+mbS7mysTHT3Ri+9eGg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 1 May 2013 01:23:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D6516D8-B1D1-11E2-B8A4-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223001>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In other words: the sequence "@" is short for "HEAD".

That is saying a very different thing.  master@{4.days} is not short
for masterHEAD{4.days}.

> Isn't that
> _exactly_ what I implemented in my two-liner?

I dunno.  

As design and semantics look still fuzzy (the primary one I am not
sure about is if @ is a ref or just a revision), even though the
desire to have _something_ seem to be popular, I am not particulary
interested in looking at an alternative patch. I want to see the
right semantics first.
