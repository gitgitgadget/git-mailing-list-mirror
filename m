From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or configured
Date: Fri, 06 Mar 2009 07:25:26 -0800 (PST)
Message-ID: <m3r61aisdo.fsf@localhost.localdomain>
References: <20090305221529.GA25871@pvv.org>
	<fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
	<200903052322.02098.markus.heidelberg@web.de>
	<200903052325.44648.markus.heidelberg@web.de>
	<fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
	<alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
	<7v4oy7szze.fsf@gitster.siamese.dyndns.org>
	<20090306114812.GA19534@pvv.org>
	<alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:27:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfbwz-0004XQ-Lb
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbZCFPZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbZCFPZb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:25:31 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:64036 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZCFPZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:25:30 -0500
Received: by fxm24 with SMTP id 24so425004fxm.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=upYDUEcbApQy9RKoBJihPtGdVh5ps8mTy/RmbKQSAMo=;
        b=Uw8jmVkRXUH0PV8iTmZpc9DiagKooI0lLO3XqQK/Uw5n561EiXGzE5h0MQBhQh8Vli
         iGPPfYvJhS9lvVF6+yt5nPem4/Y2uGDU0TNwoDKCwWhdwWkXdk1Sm+bomh6A78nOo03Z
         PDQ0FIHN8HONJOTzVr9rzC9GWktsNyOuOkqSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DWdaUlYRvDYzB0sIp34z9+HOEPIVKf07z9kL5H9QU0Tk1YyqA7+besJ3MYpCGcStS8
         BmsgZIieizAKl1gqhQFW/hjRbg6mUfaRe/aO1MJNRQIR8se3FfsWUs9W6dgJk12QHxk/
         kyQ2j5G9LtsH5pbpuUR2Vq/2h/1fp01vKk24I=
Received: by 10.103.105.1 with SMTP id h1mr1122599mum.13.1236353127356;
        Fri, 06 Mar 2009 07:25:27 -0800 (PST)
Received: from localhost.localdomain (abwf107.neoplus.adsl.tpnet.pl [83.8.229.107])
        by mx.google.com with ESMTPS id t10sm1806126muh.58.2009.03.06.07.25.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 07:25:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n26FRJ1u021330;
	Fri, 6 Mar 2009 16:27:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n26FRHJo021327;
	Fri, 6 Mar 2009 16:27:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112445>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Fri, 6 Mar 2009, Finn Arne Gangstad wrote:
>> On Fri, Mar 06, 2009 at 02:32:53AM -0800, Junio C Hamano wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>> On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
>>>>> 
>>>>> Right, I'd like to be able to do:
>>>>> $ git config push.iamnotretarded true
>>>>> $ git push
>>>>
>>>> LOL!  Sverre, you have a way to crack me up...
>>> 
>>> I found it amusing, too.
>>> 
>>> It may have some correlation with how well organized your work habit is,
>>> but I do not think it has much correlation with being retarded.  It is
>>> more about "'matching refs' is the perfect default for _my_ use pattern,
>>> don't mess with it, please".
>> 
>> So here is my current WIP suggestion for a new "push.default"
>> variable, I am not sure if a single entry can express all useful
>> choices, or if it is a good idea to introduce more default choices
>> other than "nothing" (with the goal of making it the default in a
>> later release).
> 
> Speaking of which, Steffen (who cannot reply right now, since he is AFK 
> for a while) had a patch to install "remote.<branch>.push = HEAD" with 
> clone and remote.  Would that be better?

Errr... I thought that "remote.<remotename>.push = HEAD" works?

But note that "remote.<name>.push = HEAD" (push current branch only)
and "remote.<name>.push = :" (push matching branches, i.e. curent
behavior) works only if you have remote configured... "git push <URL>"
won't be affected, and people (probably) would want to either have
'nothing' as default, or/and be able to configure it to nothing,
current, or matching (at least).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
