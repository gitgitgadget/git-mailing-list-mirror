From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 23:42:48 -0700
Message-ID: <7v4ovoxk0n.fsf@alter.siamese.dyndns.org>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	<bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	<7v4ovo1iap.fsf@alter.siamese.dyndns.org>
	<bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
	<7veiusz45w.fsf@alter.siamese.dyndns.org>
	<bb9d69200905132334m7a4e3a4akde3529abeab5a09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cory Sharp <cory.sharp@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Uej-0004MX-L6
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbZENGms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbZENGms
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:42:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53132 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbZENGmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:42:47 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514064248.PMJP17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Thu, 14 May 2009 02:42:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rJio1b0024aMwMQ04Jio0E; Thu, 14 May 2009 02:42:48 -0400
X-Authority-Analysis: v=1.0 c=1 a=zSBdUJs4lXYA:10 a=pGLkceISAAAA:8
 a=QuBmuhVHgdMGTJSzTDoA:9 a=MxV2ZITsgjFb4bBXhc-vk1AUo9YA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <bb9d69200905132334m7a4e3a4akde3529abeab5a09@mail.gmail.com> (Cory Sharp's message of "Wed\, 13 May 2009 23\:34\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119153>

Cory Sharp <cory.sharp@gmail.com> writes:

>> If you want support for repeated merges by merge tracking, you do not want
>> todiscard the merge history by using --squash.
>
> Why doesn't --squash do merge tracking?  The help didn't indicate that
> it doesn't, and I don't understand why ...

Because "merge" is (no surprise) what tracks what (two or more) things
were merged.  And with --squash you are choosing not to make a merge.  I
am not sure if there is any more thing to be explained...
