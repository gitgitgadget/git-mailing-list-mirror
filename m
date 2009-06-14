From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Sun, 14 Jun 2009 19:33:58 +0200
Message-ID: <4A353486.2060900@op5.se>
References: <20090329171347.GA26866@beczulka> <37fcd2780903291252i19bba8ccx9dfb73e763d95b15@mail.gmail.com> <237967ef0904030357u15ef77f2rb3299b6f6c651404@mail.gmail.com> <20090606105501.GA29758@beczulka> <20090614155205.GC11730@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Sun Jun 14 19:40:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFth7-000658-Od
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 19:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbZFNReE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 13:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZFNReC
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 13:34:02 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45956 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752975AbZFNReB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 13:34:01 -0400
Received: from source ([74.125.78.25]) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSjU0ibdnejKSPPyCKMTHIdJ6+bJh9fgy@postini.com; Sun, 14 Jun 2009 10:34:04 PDT
Received: by ey-out-2122.google.com with SMTP id d26so21856eyd.63
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 10:34:01 -0700 (PDT)
Received: by 10.210.91.17 with SMTP id o17mr2187047ebb.74.1245000840859;
        Sun, 14 Jun 2009 10:34:00 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 28sm625651eyg.24.2009.06.14.10.33.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 10:33:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090614155205.GC11730@beczulka>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121553>

Marcin Owsiany wrote:
> On Sat, Jun 06, 2009 at 11:55:01AM +0100, Marcin Owsiany wrote:
>> This discussion seems to have stalled...
>>
>> On Fri, Apr 03, 2009 at 12:57:52PM +0200, Mikael Magnusson wrote:
>>> 2009/3/29 Dmitry Potapov <dpotapov@gmail.com>:
>>>> On Sun, Mar 29, 2009 at 18:13:47 +0100, Marcin Owsiany
>>>> <porridge@debian.org> wrote:
>>>>> As you can see, "master" sprang back to life after the last command.
>>>> It looks like git-svn does not like a repo without 'master'. It seems
>>>> the problem was caused by this patch:
>>>> http://git.kernel.org/?p=git/git.git;a=commit;h=1e889ef36c45b5554f7e317493ed3f4f901f8d9f
>>>>
>>>> I have added Eric to CC...
>>> Why not just check if HEAD points to a valid commit, rather than
>>> master? It should do the same
>>> in the newly created repo case, and stop annoying people on updates.
>> There seems to be agreement that while conventions are nice, git should
>> not force branch names on people. Can someone implement Mikael's
>> suggestion?
> 
> [silence]
> 
> OK, a different question, then: if I wrote a patch to implement the
> behaviour described by Mikael, would you consider including it?
> 

Patches are always considered, but asking about inclusion before the
code is written doesn't really work. If you care about this feature
and really want it, you should write the patch and submit it to the
mailing list for discussion. It might get dropped on the floor or it
might get accepted, but without you actually showing that you want
it, nothing at all will happen.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
