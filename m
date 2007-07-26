From: Bert Douglas <bertd@tplogic.com>
Subject: Re: problem after cvsimport
Date: Thu, 26 Jul 2007 01:56:28 -0500
Message-ID: <46A8459C.7030202@tplogic.com>
References: <46A7FD99.9000305@tplogic.com> <7vlkd3c16z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxHL-0008NH-Tz
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923AbXGZG4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbXGZG4w
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:56:52 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:36569 "EHLO
	imf22aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754395AbXGZG4v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 02:56:51 -0400
Received: from ibm65aec.bellsouth.net ([68.220.183.197])
          by imf22aec.mail.bellsouth.net with ESMTP
          id <20070726065650.PMON13480.imf22aec.mail.bellsouth.net@ibm65aec.bellsouth.net>
          for <git@vger.kernel.org>; Thu, 26 Jul 2007 02:56:50 -0400
Received: from [192.168.1.96] (really [68.220.183.197])
          by ibm65aec.bellsouth.net with ESMTP
          id <20070726065650.GLIN275.ibm65aec.bellsouth.net@[192.168.1.96]>;
          Thu, 26 Jul 2007 02:56:50 -0400
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <7vlkd3c16z.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53791>

Junio C Hamano wrote:
> Bert Douglas <bertd@tplogic.com> writes:
>
>   
>> I am new to git, so probably doing something wrong.
>> Hope somebody can enlighten me.
>> Here is what happened so far.
>>
>> Followed instructions here:
>> http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html
>>
>> Did command like this:
>>
>> $ git cvsimport -C <destination> <module>
>>
>> This was done from top level of existing cvs working directory.
>> Destination was new empty directory, outside the cvs tree.
>>
>> It worked for several hours and seemed to complete ok.
>> I can look at history in destination git directory with gitk and git log.
>> All the stuff in ".git" looks normal, as far as I can tell.
>>
>> But I have no files in the working directory.
>> When I do command:
>> $git checkout master
>>
>> I get a bunch of lines to console with "D" in front.
>> Btw, what does that mean?  Nothing about it in "man git-checkout" or elsewhere that I can find.
>> Then it says -- Already on branch "master"
>>
>> But working directory is still empty.
>>     
>
> Have you tried "git checkout -f" after that?  With recent enough
> git, "git cvsimport -C <destination> <module>" from the top
> level of existing cvs working directory, with nonexistent
> destination directory (that is, you let "git cvsimport -C" to
> create that destination directory) would run "git checkout -f"
> for you.
>   
Somehow I missed that option.
That worked.  Very fast.  Thanks.

Am I going to have to do "-f" a lot?
How will I know when to do it?
Why not do it all the time?
