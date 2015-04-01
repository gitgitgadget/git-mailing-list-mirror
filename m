From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid responses to 8bit encoding and In-Reply-To questions
Date: Wed, 01 Apr 2015 11:03:38 -0700
Message-ID: <xmqq8uebn2th.fsf@gitster.dls.corp.google.com>
References: <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com>
	<xmqqa90to78v.fsf@gitster.dls.corp.google.com>
	<loom.20150401T125113-830@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Guilhem Bichot <guilhem.bichot@oracle.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 20:03:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdMzR-0006jy-OH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 20:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbbDASDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 14:03:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751271AbbDASDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 14:03:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04E2942BF7;
	Wed,  1 Apr 2015 14:03:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZK1eh7SC5JFshzlOlLzzCnLIEc=; b=uQDtyY
	qnZ2Acda3ElGTN4jGAm9GsPnlhCvYUY9PKK5uNVDRj/WPcWQMuB/mpF+7ATl+ik1
	wvMfSyaYUdh/I87YP5YL9opdLa0JQkQPecn2ddTHyb5qyk4gM/LwwVUpfyrYOx9l
	sHJpnCkvbcdlGna9JJu7jsx8QJ+ITW+si3jrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXsVXq4JL+tmRkhbc6XRSx3fz5rK312A
	AbTN8d7GElRA3ot3VchikKNyknKYwbu8pczHZFv8swSWbwyW0EPAiE2HXWmmff36
	zHmGsKaY8QjKVYUmtbMLtsPN87ghDiPWCgFPdLhEGO+JZiRqJS+XrFAhrS03CotO
	3RdhqZh7rV4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F276B42BF6;
	Wed,  1 Apr 2015 14:03:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5348742BF5;
	Wed,  1 Apr 2015 14:03:39 -0400 (EDT)
In-Reply-To: <loom.20150401T125113-830@post.gmane.org> (Guilhem Bichot's
	message of "Wed, 1 Apr 2015 10:53:11 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CB77068-D899-11E4-BFBE-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266616>

Guilhem Bichot <guilhem.bichot@oracle.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> It would be possible to do so with code changes to git-send-email;
>> look for "ask(", "valid_re", and "confirm_only" to see how they are
>> used in existing code that ask questions, if you are interested.
>
> Today I stumbled on exactly this; a colleague had probably typed "yes" when
> inappropriate, and the email I received from git-send-email had:
>
> Content-Type: text/plain; charset=yes

Then upcoming release Git 2.4.0 will delight you ;-)
