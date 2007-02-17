From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Sat, 17 Feb 2007 09:53:56 -0800
Message-ID: <7v8xewvfez.fsf@assigned-by-dhcp.cox.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
	<7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
	<45D63C7A.4050300@verizon.net>
	<7vfy95w9sc.fsf@assigned-by-dhcp.cox.net>
	<45D713C0.1010401@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 18:54:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HITlJ-0007GU-9i
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 18:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbXBQRx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 12:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbXBQRx6
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 12:53:58 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36483 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030223AbXBQRx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 12:53:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217175358.XGOM21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 12:53:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qhtw1W00R1kojtg0000000; Sat, 17 Feb 2007 12:53:57 -0500
In-Reply-To: <45D713C0.1010401@verizon.net> (Mark Levedahl's message of "Sat,
	17 Feb 2007 09:40:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39998>

Mark Levedahl <mdl123@verizon.net> writes:

> Junio C Hamano wrote:
> ...
>> A final note.  A real 'mirror' mode should also remove stale
>> refs that do not exist on the remote side anymore, which is a
>> different use case as your bundle,...
>> ...  A real 'mirror' mode
>> would use a separate option to remove a ref that does not exist
>> on the remote end anymore, like:
>>
>> 	$ git fetch --mirror-all git://git.kernel.org/pub/scm/git/git.git
>>
> Perhaps "git fetch --mirror --delete" would be more suggestive of the
> difference to "git fetch --mirror"?

I think that is a good suggestion, as people familiar with rsync
already know what --delete means in such a context.
