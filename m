From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Mon, 23 Mar 2015 12:11:09 -0700
Message-ID: <xmqqa8z3a5rm.fsf@gitster.dls.corp.google.com>
References: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com>
	<CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
	<cbcb926c1b7edd31548a15ea4966a35@74d39fa044aa309eaea14b9f57fe79c>
	<20150226212721.GA2930@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	Nico =?utf-8?Q?Schl=C3=B6mer?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:11:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya7kx-000286-27
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 20:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbbCWTLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 15:11:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752929AbbCWTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 15:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8BA842095;
	Mon, 23 Mar 2015 15:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3MkxwyTDe29LMhCmP5dvsvDQ838=; b=tLWgof
	nya5iWvGcdZJLYy0KeUPTe1rp/GKhcaGiX/yB/KzZXGrzLGs5bjHz4oI7dWYr/oT
	YGjxzMdrol3n4+XQr0F7juL9pcqqjEursNEUVOElahidOMeeOm0/E/DmFjVuyDXx
	tC4VVqbLGiWFTzVMJ5J6mcmh5Tb2mZt4rXVPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vh7ou8HarJ9ctX1P3807U8bZ5/lAQmUH
	EhOLpqvgGRRKuZKUcbb8WfHFjBNBW2BIN2m8rxcKWSkbjbMXMIZnB17iRwLvbclv
	6qk3q3xTlY5UPC7QFmzibWbnamb7udHhWFdy3SKL8w+PlHsGWFF1yGpOsa0EXHZq
	Cbf39Rq53wQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B05F942094;
	Mon, 23 Mar 2015 15:11:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2092042093;
	Mon, 23 Mar 2015 15:11:11 -0400 (EDT)
In-Reply-To: <20150226212721.GA2930@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 26 Feb 2015 21:27:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E1A757E-D190-11E4-93D3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266158>

Eric Wong <normalperson@yhbt.net> writes:

> "Kyle J. McKay" <mackyle@gmail.com> wrote:
>> The updated patch with the additional fix is below.
>
> Thanks, signed-off and pushed to master on git://bogomips.org/git-svn
> I've dropped my "destroy all tempfiles..." patch.

I think I missed this exchange.  I see these two patches:

    e0b4cad Git::SVN::*: avoid premature FileHandle closure
    ce1b57b git-svn: fix localtime=true on non-glibc environments

on the 'master' branch of your git://git.bogomips.org/git-svn.git/
repository.  Is this a good time to pull from you, and should I
expect more during this cycle (I am guessing that the answers would
be yes and no, but just to make sure...)?

Thanks.
