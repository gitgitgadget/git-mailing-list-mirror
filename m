From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] git-p4: fix AsciiDoc formatting
Date: Sun, 13 Mar 2016 20:51:00 -0700
Message-ID: <xmqq1t7dafa3.fsf@gitster.mtv.corp.google.com>
References: <1456830320-40411-1-git-send-email-larsxschneider@gmail.com>
	<F0F4FA8A-EB42-4990-A90E-6C9245E0A9DE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 04:51:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afJXM-0008Fx-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 04:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbcCNDvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 23:51:07 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754620AbcCNDvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 23:51:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D83F4BCD9;
	Sun, 13 Mar 2016 23:51:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X4PLNFo9ZrJH5i1OPX9saBCCD2M=; b=izHxZL
	AMemZjUgJoYiL+l7ZriCB+G4dwakXAIJKz3+vCXb56qfgo8+6TzhN68zYXZtQGQ5
	OHDecHp8QbUDUiacbPhkGaMmSJHmBaFCJGDKIgsDls32ffCUTlti1jaTgUmxu7Fb
	CElMhotrJQ1xXiKMI5CPmWGxQrVrefgbdp7YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mtnDW/WZv3jkssgAne7i6FSA76HJXGFY
	1qNNrEGscnzigxL82Trv+RL6gA2Oe2kLNoO36SbYQdkdOtiGdxsG3+8gfoXJEs12
	0dfQKEFgGod64YdIJCC2M7WZw7uLLm2Tna24unmHn+53DXntbMlMvgp/3xFJFp+K
	pBPfY825J28=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6626C4BCD8;
	Sun, 13 Mar 2016 23:51:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E348F4BCCE;
	Sun, 13 Mar 2016 23:51:01 -0400 (EDT)
In-Reply-To: <F0F4FA8A-EB42-4990-A90E-6C9245E0A9DE@gmail.com> (Lars
	Schneider's message of "Sun, 13 Mar 2016 18:46:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8473E3C-E997-11E5-A237-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288765>

Lars Schneider <larsxschneider@gmail.com> writes:

>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 738cfde..140fc12 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -528,7 +528,7 @@ git-p4.largeFileSystem::
>> git config       git-p4.largeFileSystem GitLFS
>> -------------
>> +
>> -	[1] https://git-lfs.github.com/
>> +[1] https://git-lfs.github.com/
>> 
>> git-p4.largeFileExtensions::
>> 	All files matching a file extension in the list will be processed
>> --
>> 2.5.1
>> 
>
> Is there any chance to get this in? The formatting error is quite obvious here:
> https://git-scm.com/docs/git-p4
>
> (while looking at this website I also noticed wrong double quotes around cp1252
> which I will fix with a subsequent patch)

I ignored this when I saw it first, primarily because I assumed that
anything related to git-p4 would get a review by somebody better
versed with git-p4 before I get to it; I forgot about the patch
after it was buried in the other messages without anything
happening.

Will take a look.

Thanks.
