From: Andreas Ericsson <ae@op5.se>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 16:07:48 +0200
Message-ID: <4A40E1B4.6090303@op5.se>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> <4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org> <4A40D6C2.2060700@op5.se> <20090623135755.GA24974@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 16:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ6fM-0002rV-A0
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 16:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759830AbZFWOHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 10:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759134AbZFWOHv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 10:07:51 -0400
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56155 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758950AbZFWOHu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 10:07:50 -0400
Received: from source ([209.85.220.215]) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkDhtzdkq56RZDsffj3fVol3X8CVbD8n@postini.com; Tue, 23 Jun 2009 07:07:53 PDT
Received: by fxm11 with SMTP id 11so98680fxm.10
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 07:07:51 -0700 (PDT)
Received: by 10.86.79.5 with SMTP id c5mr245883fgb.20.1245766071113;
        Tue, 23 Jun 2009 07:07:51 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm463206fga.3.2009.06.23.07.07.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 07:07:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090623135755.GA24974@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122091>

Finn Arne Gangstad wrote:
> On Tue, Jun 23, 2009 at 03:21:06PM +0200, Andreas Ericsson wrote:
>> Finn Arne Gangstad wrote:
>>> On Tue, Jun 23, 2009 at 02:59:10PM +0200, Paolo Bonzini wrote:
>>> [...]
>>>> Before going on, can you explain your use case for --push=tracking 
>>>> (in a  case where --push=current wouldn't do the same)?
>>> The idea with "tracking" is to push the current branch to wherever it
>>> would pull from, making push & pull "equivalent" in some sense.
>>>
>>> This is different from "current" if you have/choose to name the local
>>> branch something else than the remote branch. This happens a lot when
>>> using multiple remotes.
>>>
>>> E.g. some remotes have only a single active branch called "master",
>>> and you have to name it something else locally, or several people have
>>> local branches called "beta", and you have to name it something like
>>> "fred-beta" locally if you are working on fred's beta.
>>>
>> Umm. Why not name it after the feature you're working on instead of the
>> branch you started from? That way, you get fred/beta (assuming you've
>> added Fred's repo as a remote named "fred" ofcourse) and all your
>> branches have names that never (in theory) clash with any of your
>> upstreams.
> 
> Maybe I misunderstand what you are saying, but: The point is that you
> can not name it the same as on the remote. So the names are different,
> and --current will not work.
> 

I think our workflows differ quite drastically, as I very rarely see
the need to push more than one branch. When I do, it's for repositories
where I'm the ultimate upstream, so I only have one remote that I
actually *can* push to at all.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
