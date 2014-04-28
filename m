From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 16:40:06 -0700
Message-ID: <xmqqk3a9m3ah.fsf@gitster.dls.corp.google.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<535e18cdc7bce_338911e930c72@nysa.notmuch>
	<87bnvl6bdg.fsf@fencepost.gnu.org>
	<535e8e4253196_45651483310b3@nysa.notmuch>
	<152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
	<535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Denholm <nod.helm@gmail.com>, David Kastrup <dak@gnu.org>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:40:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wev9p-0002ZX-Ef
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbaD1XkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:40:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbaD1XkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:40:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA31781039;
	Mon, 28 Apr 2014 19:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iw3F5j3jnf4l9dqbBSk7c5gnLhE=; b=qrjx2u
	GDVoUV4RFDIqpuJc31ASkixBnpsz1BQYFFQYh6qwPogKKpwLaEK7MZecGNcWIaT7
	Pq6gz8we9t0nVLkqhcfn8/o/Lb1ehQkjPVa0J0/SHhY6dmNOz2Abi1TE5dnQduL1
	VwJsSSOTy+YBAoTlGKffdR0TzdIaKhkd/pPHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ueNS7JkndJNlF44IqdvdSIWhJOm6l5Xk
	7Pf/C/RIMM7DyRtm4FRpUF0q10vSFsuxnj72SBZam5pOwjLh5I4ulA2LXdZNT38F
	HUtEV4lFcaLRx7ek4cg0ejIAQycIYzupLOUdCsHUeIqEy6hD7YHZtEe/mklmEqt9
	tbK9ztWWa5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C56E981038;
	Mon, 28 Apr 2014 19:40:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEB1581034;
	Mon, 28 Apr 2014 19:40:07 -0400 (EDT)
In-Reply-To: <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 28 Apr 2014 18:09:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E73AC02-CF2E-11E3-B36F-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247497>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Except that in this case virtually everyone agreed the default was wrong. I
> already said that.
>
> Clarly you didn't read the relevant discussions where everyone, including Linus
> Torvalds, agreed. Did you?

My recollection is that everybody agreed that the default was
wrong.  I do not think I saw everybody agreed the patch you are
championing is the right solution to solve that problem.
