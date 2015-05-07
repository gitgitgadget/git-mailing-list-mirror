From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed translation error in config.c file
Date: Thu, 07 May 2015 07:01:50 -0700
Message-ID: <xmqqlhh0scz5.fsf@gitster.dls.corp.google.com>
References: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
	<xmqqpp6ds5jh.fsf@gitster.dls.corp.google.com>
	<CAKB+oNtkKQ+za8VkO0B9m0K=UqNoOSn_+zwZeFW_aOiV7Wk5aQ@mail.gmail.com>
	<CACnwZYd-hhS2w33rsQ9xR__gdnCUC8ni2ot=KqViWLNjnWFhjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alangi Derick <alangiderick@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 16:02:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqMNC-0000s3-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 16:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbbEGOBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 10:01:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752084AbbEGOBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 10:01:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 880B74CDED;
	Thu,  7 May 2015 10:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7OYOka6Olhibl5Iy9NG6+axshZA=; b=I+5Q7/
	K9/yZJvkwiQ1oXRQqplK1pXNrJx8TrIyUnsWSffTaCOjFTXg66VknDn/USfYA4Xm
	Q7403McaeGalgJv0ydmKZ5o3VXnMz321AZ/8PD20WXgQ/hZviMH/7mwu5jJVW/f2
	SQadzjsBSNjgXU2NrjYz5xkPpYH2Koo1lWml8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Knxs/33fT2Ng8PNG2gRWAgPUu58yIy6+
	LQ/r4EKlX5RI0k3Lj0PJU7J7Nqyo7GgWZx7FG9HI1gwCvrVdMOuiSOxiYgjBexAG
	0dsUgL7n+aUjxH2CQqGOi8v8q/x0B5PEymMyzbuuHUK+nJr4AL+NyDM5KB2F3QWb
	RSJEEoJOa2I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EF644CDEC;
	Thu,  7 May 2015 10:01:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C28B04CDE8;
	Thu,  7 May 2015 10:01:51 -0400 (EDT)
In-Reply-To: <CACnwZYd-hhS2w33rsQ9xR__gdnCUC8ni2ot=KqViWLNjnWFhjQ@mail.gmail.com>
	(Thiago Farina's message of "Thu, 7 May 2015 10:39:30 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C6C085C-F4C1-11E4-97AE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268530>

Thiago Farina <tfransosi@gmail.com> writes:

> On Thu, May 7, 2015 at 8:36 AM, Alangi Derick <alangiderick@gmail.com> wrote:
>> So what should the Title be? Please i am learning this community so i
>> have to make a lot of mistakes. Pardon me.
> Allow me to say something? Forgive me if it sounds rude, as it might sound.
>
> Git community is highly technical and is about developing and
> improving Git scm tool.
>
> To be honest, I think it is not a place to learn C or how to
> contribute to open source projects.

FWIW, I do not mind explaining things to new people. Teaching new
people is how you grow the community.

I however have finite time budget for that kind of activity, and it
annoys me when I see that an earlier suggestion was apparently not
read, and a question is asked when its answer is already in the
mailbox of who is asking it, e.g.

  http://article.gmane.org/gmane.comp.version-control.git/268484

in which I had to repeat what I said in:

  http://article.gmane.org/gmane.comp.version-control.git/268335
