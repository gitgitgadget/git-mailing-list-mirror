From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Sat, 19 Dec 2009 03:49:44 -0800
Message-ID: <4B2CBDD8.9000508@gmail.com>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org> <1261172078-9174-1-git-send-email-bebarino@gmail.com> <loom.20091218T223918-175@post.gmane.org> <1261173577.14059.5.camel@swboyd-laptop> <loom.20091218T234129-280@post.gmane.org> <4B2C395A.6080300@gmail.com> <4B2C66D3.1070508@byu.net> <4B2C70ED.1020602@gmail.com> <4B2C7B9C.1030404@gmail.com> <7vk4wjfm4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <ebb9@byu.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 12:49:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLxoq-0006zV-Fi
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 12:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbZLSLts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 06:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbZLSLtr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 06:49:47 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:36278 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZLSLtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 06:49:47 -0500
Received: by pzk1 with SMTP id 1so2790582pzk.33
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nxFuxCyQdmkuJXzVyj8pMkTvG8vSNT6sOd3QSZ+n7b4=;
        b=C9Fg1irUkBCXwUvVZbUbXlMu7osna8+mJv4BLtqahOjSHo7m3uXNgLiIZmq371CtQx
         Ckr8oad1rGAy7IdrxKzREmKQyvUDwcDQ3SZOJTNvHmlLWctlFhA6jNjlcBorKglr701c
         Z5nmZNPE7uJcVYwz/kW7m+S6JboeUu2tSFWbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YfkCtfvqxDERGaPx3ZwM+P18IfEltl3diI+K0l4wWie4Av5BLStzNZm09qSzdfN//d
         G+Mv1l+8nM3xjNg0Oa6Lf0NosHiU6XgB8jfdJJTfLz0aoixiMeR6FsO9kyPLz0Wc/NSQ
         nBsQzjc4wKo/1jOZkD17PlGwBgxWrOE3FRWc4=
Received: by 10.142.4.29 with SMTP id 29mr3274907wfd.127.1261223386346;
        Sat, 19 Dec 2009 03:49:46 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm3232412pzk.8.2009.12.19.03.49.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Dec 2009 03:49:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vk4wjfm4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135475>

On 12/18/2009 11:39 PM, Junio C Hamano wrote:
> Stephen Boyd<bebarino@gmail.com>  writes:
>    
>> I found this in t0022
>>
>> sed -e "s/\$/
>> ^M/" "$TEST_DIRECTORY"/t0022-crlf-rename.sh>elpmas&&
>>
>> so I'd like to use that if possible.
>>      
> That needs fixing; I think we caught something similar from Shawn before
> it got in, primarily because the mail path corrupted the message and
> turned the literal CR into LF

Sorry it looks like my mailer turned the CR into a LF. That should all 
be one line.

Are you saying that t0022 needs fixing?
