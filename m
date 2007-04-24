From: Junio C Hamano <junkio@cox.net>
Subject: Re: [OT] CDPATH
Date: Tue, 24 Apr 2007 09:57:17 -0700
Message-ID: <7vejm97lsi.fsf@assigned-by-dhcp.cox.net>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
	<7vvefmeqs6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk>
	<7vvefmdab8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704232351530.8430@beast.quantumfyre.co.uk>
	<769697AE3E25EF4FBC0763CD91AB1B0201D496D1@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
To: "Ron Parker" <ron.parker@mobot.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOKf-0005gA-Aq
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbXDXQ5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbXDXQ5T
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:57:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52083 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbXDXQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:57:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424165719.JEQS1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 12:57:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id r4xH1W00J1kojtg0000000; Tue, 24 Apr 2007 12:57:18 -0400
In-Reply-To: <769697AE3E25EF4FBC0763CD91AB1B0201D496D1@MBGMail01.mobot.org>
	(Ron Parker's message of "Tue, 24 Apr 2007 08:34:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45470>

"Ron Parker" <ron.parker@mobot.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> Are you sure bash-completion is the culprit, not your CDPATH?
>
> Sorry, I was half-asleep yesterday.  Of course it was CDPATH and not 
> bash-completion.

Thanks for confirmation.  This suggests in t/test-lib.sh we'd
better have "unset CDPATH" near the top to prevent surprises
like this.
