From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Textconv
Date: Mon, 11 Mar 2013 15:40:20 +0100
Message-ID: <513DECD4.8080002@drmicha.warpmail.net>
References: <513DA7E1.7050206@mylovecompany.com> <vpqtxoicl2l.fsf@grenoble-inp.fr> <513DB273.2090007@mylovecompany.com> <vpqd2v6b4n5.fsf@grenoble-inp.fr> <513DC04D.9090904@mylovecompany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Dmitry Ilin <dmitry@mylovecompany.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 15:40:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF3u8-0007NF-W0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 15:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab3CKOkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 10:40:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55847 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab3CKOkS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 10:40:18 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 43A6220A6D;
	Mon, 11 Mar 2013 10:40:17 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 11 Mar 2013 10:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ll9GZFYBNFQ0LeGczrS+UM
	hSqCs=; b=qvThkaZO9Bo/pQxumKsExAu0DJKUcN9EHsLwKE6Z2IkysxPvYxTg0X
	JD01U1ZJ6boEjRHdR/5EycrKEKHjsTxHbZlmQ7n5u7EchyYYoKj/fNfHBIFtN7C8
	U5lYt5qE/XjmnVht7tPbyeTUgeCfbZmznWPhJWdtNqkoclw/Ydaa4=
X-Sasl-enc: hBjMz1iRE0bs3H6UhaKie+aXNelN92BeeUquKH+n6Llu 1363012816
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 971A7C80E8C;
	Mon, 11 Mar 2013 10:40:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <513DC04D.9090904@mylovecompany.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217877>

Dmitry Ilin venit, vidit, dixit 11.03.2013 12:30:
> I tried this command and I got following result:
> 
> trace: built-in: git 'show' 'a1bffde'
> trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' 2> /dev/null || cat'
> trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' 2> /dev/null || cat' 'openssl enc -d -base64 -aes-256-ecb 
> -k '\''abcde'\'' 2> /dev/null || cat'
> trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' -in $1 2> /dev/null || cat $1' '/tmp/CLPGPk_config.js'
> trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' -in $1 2> /dev/null || cat $1 "$@"' 'openssl enc -d 
> -base64 -aes-256-ecb -k '\''abcde'\'' -in $1 2> /dev/null || cat $1' 
> '/tmp/CLPGPk_config.js'
> trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' 2> /dev/null || cat'
> trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' 2> /dev/null || cat' 'openssl enc -d -base64 -aes-256-ecb 
> -k '\''abcde'\'' 2> /dev/null || cat'
> trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' -in $1 2> /dev/null || cat $1' '/tmp/Uyc2Dj_config.js'
> trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
> '\''abcde'\'' -in $1 2> /dev/null || cat $1 "$@"' 'openssl enc -d 
> -base64 -aes-256-ecb -k '\''abcde'\'' -in $1 2> /dev/null || cat $1' 
> '/tmp/Uyc2Dj_config.js'
> diff --git a/path/config.js b/path/config.js
> index c4ad2d4..a67d13f 100644
> --- a/path/config.js
> +++ b/path/config.js
> 
> 
> And also not encrypted data of my commit.
> 
> 
> On 03/11/2013 02:41 PM, Matthieu Moy wrote:
>> Dmitry Ilin <dmitry@mylovecompany.com> writes:
>>
>>> I mean that our filter doesn't work with 'git show' and I need to
>>> enable it for this command.
>>>
>>> This is part of my git config file:
>>>
>>> [filter "openssl"]
>>>     smudge = openssl enc -d -base64 -aes-256-ecb -k 'abcde' 2>
>>> /dev/null || cat
>>>     clean = openssl enc -base64 -aes-256-ecb -S '12345' -k 'abcde'
>>> [diff "openssl"]
>>>     textconv = openssl enc -d -base64 -aes-256-ecb -k 'abcde' -in "$1"
>>> 2> /dev/null || cat "$1"
>>> [merge]
>>>     renormalize = true
>> Maybe a bad interaction between the [filter ...] section and the
>> [textconv ...] one. Can you run:
>>
>> GIT_TRACE=true git show <some-relevant-commit>
>>
>> to see what's going on?
>>
> 

"git show commit" uses textconv by default for the patch, but "git show
blob" does not. There's a series on the list which deals with textconv
for "grep" and "show blob", but I haven't had the time to polish it up.
I don't think it's cooking in pu yet, but I've been running with it
since. "running git with it", that is, not "running away with it" ;)

Michael
