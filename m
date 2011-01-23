From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Sun, 23 Jan 2011 02:35:45 -0800 (PST)
Message-ID: <m38vybc3id.fsf@localhost.localdomain>
References: <4D3893EA.5090907@hartwork.org>
	<201101202127.39962.trast@student.ethz.ch> <4D389E69.608@hartwork.org>
	<7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 23 11:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgxIY-0004cq-8B
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 11:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab1AWKfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 05:35:48 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37658 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1AWKfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 05:35:47 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so3367127wwa.1
        for <git@vger.kernel.org>; Sun, 23 Jan 2011 02:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=BWa/6EGogZDlUCfIPEW2bvOwHtD5RWew9MSJEvfwW7k=;
        b=ruGk3r1O86zNBgjnVuSG/cjVhC5oYRx8eXmBsg7s5E5dPwCU6QI3mAVnhIgL2SpEfA
         vyiLgS3oNfTURgnRv3vMeo1u/vWjCe5GA5BcQ1zxjAXxGi5V+My5ye4cu+6sWQ2tWQti
         qW8G9B70/rhDGm6K15b8s7mDGHVAfw+5TmR2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=m14TnwjA4YzUjWTtWD8QeyFcTKwZK5sZ7jh7pFWuwedfCJsgHnRTcrQcyqLxT5OdIc
         cG09BhSz4mbZXhaLaDlMOJKNQkSgENfo3jZPwrjUVjYKQva1bexBd4ZkJinqgKgo9rzk
         /WLqdxlVecR4YtZDTHEVbiBv7CsiQwayGR7gQ=
Received: by 10.216.25.202 with SMTP id z52mr1227971wez.14.1295778946852;
        Sun, 23 Jan 2011 02:35:46 -0800 (PST)
Received: from localhost.localdomain (abuz16.neoplus.adsl.tpnet.pl [83.8.197.16])
        by mx.google.com with ESMTPS id n11sm5924481wej.19.2011.01.23.02.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Jan 2011 02:35:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0NAZ1FO007309;
	Sun, 23 Jan 2011 11:35:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0NAYYeP007304;
	Sun, 23 Jan 2011 11:34:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165423>

Junio C Hamano <gitster@pobox.com> writes:
> Sebastian Pipping <webmaster@hartwork.org> writes:
>> On 01/20/11 21:27, Thomas Rast wrote:
>>> Quote from the latter:
>>> 
>>>        This manual page describes only the most frequently used options.
>>
>> Okay.  Is that a good a idea?
> 
> Yes; the alternative is to list everything.
> 
>> Is --abbrev-commit really used more
>> frequently with "git show" than --color-words is?
> 
> I see this as a not-so-helpful-but-still-interesting question.
> 
> It depends on who you are, and if one wants to pick the most often used
> ones, that selection may or may not coincide with _your_ usage pattern nor
> mine.  The original author apparently thought so, you seem to think
> color-words is used a lot more often, and I personally think neither is
> used often at all.  So should we swap them, keep things as-is, or remove
> both?
> 
> We obviously cannot take a poll to update the list every time a new user
> starts using git, but it might make sense to review them every once in a
> while.

There is also additional problem, namely that because "git show" shows
commit and can show diff, therefore it accepts same formatting options
as "git log", and when set to display patch it accepts any diff family
options.

Should we then list most common porcelanish diff options, or just
refer to git-diff(1) manpage?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
