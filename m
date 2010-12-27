From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commiting automatically (2)
Date: Mon, 27 Dec 2010 13:04:02 +0100
Message-ID: <201012271304.03915.jnareb@gmail.com>
References: <loom.20101219T090500-396@post.gmane.org> <m34oa7l1hq.fsf@localhost.localdomain> <4D1190A6.4070201@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Dec 27 13:04:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXBob-0008Ai-VB
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 13:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0L0MEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 07:04:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45294 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab0L0MEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 07:04:23 -0500
Received: by fxm20 with SMTP id 20so9063117fxm.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1rma+9PZecJRPMLU+pDAOnYUuCDg0BzjnP8TjaC+Er0=;
        b=mpfGP4zGBGbkq4oAQFwu6KymCjMXMfMmlIRyYMuHToXrfSYg7I6D25Mg5yKdHp1W0N
         g8OUEfCwZwylGEJi+HRqCcxtbi7N/ARjd8FA3A/xG2fbofNWhSm1X+CiHhBvKkV+73S7
         GZn3WLhss7On9EdtQA8zhQ2i71+BsU9q8csZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d+lN4Zhd3UzNALGM6grsXvVRuyWh8vfHntJZVo5UMsXA/AbPYFr8ViNzZV1WHs+cBS
         q3O02bRZB4l+CaIA9jqXA22oWnmVAAxBGITQBdWq7sA3fM/ZKCXjRBETKfKCDh3ylLxT
         1d47z0QZkIDp0pIdazJJmAAUpANCFdKwl9Ih8=
Received: by 10.223.103.12 with SMTP id i12mr885014fao.43.1293451462599;
        Mon, 27 Dec 2010 04:04:22 -0800 (PST)
Received: from [192.168.1.13] (abwm110.neoplus.adsl.tpnet.pl [83.8.236.110])
        by mx.google.com with ESMTPS id a25sm2973366fak.20.2010.12.27.04.04.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Dec 2010 04:04:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D1190A6.4070201@seznam.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164220>

On Wed, 22 Dec 2010, Maaartin-1 wrote:
> On 10-12-21 14:06, Jakub Narebski wrote:
>>
>> Please try to not cull Cc list (use 'reply via email', if possible)
> 
> I don't know what "cull" means and
> http://dictionary.reference.com/browse/cull
> doesn't help me at all. Could you explain?

http://en.wiktionary.org/wiki/cull

  to cull
  [...]
  3. To select animals from a group and then kill them in order to
     reduce the numbers of the group in a controlled manner.

In the context ("to cull Cc list") it means removing entries from Cc
list (courtesy copy, copy-to), i.e. not replying to all people
participating in given (sub)thread.

>> Maaartin <grajcar1@seznam.cz> writes:
>> 
>>> I let the snapshot point to the current head, which is where I get a problem now:
>>>
>>>   git show-ref HEAD
>>>
>>> returns nothing,
>>>
>>>   git show-ref --head
>>>
>>> returns HEAD and all branches and tags. Isn't it a bug? How can I get the HEAD 
>>> reference? I'm using git version 1.7.2.3 on cygwin.
[...]
>> As for `git show-ref HEAD` - git-show-ref uses its own way of pattern
>> matching; in new enough version of git-show-ref manpage you can read
>> that:
>> 
>>   <pattern>...::
>> 
>>         Show references matching one or more patterns. Patterns are matched from
>>         the end of the full name, and only complete parts are matched, e.g.
>>         'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
>>         'refs/tags/jedi/master' but not 'refs/heads/mymaster' nor
>>         'refs/remotes/master/jedi'.
>> 
>> So `git show-ref HEAD` would match 'refs/.../HEAD`, e.g. `refs/remotes/origin/HEAD`,
>> but not `HEAD` which is outside `refs/`.
> 
> IMHO, it's quite broken. Alone it would be fine, but should really
> git-show-ref behave that different from git-symbolic-ref?

git-symbolic-ref is about querying and manipulating _single_ symbolic
reference, using fully qualified branch names (ref names).

git-show-ref is about querying multiple refs; I think the design goal
behind its strange pattern matching semantic is to make it easy to get
all refs with the same short name.

> Moreover, git-show-ref --head shows all branches and tags, this can't be
> right, can it? According to your above explanation, getting HEAD using a
> pattern is impossible, so I'd say that's what is "--head" good for.
> 
> Moreover, "git-show-ref --heads" shows less than "git-show-ref --head",
> despite the plural.

"git show-ref --head" is strange in that it doesn't play well
with '--heads' and '--tags' and '<pattern>'.

I think it is a bit of misdesign, but I don't know how it should be
fixed; current output of "git show-ref --head" has to be kept because
of backward compatibility - git-show-ref is plumbing.

>> I tripped over strange git-show-ref <pattern> semantic too.
>> 
>> P.S. there is also git-for-each-ref.

I don't know why there is git-show-ref when we have git-for-each-ref
for scripting; I guess they were added nearly at the same time...

-- 
Jakub Narebski
Poland
