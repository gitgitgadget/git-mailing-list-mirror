From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.0
Date: Wed, 14 Feb 2007 01:35:46 -0800
Message-ID: <7vabzht72l.fsf@assigned-by-dhcp.cox.net>
References: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net>
	<200702140906.37440.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 10:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHGYK-0002El-4W
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 10:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbXBNJfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 04:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbXBNJfs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 04:35:48 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36964 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbXBNJfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 04:35:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214093546.KAZ21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 14 Feb 2007 04:35:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PMbm1W0031kojtg0000000; Wed, 14 Feb 2007 04:35:46 -0500
In-Reply-To: <200702140906.37440.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 14 Feb 2007 09:06:35 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39628>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007 February 14 03:14, Junio C Hamano wrote:
>
>>  - There is a configuration variable core.legacyheaders that
>
>> The above two are not enabled by default and you explicitly have
>> to ask for them, because these two features make repositories
>
> It isn't really the case that you have to _enable_ legacyheaders?  It defaults 
> to on already.  You actually have to disable legacyheaders.

Ah, true.  What it should have stressed is that we currently
default to the safer, backward compatible behaviour, and you have
to explicitly ask to use more efficient but incompatible
encoding by setting core.legacyheaders to false.
