From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-add has gone lstat() mad
Date: Sat, 31 Mar 2007 07:54:37 -0700
Message-ID: <86lkhdqx8y.fsf@blue.stonehenge.com>
References: <200703302055.13619.andyparkins@gmail.com>
	<7vslbmxkcv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org>
	<200703311119.10581.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 16:54:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXeym-0002xb-JO
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 16:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbXCaOyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbXCaOyi
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 10:54:38 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:23579 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbXCaOyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 10:54:38 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id AD3CB1DE381; Sat, 31 Mar 2007 07:54:37 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.8; tzolkin = 5 Lamat; haab = 1 Uayeb
In-Reply-To: <200703311119.10581.andyparkins@gmail.com> (Andy Parkins's message of "Sat, 31 Mar 2007 11:18:58 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43559>

>>>>> "Andy" == Andy Parkins <andyparkins@gmail.com> writes:

Andy> I've not done any extensive tests for regressions, but I've done

Andy>  cd $HOME
Andy>  git init
Andy>  git add .bashrc
Andy>  git add somedirectory/

Andy> And they work fine.  So - it's works for me from me, and a big happy 
Andy> grin.

Given that git currently doesn't maintain any metadata other than +x/-x, how
are you maintaining the metadata for your homedir items?  I know some schemes
were discussed here in the past, but I'm curious as to what you settled on.
For example, your .netrc file needs to be 600, but git won't track that.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
