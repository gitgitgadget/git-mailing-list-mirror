From: Andreas Ericsson <ae@op5.se>
Subject: Re: update @version in file
Date: Wed, 13 May 2009 19:38:39 +0200
Message-ID: <4A0B059F.1020509@op5.se>
References: <1242205190383-2879913.post@n2.nabble.com>	<m3iqk5l4ps.fsf@localhost.localdomain>	<20090513160415.GA4097@andros.launchmodem.com>	<200905131856.46344.jnareb@gmail.com> <vpqeiutrl09.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Dan Loewenherz <dloewenherz@gmail.com>,
	takeshin <admirau@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 13 19:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4IPt-0000m1-F1
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759704AbZEMRin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758973AbZEMRim
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:38:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39384 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbZEMRim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 13:38:42 -0400
Received: by fxm2 with SMTP id 2so798944fxm.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 10:38:41 -0700 (PDT)
Received: by 10.86.33.10 with SMTP id g10mr1508275fgg.21.1242236321551;
        Wed, 13 May 2009 10:38:41 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e11sm3615915fga.21.2009.05.13.10.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 10:38:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <vpqeiutrl09.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119075>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> 2. If you wanted however to have *file* version (like in CVS), then it
>>    is impossible because Git doesn't store such info
> 
> What could make sense is the commit id where the file was last
> modified (i.e. the first item that appears when one runs "git log" on
> the file). Not exactly as simple as it could be because of merge, but
> not completely meaningless either.
> 

That would also incur an impossible performance penalty. A *LOT* of
projects have a LICENSE file that hasn't been changed since the project
was put under version control in the first place. Is git suppose to
dig through history for every revision just to make sure that the
LICENSE file hasn't been changed since 1999?

Now think about such a feature for a project with 20k+ files (not even
very large, as projects go) and see how much time you lose when
switching branches. Then ask yourself: What's more important: Developer
time or version numbers in files that can be hacked in to match the
entire project's version when releasing?

100% of all discussions about this on git@vger has ended up with the
conclusion that it's not worth wasting a couple of seconds of a
developer's time for this feature to exist. That's why this feature
doesn't exist in git yet.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
