From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: remove redundant check for merge commit
Date: Sat, 28 Jul 2012 23:24:52 -0700
Message-ID: <7vpq7fw0cr.fsf@alter.siamese.dyndns.org>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vfw8czvj5.fsf@alter.siamese.dyndns.org>
 <CAOeW2eFROgZ+taqFvCHoSTVrQZnaQZo567e=73BcA+d5uSjKDA@mail.gmail.com>
 <7v7gtoxw80.fsf@alter.siamese.dyndns.org>
 <7vzk6kwf6l.fsf@alter.siamese.dyndns.org>
 <CAOeW2eG4mKTWm7PEGF_t0F9c_X1gkQaDw7HSrCiZaDte7PvOdQ@mail.gmail.com>
 <CAOeW2eELzcqnecZqea2K0vO818PTYf-P=xEoSKb5GcW7W0Nf+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 08:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvMw0-0001ph-TS
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 08:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab2G2GYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 02:24:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab2G2GYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 02:24:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F24F5F40;
	Sun, 29 Jul 2012 02:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L/9kqrbluhkj+iUepNPstlu7mvM=; b=eD8ddf
	sXWzXrGIcSFpjwSHz4/8O7cnjSmBojLvsb3i2zFpUw35SSIHv7m6wuouWzMTf3/x
	VjEclGP+OmTddfnQRzb+U4kd7xymfhq3BsSzP89c6Q19gCjKIYndb2EgZ1d6bf/X
	7B0WgAmpZxh9BP/QCES1vcc+VY8UwTi/F8CAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FYDm4m6ZY3Rz9Ojsf7s1z7j6kG/3I3wr
	1khtqFd/71BpG7igFRyMvWdubQ2s/X1Se7RHF59AFlKhqdOOyh/q5iGpb5/YxPUt
	b4Q/mtggNiJ8wDH4VkcPTPt5ML8a4AKVenhTOz4BtAKkOmDWH7oU6yub0tD14aGP
	XoU3tyQ8PrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29F6D5F3F;
	Sun, 29 Jul 2012 02:24:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AFE75F3E; Sun, 29 Jul 2012
 02:24:53 -0400 (EDT)
In-Reply-To: <CAOeW2eELzcqnecZqea2K0vO818PTYf-P=xEoSKb5GcW7W0Nf+A@mail.gmail.com> (Martin
 von Zweigbergk's message of "Sat, 28 Jul 2012 21:57:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BE00E98-D946-11E1-80E6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202471>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

>> I incorrectly assumed that ignore_merges was about revision
>> traversal, but now I think it's only diff output from 'git log' (and
>> possibly others).

Yeah, I realized the same after I wrote the response last night and
went to bed.  I am glad you figured all out yourself.
