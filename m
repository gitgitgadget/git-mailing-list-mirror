From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] push: --ignore-stale option
Date: Wed, 14 Dec 2011 00:48:54 +0100
Message-ID: <4EE7E466.4060406@op5.se>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rac5q-0004HY-U9
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061Ab1LMXtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:49:01 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37209 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755106Ab1LMXtA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 18:49:00 -0500
Received: by lagp5 with SMTP id p5so96499lag.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 15:48:59 -0800 (PST)
Received: by 10.152.124.36 with SMTP id mf4mr164482lab.23.1323820138953;
        Tue, 13 Dec 2011 15:48:58 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id ng10sm592065lab.13.2011.12.13.15.48.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 15:48:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7vobvct58u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187080>

On 12/14/2011 12:35 AM, Junio C Hamano wrote:
> 
>     You however should be testing these 7 before pushing them out anyway,
>     and the sane way to do so is to check one out, test it, push it, and
>     iterate that sequence 7 times. If you do so, a workable alternative is
>     to use the configuration to push the current branch and you do not need
>     this patch series at all.
> 
>     Perhaps this series encourages a wrong workflow in that sense. I dunno.
> 

I for one really love it and will probably make an alias to use for most of
my repos. With 'maint' branches (with topics) being worked on by one team and
'master' (with topics) being worked on by a different group, but all branches
generally checked out, tracked and touched by everyone sooner or later, I've
come to just ignore the "not fast-forward" error. I've never stopped loathing
it though, since git should just *know* that it doesn't fast-forward because
I haven't done anything and not because I've done something (and maybe
forgotten to push) and someone else has done something different, which would
actually be interesting for me to know.

So big thumbs up and three loud "hurrah"'s for this.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
