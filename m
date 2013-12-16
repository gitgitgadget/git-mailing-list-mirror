From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Mon, 16 Dec 2013 22:59:23 +0000
Message-ID: <52AF85CB.90107@ramsay1.demon.co.uk>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com> <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-3-git-send-email-pclouds@gmail.com> <52ACBE2B.3040909@ramsay1.demon.co.uk> <CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com> <52AE1B5E.6020506@ramsay1.demon.co.uk> <CACsJy8AJT5XXyJvVi_6Gjrn=AqA1M9KWY_62p=d3CPjg7nXFWw@mail.gmail.com> <20131216171147.GA28604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 23:59:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsh8O-0003E7-C9
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 23:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab3LPW72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 17:59:28 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:57203 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750839Ab3LPW71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 17:59:27 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id B63A0AC4075;
	Mon, 16 Dec 2013 22:59:25 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 8574CAC4071;
	Mon, 16 Dec 2013 22:59:25 +0000 (GMT)
Received: from [192.168.254.19] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Mon, 16 Dec 2013 22:59:25 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131216171147.GA28604@google.com>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239371>

On 16/12/13 17:11, Jonathan Nieder wrote:
> Duy Nguyen wrote:
>>>> Ramsay Jones wrote:
> 
>>>>> :-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c: Remove the
>>>>> 'git_' prefix from a file scope function", 04-09-2012), because ... well it's a
>>>>> file scope function! (i.e. the git_ prefix implies greater than file scope).
>>>>> I'm not very good at naming things, so ...
> [...]
>> OK I go with this. I think it makes sense
>>
>> vsnpath -> do_git_path
> 
> I think this renaming would be still losing clarity --- it loses the
> information that this is the vsnprintf-like variant of git_path.
> 
> Do we actually have a convention that functions with git_ prefix
> should be global?

Hmm, probably not no. However, any symbol that starts with git_ positively
screams global symbol to me. Maybe, I just need to close my ears. ;-)

I didn't intend to provoke so much discussion. I was simply pointing out
that this symbol had already been renamed, in the exact opposite direction,
once before. Please just ignore me.

ATB,
Ramsay Jones
