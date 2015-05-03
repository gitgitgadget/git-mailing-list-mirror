From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Sun, 03 May 2015 16:59:06 -0700
Message-ID: <xmqq4mntusad.fsf@gitster.dls.corp.google.com>
References: <1430536341-21847-1-git-send-email-alexhenrie24@gmail.com>
	<xmqq383dwpf4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, artagnon@gmail.com, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 01:59:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp3n0-00061Y-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 01:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbbECX7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 19:59:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbbECX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 19:59:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D42274EECF;
	Sun,  3 May 2015 19:59:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YYfj8kYRek+BpEezX8nR4kFrRLA=; b=RuqLgz
	DODBWn/7gmPnohhrqVh61NRazscozg2Ko2QTalRDpszPP7KnGnQXrBC3m6tQ3dQ0
	Nad4oASAX/cnasngqTHSZ6jNRQ1ZrAeJNItF5iy68xN4OhxwAn+s1QMW3yfs/Wnq
	/UYzqug/hYnS904sJEadcyC7vzITfiXtnyEfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F02TBscPi2rVBKMDvpZ02LZWbqQPTrb3
	RvnCUokj+gvXGNEbZP4S/R9XIxHgy1NESkLyLzc3ufONWOMtSFKmYBxlGlsyv9sQ
	VW7FlsZX2cPIHwlEJFf0t6uf8TeQrzmXb83npGUK0eZk0l6nQ5/tEQtKLjbMHWWb
	yxbaV9h4usA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB9B24EECE;
	Sun,  3 May 2015 19:59:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 489064EECD;
	Sun,  3 May 2015 19:59:07 -0400 (EDT)
In-Reply-To: <xmqq383dwpf4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 03 May 2015 10:18:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6263C042-F1F0-11E4-9B2C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268300>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> This is a follow-up to commit 9c9b4f2f8b7f27f3984e80d053106d5d41cbb03b.
>
> Please do not force the reader to type "git show 9c9b4f2".

Here is my attempt.

commit ce41720cad79d858f09ebfc88cf84a4b152645c7
Author: Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu Apr 2 15:26:56 2015 -0600

    blame, log: format usage strings similarly to those in documentation
    
    Earlier, 9c9b4f2f (standardize usage info string format, 2015-01-13)
    tried to make usage-string in line with the documentation by
    
        - Placing angle brackets around fill-in-the-blank parameters
        - Putting dashes in multiword parameter names
        - Adding spaces to [-f|--foobar] to make [-f | --foobar]
        - Replacing <foobar>* with [<foobar>...]
    
    but it missed a few places.
    
    Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
