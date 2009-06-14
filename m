From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Sun, 14 Jun 2009 22:16:16 +0100
Message-ID: <20090614211616.GA29742@beczulka>
References: <20090329171347.GA26866@beczulka> <37fcd2780903291252i19bba8ccx9dfb73e763d95b15@mail.gmail.com> <237967ef0904030357u15ef77f2rb3299b6f6c651404@mail.gmail.com> <20090606105501.GA29758@beczulka> <20090614155205.GC11730@beczulka> <4A353486.2060900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 23:16:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFx4B-0008Ug-PX
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 23:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbZFNVQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 17:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbZFNVQL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 17:16:11 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:50157 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZFNVQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 17:16:10 -0400
Received: by ewy6 with SMTP id 6so4507566ewy.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 14:16:11 -0700 (PDT)
Received: by 10.216.36.73 with SMTP id v51mr2106711wea.215.1245014171114;
        Sun, 14 Jun 2009 14:16:11 -0700 (PDT)
Received: from beczulka (dsl-49-57.dsl.netsource.ie [213.79.49.57])
        by mx.google.com with ESMTPS id i34sm9128482gve.13.2009.06.14.14.16.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 14:16:10 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.69)
	(envelope-from <marcin@owsiany.pl>)
	id 1MFx3o-00083B-Q7
	for git@vger.kernel.org; Sun, 14 Jun 2009 22:16:16 +0100
Content-Disposition: inline
In-Reply-To: <4A353486.2060900@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121563>

On Sun, Jun 14, 2009 at 07:33:58PM +0200, Andreas Ericsson wrote:
> Marcin Owsiany wrote:
>> On Sat, Jun 06, 2009 at 11:55:01AM +0100, Marcin Owsiany wrote:
>>> This discussion seems to have stalled...
>>>
>>> On Fri, Apr 03, 2009 at 12:57:52PM +0200, Mikael Magnusson wrote:
>>>> 2009/3/29 Dmitry Potapov <dpotapov@gmail.com>:
>>>>> On Sun, Mar 29, 2009 at 18:13:47 +0100, Marcin Owsiany
>>>>> <porridge@debian.org> wrote:
>>>>>> As you can see, "master" sprang back to life after the last command.
>>>>> It looks like git-svn does not like a repo without 'master'. It seems
>>>>> the problem was caused by this patch:
>>>>> http://git.kernel.org/?p=git/git.git;a=commit;h=1e889ef36c45b5554f7e317493ed3f4f901f8d9f
>>>>>
>>>>> I have added Eric to CC...
>>>> Why not just check if HEAD points to a valid commit, rather than
>>>> master? It should do the same
>>>> in the newly created repo case, and stop annoying people on updates.
>>> There seems to be agreement that while conventions are nice, git should
>>> not force branch names on people. Can someone implement Mikael's
>>> suggestion?
>>
>> [silence]
>>
>> OK, a different question, then: if I wrote a patch to implement the
>> behaviour described by Mikael, would you consider including it?
>>
>
> Patches are always considered, but asking about inclusion before the
> code is written doesn't really work. If you care about this feature
> and really want it, you should write the patch and submit it to the
> mailing list for discussion. It might get dropped on the floor or it
> might get accepted, but without you actually showing that you want
> it, nothing at all will happen.

Yes, I understand that. I was more looking for some guidance on whether
working in that direction makes sense. I'm still a git newbie :-)

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
