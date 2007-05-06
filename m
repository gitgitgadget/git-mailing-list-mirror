From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sun, 06 May 2007 10:35:53 -0700
Message-ID: <7v1whtdfd2.fsf@assigned-by-dhcp.cox.net>
References: <463BD40C.6080909@gmail.com>
	<Pine.LNX.4.64.0705050324580.4015@racer.site>
	<7vwszolz26.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
	<Pine.LNX.4.64.0705051637450.4015@racer.site>
	<7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705061653100.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 06 19:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkkeO-00011c-6O
	for gcvg-git@gmane.org; Sun, 06 May 2007 19:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXEFRf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbXEFRfz
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 13:35:55 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52336 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbXEFRfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 13:35:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506173554.CAXM24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 6 May 2007 13:35:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id vtbt1W00C1kojtg0000000; Sun, 06 May 2007 13:35:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46351>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 5 May 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> (a) In a bare repository, I believe 
>> >> setup.c:setup_git_directory_gently() determines the prefix to be 
>> >> NULL.  This means my patch will see ALL paths as absolute, except 
>> >> :../path which will result in an error.
>> >
>> > My point was that it feels inconsistent to take the current path into 
>> > account in one case, but not in the other.
>> 
>> I do not understand your reasoning.  In a bare repository you cannot 
>> even be in a subdirectory to begin with.
>
> Exactly! That is my point. If you can do it in a working directory, but 
> also with a bare repository, I find it highly confusing and inconsistent 
> to have different meaning.

Sorry.  Now you confused me further.  I can do:

	cd Documentation
        git diff v1.5.0 v1.5.1 -- git.txt

Is that confusing, inconsistent and bad for the users?
