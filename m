From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 15:18:00 -0700
Message-ID: <14CC7E43-3588-4B36-A8E9-79C22D548D8D@gmail.com>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79> <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79> <7vehaqcw66.fsf@alter.siamese.dyndns.org> <DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com> <7v1u6qclfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:18:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1OQj-0005dv-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab3GVWSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:18:06 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33928 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3GVWSF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:18:05 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so7622825pbc.9
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=N9FhXvdNl94arf1p56kUygiOy2VifDl3wUye3D/Xe9U=;
        b=MywyEv49r8ugIuBgrhIA7IbSCbQAMcz/GTI5FefIzMonYfB2pVzbHe9Gn/n/izDNFP
         VhGP1uvLHDG45aY+95Mv+VW/UAier4yoKH5TGW+MjqOHa1yHJjP3j3cXkFOvCNMx94ob
         5y1v6EzSGImEpAyt7X2MtBasUQgg96P7BLn/HYTo9rZA5WdQvtvK6UZf1JdQmvjpPdI+
         /oEMvdmaUxtR8URLjoBQ/ViQl0qS8shr38UK+pZ7hoD/TIlUS2DBBTZ48pyWUrrzrS6G
         7HA1Fi6iRv0dTgctgHQ3CwucSJkQoj+fGO6iCLczG/GG7wdvQ8WQUDbefw5ngXZgK3Zz
         CofQ==
X-Received: by 10.68.6.97 with SMTP id z1mr32752603pbz.3.1374531483995;
        Mon, 22 Jul 2013 15:18:03 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kq2sm41283661pab.19.2013.07.22.15.18.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 15:18:03 -0700 (PDT)
In-Reply-To: <7v1u6qclfx.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230999>


On Jul 22, 2013, at 14:51, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>>> A solid wall of text is somewhat hard to read, so I'd queue the
>>> equivalent of the following "git diff -w" output on top.
>>
>> Can I send out the change as a 'fixup!' patch?  Or do I need to  
>> send a
>> new v9 patch series with the documentation update?
>
> If you are OK with splitting it into two paragraphs with the
> "longest" clarification tweak (the "patch" I showed you), just
> saying so and I can squash ;-) so there is no need to resend.

The wording of:

"+	password part, if present in the url, is always ignored).  A <url>
+	with longer path matches take precedence over shorter matches no  
matter
+	what order they occur in the configuration file.

needs to be fixed first.  Replace "take" with "takes" and you can go  
ahead and squash it in.  :)


>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index c418adf..635ed5d 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -1521,9 +1521,11 @@ http.<url>.*::
>>> 	path portion is an exact match or a prefix that matches at a "/"
>>> 	boundary.  If <url> does not include a user name, it will match a  
>>> url
>>> 	with any username otherwise the user name must match as well (the
>>> -	password part, if present in the url, is always ignored).
>>> Longer <url>
>>> -	path matches take precedence over shorter matches no matter
>>> what order
>>> -	they occur in.  For example, if both
>>> "https://user@example.com/
>>> path" and
>>> +	password part, if present in the url, is always ignored).  A <url>
>>> +	with longer path matches take precedence over shorter matches
>>> no matter
>>> +	what order they occur in the configuration file.
>>> ++
>>> +For example, if both "https://user@example.com/path" and
>>> "https://example.com/path/name" are used as a config <url> value and
>>> then "https://user@example.com/path/name/here" is passed to a git
>>> command, the settings in the "https://example.com/path/name" section
>>
>> OK.
>
> ... which essentially is your "OK" ;-)

Yes, I meant that as "OK I will send out an update that includes  
something like this."

After replacing "take" with "takes" in the change I'm good with just  
squashing that diff in.
