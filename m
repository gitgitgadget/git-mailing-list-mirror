From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 14:21:46 -0700
Message-ID: <7vobn4etxx.fsf@alter.siamese.dyndns.org>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com> <20120724182700.GI2939@burratino> <CAOeW2eHyLHGs3-Sd6X0b2Of1mFa1U8dCBU7L85_MJc4BY=BJmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= 
	<pclouds@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:21:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StmYE-0005OQ-Vl
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 23:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2GXVVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 17:21:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab2GXVVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 17:21:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370D479F1;
	Tue, 24 Jul 2012 17:21:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OwKgRJQqKsuejMEovUqfUz7Cics=; b=uDXFeS
	sCiy24Ez/6xpJmpAeWez+JYRgvP8ZzrKGqkCdB/bsKB+uYZnBPK7/JGk9iJtIOb8
	/aWE5EI3xY/c7h2Q1gqnr+91XLAfGblfe/RBjF14YvlFOf+rF3Ig5s76XKFpZh7u
	Q4LXJ63x8xOgdncwdsIv2LoJsTuVcmvBSvXy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KwpTRwLez/jvJiYnjc+Ys8shFjWol9+y
	vDnPWhQhozYckzmG20rmwhGFZl3dQj+J0rYrnhR181fnooGdFerTs+xHDUmZ8gPZ
	CCgnuJmUSq+aGAzgFLFY2WI1yymQmuvJ3K4peo/FKh4osQpCBJ5CdlfMpJeRK+S+
	QbPsaYfI2Yw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2472479F0;
	Tue, 24 Jul 2012 17:21:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98E4B79EF; Tue, 24 Jul 2012
 17:21:47 -0400 (EDT)
In-Reply-To: <CAOeW2eHyLHGs3-Sd6X0b2Of1mFa1U8dCBU7L85_MJc4BY=BJmA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Tue, 24 Jul 2012 14:16:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9376B3E0-D5D5-11E1-8372-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202072>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Tue, Jul 24, 2012 at 11:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> Jiang Xin wrote:
>>
>>> Gettext message should not start with '-' nor '--'. Since the '-d' and
>>> '--dotest' options do not exist in OPTIONS_SPEC variable, it's safe to
>>> remove the block.
>>
>> The above justification is not a sufficient reason to stop giving
>> helpful advice when someone uses an option that was historically
>> supported:
>
> I think Jiang is saying that "git am --dotest=..." already errors out
> because "dotest" is not in the OPTIONS_SPEC. See 98ef23b (git-am:
> minor cleanups, 2009-01-28). Or am I missing something?

No you are not missing anything, I would think.
