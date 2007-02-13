From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add note about needing to do 'git checkout -f master'.
Date: Tue, 13 Feb 2007 10:09:50 -0800
Message-ID: <7vps8evsi9.fsf@assigned-by-dhcp.cox.net>
References: <1171302581735-git-send-email->
	<Pine.LNX.4.63.0702131857460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Richard W.M. Jones" <rjones@redhat.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH26E-0001x8-RB
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbXBMSJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbXBMSJv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:09:51 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61325 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbXBMSJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:09:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213180949.SNLL4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 13:09:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P69q1W0061kojtg0000000; Tue, 13 Feb 2007 13:09:50 -0500
In-Reply-To: <Pine.LNX.4.63.0702131857460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 13 Feb 2007 18:58:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39567>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 12 Feb 2007, Richard W.M. Jones wrote:
>
>> From: Richard Jones <rjones@redhat.com>
>> 
>> ---
>>  Documentation/git-cvsimport.txt |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>> 
>> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
>> index f5450de..7b43ed4 100644
>> --- a/Documentation/git-cvsimport.txt
>> +++ b/Documentation/git-cvsimport.txt
>> @@ -138,6 +138,12 @@ If '-v' is specified, the script reports what it is doing.
>>  Otherwise, success is indicated the Unix way, i.e. by simply exiting with
>>  a zero exit status.
>>  
>> +NOTES
>> +-----
>> +If importing for the first time into a directory (-C option),
>> +after the import do 'git checkout -f master' in the new
>> +directory.
>> +
>>  
>>  Author
>>  ------
>> -- 
>> 1.4.4.2
>
> AFAICT this is no longer necessary in 1.5.0.

I think you are right.  I always run cvsimport with -i so I was
confused ;-).
