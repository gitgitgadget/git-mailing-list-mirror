From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.6.2
Date: Sun, 06 Jul 2008 02:30:20 -0700
Message-ID: <7vprprgy1f.fsf@gitster.siamese.dyndns.org>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
 <m38wwffn3b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 11:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFQag-0006wo-Gk
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 11:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYGFJad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 05:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYGFJad
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 05:30:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbYGFJac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 05:30:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 975371DC9F;
	Sun,  6 Jul 2008 05:30:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C57461DC9E; Sun,  6 Jul 2008 05:30:23 -0400 (EDT)
In-Reply-To: <m38wwffn3b.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 06 Jul 2008 01:09:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C631BBA-4B3E-11DD-BAD5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87509>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The RPM binary packages for a few architectures are also provided as
>> courtesy.  As the machine I cut them at kernel.org has been updated to FC9
>> recently, their filenames now have .fc9. in them.
>> 
>>   RPMS/$arch/git-*-1.5.6.2-1.fc9.$arch.rpm	(RPM)
>
> This unfortunately includes also SRPMS (.src.rpm), even though the
> source RPM from git repository is not distribution specific.  I think
> that src.rpm should drop '.fc9.' from name

It is whatever rpmbuild command does.  Not my problem.

Having said that, I vaguely recall some people from non Fedora nor RH
distros based on RPM were talking about how their .spec file would be
different from the one for FC.  Presumably the resulting SRPM would be
also distro specific, wouldn't it?
