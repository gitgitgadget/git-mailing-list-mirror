From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Sun, 21 Feb 2010 21:43:28 -0500
Message-ID: <4B81EF50.4000409@gmail.com>
References: <4B7D8358.1080108@gmail.com> <94a0d4531002200558r70087153i5c43ab669458e817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 04:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjOGq-0005Np-NC
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 03:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab0BVCnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 21:43:35 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:12221 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0BVCne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 21:43:34 -0500
Received: by qw-out-2122.google.com with SMTP id 8so389926qwh.37
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 18:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BoM2RC4o+c63fxWgusXMOKw2Itj8OjBN6bCJdb0ntFg=;
        b=RUO3z44Ug48FheyaFvEcLrFgPMw3bjxk5U7po2+QnVux7/t3lwL3XPkNMeDXsX254o
         p8+YpRuy0FQ4TPQgwwSiltQQ9XhN4Kkde1ZCVsy/XH3ysbROXgSZF993FSE6pyTl4tvz
         5G+QBsewGQpubJHzmrEzy3GDcq5nmwDEI+shg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bWz7AKyrVf9P9XOCgHV7oBiUy3ZDVwiTiN/Wt9QveVvKK/Oc8b7Qj3fK5JlT5VMdpX
         p4OTOPafFxvvx+SvhjnB0L1rQZcsS3Qose8L7GeMwSvanwi5OuJMmk35q6UVVJbAP01h
         Z0jMBsDoe4tl1RApcfCZ+BxaGiI4As2CA5vRg=
Received: by 10.229.220.4 with SMTP id hw4mr1431718qcb.25.1266806613938;
        Sun, 21 Feb 2010 18:43:33 -0800 (PST)
Received: from ?192.168.2.202? (dsl-152-38.aei.ca [66.36.152.38])
        by mx.google.com with ESMTPS id 21sm2221556qyk.8.2010.02.21.18.43.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 18:43:32 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <94a0d4531002200558r70087153i5c43ab669458e817@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140550>

On 2010-02-20 08:58, Felipe Contreras wrote:
> On Thu, Feb 18, 2010 at 8:13 PM, Gabriel Filion <lelutin@gmail.com> wrote:
>> Hello,
>>
>> I started collaborating on a script on github that tries to bring
>> bidirectional integration of git with Bazaar repositories. It is the
>> script originally written in ruby by Pieter de Bie and converted to a
>> shell script. You can find it here:
>>
>> http://github.com/kfish/git-bzr
>>
>> There is probably much left to be done to call this script functional.
>> Currently, it is possible to fetch revisions in a local branch, but I've
>> had problems with pushing revisions.
>>
>> So, first things first: in order to make this thing see some substantial
>> progress, I will surely need help from people who are well acquainted
>> with git's internal plumbing, people from git-svn for their valuable
>> experience with extraneous vcs integration and also with people
>> acquainted with bzr's inner workings.
>>
>> Is there any interest from people of this mailing list to see this
>> script make it to a usable state?
>> If so, having some code review would be more than good. What do you
>> recommend on doing: using this mailing list or putting one up that would
>> be specific to the project?
> 
> I'm interested in a tool that's fast (uses git fast-import). Is that planned?
> 
I would like to have as much, but in the context of Bazaar interaction,
I'm afraid the performance bottleneck will be actually invoking bzr (for
now, supposing this is the only way to do things). I'll start work on a
bzr remote helper shortly and will post a url to my github repos. If you
want to help in developing the remote helper and later optimizing its
performance, I'll be more than happy about it.

-- 
Gabriel Filion
