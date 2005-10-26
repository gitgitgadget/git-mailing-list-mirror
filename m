From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: 26 Oct 2005 08:10:47 -0700
Message-ID: <86mzkwfh54.fsf@blue.stonehenge.com>
References: <86y84gfjv4.fsf@blue.stonehenge.com>
	<86u0f4fjah.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 17:17:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUmvY-00043H-EI
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 17:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVJZPKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVJZPKx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 11:10:53 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:52308 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964781AbVJZPKw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 11:10:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3C44D8F335;
	Wed, 26 Oct 2005 08:10:48 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 18354-01-81; Wed, 26 Oct 2005 08:10:47 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C5F9F8F301; Wed, 26 Oct 2005 08:10:47 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.12.13.7; tzolkin = 4 Manik; haab = 5 Zac
In-Reply-To: <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10671>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Hi,
Johannes> On Wed, 26 Oct 2005, Randal L. Schwartz wrote:

Randal> sha1_file.c:1247: error: `ENOTSUP' undeclared (first use in this 
>> function)

Johannes> I thought ENOTSUP is POSIX standard?

Johannes> What does your man page for link() say? If it is not supported, what value 
Johannes> will be in errno?

EOPNOTSUPP

Probably a BSD thing.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
