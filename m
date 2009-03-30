From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows
 man page
Date: Mon, 30 Mar 2009 13:59:17 -0400
Message-ID: <49D10875.2060008@fastmail.fm>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm> <1238391319-4953-2-git-send-email-rocketraman@fastmail.fm> <7vk567ijlf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 20:01:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLn9-0001QH-L7
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 20:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZC3R72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZC3R71
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 13:59:27 -0400
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:39269 "HELO
	smtp107.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751561AbZC3R71 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 13:59:27 -0400
Received: (qmail 34158 invoked from network); 30 Mar 2009 17:59:24 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp107.rog.mail.re2.yahoo.com with SMTP; 30 Mar 2009 17:59:24 -0000
X-YMail-OSG: pLT7d8MVM1mlO9lSXxuMhk_sI3HfBLe1C55NbSRhTkeGojbqvvxiTU7YbpNCQpr5Rg--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 07B3321C051A;
	Mon, 30 Mar 2009 13:59:24 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPge7-eTr6Iy; Mon, 30 Mar 2009 13:59:18 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 092C121C0519;
	Mon, 30 Mar 2009 13:59:18 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vk567ijlf.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115180>

Junio C Hamano wrote:
> rocketraman@fastmail.fm writes:
> 
>> From: Raman Gupta <raman@rocketraman.com>
>>
>> Based on a mailing list discussion, add a description of the workflow,
>> and associated commands, for creating a feature release.
> 
> The same comment applies to the other one, but this commit log message is
> really lacking.  If you do not bother to summarize the discussion, place a
> pointer to the list archive, and more importantly, please describe *why*
> this change is desiable.

Ok will do.

> I am not sure rewinding and rebuilding of 'next', or even having 'next',
> is applicable for other projects as a BCP.  

Hmmm... The existing gitworkflows man page discusses the 'next' branch
several times. I am simply expanding the document to cover the branch
management associated with the git.git release process as well, which
necessarily includes a discussion of 'next'.

If you wish to remove discussion of 'next' from this document, that is
probably better done in a separate followup change. Though personally
I think its a useful concept for readers to learn about as they are
setting up their own workflows.

> Other parts (except for the "branch -f" bit I've already told you
> about in the other message) looked good.

I'll add some discussion about the branch -f bit -- I hope you agree
that in this document that is distributed with git, some
beginner-level explanation of the difference between the branch -f and
the merge approach is warranted?

Cheers,
Raman
