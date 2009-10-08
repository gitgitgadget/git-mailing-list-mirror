From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git log -S not finding all commits?
Date: Thu, 08 Oct 2009 15:52:55 -0700
Message-ID: <86tyy9qz08.fsf@blue.stonehenge.com>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
	<362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
	<vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel <mjucde@o2.pl>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 09 00:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw1sy-0003fg-14
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 00:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbZJHWxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbZJHWxc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 18:53:32 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:31886 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbZJHWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 18:53:32 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 6FB5A1DE3AE; Thu,  8 Oct 2009 15:52:55 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.13.10; tzolkin = 4 Oc; haab = 8 Yax
In-Reply-To: <vpq63aqxflu.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu, 08 Oct 2009 13:57:49 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129720>

>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

Matthieu> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> git log -p --format="%s\n%x00"  | perl -0 -ne 'print if(/whatever-you-search/);'

That "if" is noisier than it needs to be:

  perl -0 -ne 'print if /this/'

suffices.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
