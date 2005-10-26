From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: 26 Oct 2005 08:30:39 -0700
Message-ID: <86irvkfg80.fsf@blue.stonehenge.com>
References: <86y84gfjv4.fsf@blue.stonehenge.com>
	<86u0f4fjah.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
	<86mzkwfh54.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 17:35:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUnEh-0005uL-SN
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 17:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVJZPal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 11:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVJZPal
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 11:30:41 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:41107 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964787AbVJZPak
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 11:30:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 123558F34D;
	Wed, 26 Oct 2005 08:30:40 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28263-01-18; Wed, 26 Oct 2005 08:30:39 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A07B58F6EE; Wed, 26 Oct 2005 08:30:39 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.12.13.7; tzolkin = 4 Manik; haab = 5 Zac
In-Reply-To: <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10674>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Hi,
Johannes> On Wed, 26 Oct 2005, Randal L. Schwartz wrote:

>> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
Johannes> What does your man page for link() say? If it is not 
Johannes> supported, what value will be in errno?
>> 
>> EOPNOTSUPP

Interesting... google for "ENOTSUPP EOPNOTSUPP".  Apparently
hits like this:

<http://sources.redhat.com/ml/bug-glibc/2002-08/msg00013.html>

shows that on some platforms, they may have both.  This is not as
easy as it looks.  Maybe define an extra || condition to handle either
or both?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
