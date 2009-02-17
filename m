From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Wed, 18 Feb 2009 00:29:26 +0100
Message-ID: <200902180029.29344.jnareb@gmail.com>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org> <m3wsbps708.fsf@localhost.localdomain> <7v1vtw6h84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:31:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZP9-0006uI-B6
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbZBQX3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbZBQX3j
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:29:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:61287 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbZBQX3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:29:37 -0500
Received: by fg-out-1718.google.com with SMTP id 16so581581fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 15:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EZt/m6CPggA12Ps2MKpTpxhknkUdZIcWwyy4B0RBfDw=;
        b=EHM5ySronpBe1ak8IFieflMZ6uMBl+G9G7Kd7lhO7PIF3TAv57xtUDd1RGUP4qzi0R
         EMp37U5fBiYp8ZvlnI39/5HyH+6UsTyfokNh9xUFMzzkVEuCkJtI3/T6+Y7D/1n1C55Z
         aP4jliVvw/iKnlS/xNuR1H5Pl1I1X00iELnG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OvI2Fuyjfy3BP1K/t1NQX0buXO0gSHPhWhK7L4RvEff2HI9POkh1O9sWzqiyF+xTM0
         lkEe4hV+9YhDUaurgkFhTjEW23cUljQRmjHqjWAxGsA25Pjm8POP+hBQwNuan90Uj1Es
         nbArf8KcgLQwSOTit6BPvfMQtyYH+Ja0+TpzI=
Received: by 10.86.51.10 with SMTP id y10mr2368276fgy.51.1234913375666;
        Tue, 17 Feb 2009 15:29:35 -0800 (PST)
Received: from ?192.168.1.13? (abvn202.neoplus.adsl.tpnet.pl [83.8.211.202])
        by mx.google.com with ESMTPS id 4sm471408fge.54.2009.02.17.15.29.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 15:29:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1vtw6h84.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110472>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes: 
>> Junio C Hamano <gitster@pobox.com> writes:

>>> [Stalled and may need help and prodding to go forward]
>>> 
>>> * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
>>>  + blame: show "previous" information in --porcelain/--incremental
>>>    format
>>>  + git-blame: refactor code to emit "porcelain format" output
>>>
>> It would be nice to have for gitweb... especially if it is a merge
>> commit that gets the blame (which I guess should happen only for 'evil
>> merge' case).
> 
> Will then move to "perhaps 'master' after 1.6.2" list, but the line number
> logic needs to be revisited, especially taking into account what was said
> in a recent discussion thread.

Well, even without 'line number logic', i.e. having line number for
version of given line _before_ current version (which might be not
solvable anyway, only approximated), having parents from git-blame,
without need to run at least 'git cat-file --batch', would be nice
enhancement.  If merge is blamed, then we can offer user more than
one parent to choose from to go to...
 
>>> * db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
>>>  - Support fetching from foreign VCSes
>>>  - Add specification of git-vcs helpers
>>>  - Add "vcs" config option in remotes
>>> 
>>> The "spec" did not seem quite well cooked yet, but in the longer term I
>>> think something like this to allow interoperating with other SCMs as if
>>> the other end is a native git repository is a very worthy goal.
>>
>> I wonder what are the limitations: I guess that importer has to be
>> incremental (and probably store additional info, or at least cache
>> it).  IIRC the example was for Perforce; much more interesting would
>> be to have example for Subversion, I guess.
> 
> We have a working git-svn.  As a demonstration, a one that works with git
> would be more interesting.

Hmmm... I wonder then how hard would be to reuse git-svn (which is not
fast-import importer) for foreign-scm feature...
 
>>> * cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
>>>  - builtin-replace: use "usage_msg_opt" to give better error messages
>>>  - parse-options: add new function "usage_msg_opt"
>>>  - builtin-replace: teach "git replace" to actually replace
>>>  - Add new "git replace" command
>>>  - environment: add global variable to disable replacement
>>>  - mktag: call "check_sha1_signature" with the replacement sha1
>>>  - replace_object: add a test case
>>>  - object: call "check_sha1_signature" with the replacement sha1
>>>  - sha1_file: add a "read_sha1_file_repl" function
>>>  - replace_object: add mechanism to replace objects found in
>>>    "refs/replace/"
>>>  - refs: add a "for_each_replace_ref" function
>>> 
>>> I think the code is much cleaner than the first round, but I am not
>>> convinced it is doing the right thing in the connectivity traverser.  
>>> Independent review sorely needed.
>>
>> This is certainly something that it would be nice to have.
> 
> "Nice to have" we probably all know (otherwise it would not have been
> queued).  Independent review is sorely needed.

Perhaps I would take a look, then... Not that I know anything about
this area of code ;-)

-- 
Jakub Narebski
Poland
