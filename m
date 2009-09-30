From: Andreas Ericsson <ae@op5.se>
Subject: Re: Deciding between Git/Mercurial
Date: Wed, 30 Sep 2009 11:17:30 +0200
Message-ID: <4AC3222A.2040305@op5.se>
References: <h9nlhj$heq$1@ger.gmane.org> <m33a66br69.fsf@localhost.localdomain>	 <ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>	 <200909292058.53045.jnareb@gmail.com> <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Anteru <newsgroups@catchall.shelter13.net>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 30 11:18:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsvJz-0004PP-W3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 11:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbZI3JRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 05:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbZI3JRh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 05:17:37 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42043 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751405AbZI3JRh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 05:17:37 -0400
Received: from source ([209.85.219.209]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSsMiLrMM9soDIgXgkNaGQ2b4LC66FrKp@postini.com; Wed, 30 Sep 2009 02:17:41 PDT
Received: by mail-ew0-f209.google.com with SMTP id 5so181266ewy.12
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 02:17:34 -0700 (PDT)
Received: by 10.211.161.26 with SMTP id n26mr5824485ebo.74.1254302254241;
        Wed, 30 Sep 2009 02:17:34 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm2064116eyd.27.2009.09.30.02.17.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 02:17:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3 ThunderGit/0.1a
In-Reply-To: <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129336>

On 09/30/2009 02:49 AM, Leo Razoumov wrote:
> On 2009-09-29, Jakub Narebski<jnareb@gmail.com>  wrote:
>> On Tue, 29 Sep 2009, Leo Razoumov wrote:
>>   >  On 2009-09-28, Jakub Narebski<jnareb@gmail.com>  wrote:
>>   >  >  [..snip..]
>>   >  >   Besides with nonlinear history with
>>   >  >   revision numbers such as 12678 and 12687 you know that 12678 is older
>>   >  >   than 12687 if and only if 12678 and 12687 are on the same line of
>>   >  >   development.
>>   >
>>   >  The statement above is incorrect!! In a Mercurial repo local revision
>>   >  numbers are strictly ordered in commit time. 12678<  12687 means that
>>   >  12678 was committed prior to 12687. But these two commits could belong
>>   >  to two completely unrelated lines of development.
>>
>>
>> This is impossible with distributed development.  If the second branch
>>   comes from other repository, with commits _created_ (in that repository)
>>   earlier than commits in current repository, but commits in first
>>   branch (from current repository) were created earlier than _fetching_
>>   those commits in second branch:
>>
>>    .---.---.---.---x---1---2---3---M---.
>>                     \             /
>>                      \-A---B---C-/<-- from repository B
>>
>>
>>   Either you would have to change commits numbers, and therefore they would
>>   be not stable, or you would have to change commit time to mean 'time this
>>   commit got into current repository', which would kill performance for sure.
>>
>
> Jakub,
> in Mercurial sequential commit numbers are local to a repo and are not
> unique between the clones. Unique ID is SHA1 as in git. So mercurial
> commit 127:aaf123453dfgdfgddd...
> means commit number 127 in this repo with SHA1 "aaf123453dfgdfgddd..."
> In another clone commit 127 might mean completely different thing.
> Sequential commit numbers are strictly for "local convenience".
>

Personally I much prefer the "commit'ish-backward" notation of git,
where HEAD~4 means "the commit 4 commits back from HEAD".

You'd get awfully tired of writing the six-digit "shorthand" numbers
of large projects fairly quickly, I imagine.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
