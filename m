From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #02; Wed, 12)
Date: Fri, 14 Aug 2009 18:51:01 -0700
Message-ID: <7vfxbt6e0q.fsf@alter.siamese.dyndns.org>
References: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
 <m3k516nic0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 03:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc8QQ-0001C1-1S
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 03:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbZHOBvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 21:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755977AbZHOBvH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 21:51:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953AbZHOBvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 21:51:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A654C299CE;
	Fri, 14 Aug 2009 21:51:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9721F299CD; Fri, 14 Aug 2009
 21:51:02 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 184EA5CE-893E-11DE-99F5-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125975>

Jakub Narebski <jnareb@gmail.com> writes:

>> * jn/gitweb-blame (Thu Aug 6 19:11:52 2009 +0200) 14 commits
>>  - gitweb: Create links leading to 'blame_incremental' using
>>    JavaScript
>>  - gitweb: Incremental blame (proof of concept)
>>  - gitweb: Add optional "time to generate page" info in footer
>>  + Revert the four topmost commits from jn/gitweb-blame topic
>>  + gitweb: Create links leading to 'blame_incremental' using
>>    JavaScript
>>  + gitweb: Incremental blame (proof of concept)
>>  + gitweb: Add optional "time to generate page" info in footer
>>  + gitweb: Add -partial_query option to href() subroutine
>>  + gitweb: Use light/dark for class names also in 'blame' view
>>  + gitweb: Add author initials in 'blame' view, a la "git gui blame"
>>  + gitweb: Mark commits with no "previous" in 'blame' view
>>  + gitweb: Use "previous" header of git-blame -p in 'blame' view
>>  + gitweb: Mark boundary commits in 'blame' view
>>  + gitweb: Make .error style generic
>> 
>> I haven't picked up Jakub's replacement to the second one from the tip.
>> We probably should merge up to "Use light/dark" (aef3768) to 'master' and
>> start the rest over.
>
> That would be good idea.

Thanks, will do.

> What about 'gitweb: fix variable scoping issue in git_get_projects_list'
> latest version of patch, adding (re)declaring $project_maxdepth,
> $projectroot as global variables using our?  Or are you waiting for
> response of our resident Perl expert: Randal L. Schwartz (merlyn)?

Not in my queue, but no need to resend --- I can find it.
