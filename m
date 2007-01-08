From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Mon, 08 Jan 2007 13:28:41 +0000
Message-ID: <45A24709.9090904@shadowen.org>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>	<11677659921833-git-send-email-j.ruehle@bmiag.de>	<459E2E57.6020503@shadowen.org>	<7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>	<459E4F2D.4000806@shadowen.org>	<17822.34697.691000.253492@lapjr.intranet.kiel.bmiag.de> <7vk601fh7k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Juergen Ruehle <j.ruehle@bmiag.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 14:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uYV-0003nl-7F
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbXAHN2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 08:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbXAHN2r
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:28:47 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4375 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161283AbXAHN2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:28:46 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H3uXU-0006iq-8I; Mon, 08 Jan 2007 13:27:48 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk601fh7k.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36255>

Junio C Hamano wrote:
> Juergen Ruehle <j.ruehle@bmiag.de> writes:
> 
>> Andy Whitcroft writes:
>>  > Junio C Hamano wrote:
>>  > > 
>>  > > Somebody did not like the verb "stage"; perhaps we can say:
>>  > > 
>>  > > 	# You have added changes to these files to be committed:
>>  > > 	...
>>  > 
>>  > # These files have changes and are marked for commit:
>>  > 
>>  > >         # There are yet to be added changes to these files:
>>  > 
>>  > # These files have changes but are not marked for commit:
>>
>> Does this better reflect that git tracks content and not files?
>>
>> # Changes to these files will be committed:
>>
>> # Changes to these files are not marked for commit:
> 
> One of the goals is to find a pair of messages that make sense
> when the same file appears on both lists.

Doh, double changes ... yes.

I am not sure it is possible to sanely textualise that subtlety in a
single line.  I wonder if its worth splitting this lot into three.
Basically those files on list one, those on list two and those on both.

Anyhow, lets see if we can textualise:

# Changes to these files will be committed:

# The latest changes to these files will not be committed:

The first here still implies its the latest changes.  I can not
trivially word round that.  Perhaps we could mention staging?

# Staged changes for these files will be commited:

# These files have unstaged changes which will not be committed:

>> BTW: how about also adding a hint how to review the changes in
>> question (i.e. diff --cached and diff; as an alternative to diff
>> --cached we could just advertise the --verbose switch to status and
>> commit).
> 
> Sounds sane.


-apw
