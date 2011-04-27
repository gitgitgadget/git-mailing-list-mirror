From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Tue, 26 Apr 2011 22:17:05 -0700
Message-ID: <7vsjt49stq.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
 <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEx7z-00039h-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab1D0FRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:17:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1D0FRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:17:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B61E25C7C;
	Wed, 27 Apr 2011 01:19:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ctm2/uZp1PPtshMARcklpoWbzFU=; b=ql+Hfd
	mKW2Xp8xu1HDnhIwXXZjMX41ZZ3eVCS6xEx88NVp1TPGQ1/sKIQuHhvpdSlkWVe/
	9erLxEnIkSYwleBAt8z7WSI4ZZScFmrxyLg5swn9XOBvapDyFDjXT7fq+gRm3n8I
	xvj4MOHy6eqMAJ4D2SmlJlLOW6Etp9RjJjGVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mb5GOCwRYA7KP4QXIa2b7JLJztkLR/mj
	tgn9Y2D3jxQytepk75EeqcD6kybShgkQ0IosRjbhfv23z3meHLSKzKrrodyTwnaD
	J5bmpFFu7v+yV06yoS3+PwyJqZ8c5qmsX5dgpk3fBLJh1Vv1jNLF/zdE6cph9L8O
	x29cwkCZ5uw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D3955C78;
	Wed, 27 Apr 2011 01:19:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AED855C74; Wed, 27 Apr 2011
 01:19:09 -0400 (EDT)
In-Reply-To: <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com> (Jon
 Seymour's message of "Wed, 27 Apr 2011 15:10:49 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E32968E6-708D-11E0-8A29-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172172>

Jon Seymour <jon.seymour@gmail.com> writes:

>> So if you have /home/js/bin on your $PATH, you can install your "git-work"
>> script as /home/js/bin/git-work, and that should be sufficient.
>
> Yep, that's a start, but does not a a complete plugin architecture make :-)

Please explain yourself.
