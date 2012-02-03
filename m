From: Junio C Hamano <gitster@pobox.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 02 Feb 2012 22:11:27 -0800
Message-ID: <7vmx90say8.fsf@alter.siamese.dyndns.org>
References: <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org>
 <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org>
 <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
 <20120202023857.GA11745@sigill.intra.peff.net>
 <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
 <20120202095432.GA19356@sigill.intra.peff.net>
 <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
 <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 07:12:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtCNL-0004IL-JB
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 07:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2BCGLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 01:11:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474Ab2BCGL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 01:11:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 592B27917;
	Fri,  3 Feb 2012 01:11:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5HblV2qM+VjidnaTmSkBTdcVORA=; b=the5T2
	S8t1IAT0LwATXtfrKPXfNQ98O4SRUn/GZnvdGvIrN1ZZMd5WzFIdkrRPlMK/88jm
	rzmRIURoZHdCw1WM8MPFMguU1OV96CP/nWWXg4fRDxDDwcyKeZyH72TWL/BArX69
	96tgEF7UpK8IMPFeBpp+6PkwDzdsedJ14DbNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a179WShgUYCcjIT6eA0oByR9UscYceTz
	AM0Q12jHDOFaMCKXdRw3K8HwTcLT+kuLbfxDHObZ0siSw1JegKL4TVafPhi0RtBn
	0PFdmR8qwGewrAJ4AIo3jd7bIwCwZ3eColFVW+pAeX580d+/DuGAZW4YmpWMX0iw
	KoFFmtECvPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E2FB7916;
	Fri,  3 Feb 2012 01:11:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3C987915; Fri,  3 Feb 2012
 01:11:28 -0500 (EST)
In-Reply-To: <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com> (Kyle
 Moffett's message of "Thu, 2 Feb 2012 21:08:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E915267C-4E2D-11E1-BDC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189740>

Kyle Moffett <kyle@moffetthome.net> writes:

> Alternatively, you could extend the recent proposal for GIT config
> "include" statements so that something like this works:
>
> [include]
>     exec = echo "deploy.prefix = `cat /etc/SERVER_ROLE`"
>     exec = /usr/local/bin/git-config-for-ldap-user

Erh...

Running known stuff from your own .git/config may be justifiable as "at
your own risk", but if we consider sources that are not under your direct
control, such as /etc/gitconfig and whatever your project encourages you
to include from your .git/config,... eek.
