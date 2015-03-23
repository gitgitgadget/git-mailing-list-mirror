From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Mon, 23 Mar 2015 12:56:43 -0700
Message-ID: <xmqq619ra3no.fsf@gitster.dls.corp.google.com>
References: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com>
	<CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
	<cbcb926c1b7edd31548a15ea4966a35@74d39fa044aa309eaea14b9f57fe79c>
	<20150226212721.GA2930@dcvr.yhbt.net>
	<xmqqa8z3a5rm.fsf@gitster.dls.corp.google.com>
	<20150323193634.GA3454@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	Nico =?utf-8?Q?Schl=C3=B6mer?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:56:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya8Sw-0001Fl-J6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbCWT4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 15:56:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752465AbbCWT4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 15:56:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09F0842F2E;
	Mon, 23 Mar 2015 15:56:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o5GHLto7Tl0hXAs+D7JOcKWDzAw=; b=f6O7qn
	dqkVT8hIX6gvXgMEfSI0joxodt9vzuMQVSovKeSA2GLDCBuMKyoGiPyi2CbrNC85
	Ym3e4VG7F8S1VGBpwIkEpcFsZwcm/diC86slfIOZDXYMRk3yen42XkaSWUmi9gOE
	YNJLaoQG6XQLihxNjmz1tKFXcgiimBj30QVps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bnFDlci3tSCOb0EO7sNLeAWSdsLUh+Kr
	Tc7P7U416/wE6eZh1EwlYw9jUHZWdFP0tGkIGCAkFyYFSp00jSAq3Bj5U59377cE
	STIIQOdeA86TywM3wF78DIfamVwhGWWNx55JOVAnGWWq9TbYY3ojNGr8VKoFFejL
	Z43mLLF4D4g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F1B42F2D;
	Mon, 23 Mar 2015 15:56:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62C7F42F2C;
	Mon, 23 Mar 2015 15:56:44 -0400 (EDT)
In-Reply-To: <20150323193634.GA3454@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 23 Mar 2015 19:36:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB41092E-D196-11E4-8A44-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266160>

Eric Wong <normalperson@yhbt.net> writes:

> Correct, it's a good time to pull and I don't expect to have more time
> to work on new features (lazy load) for a bit.  I was under the
> impression you already pulled:
>
> http://mid.gmane.org/xmqq61aol44q.fsf@gitster.dls.corp.google.com

Indeed I did.  I was fooled by my own rebase X-<.

Thanks, then I am fully up to date with you.
