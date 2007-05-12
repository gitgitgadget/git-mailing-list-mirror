From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG?] Detaching head at checked out point does not work.
Date: Sat, 12 May 2007 12:35:22 -0700
Message-ID: <7vd515ygw5.fsf@assigned-by-dhcp.cox.net>
References: <20070512172105.GB32764@efreet.light.src>
	<7v7ird2902.fsf@assigned-by-dhcp.cox.net>
	<20070512191833.GA8983@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat May 12 21:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxNI-0005Or-He
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXELTfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbXELTfY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:35:24 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:44263 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbXELTfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:35:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512193522.MFVI2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:35:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKbN1W0021kojtg0000000; Sat, 12 May 2007 15:35:22 -0400
In-Reply-To: <20070512191833.GA8983@efreet.light.src> (Jan Hudec's message of
	"Sat, 12 May 2007 21:18:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47083>

Jan Hudec <bulb@ucw.cz> writes:

> On Sat, May 12, 2007 at 11:26:53 -0700, Junio C Hamano wrote:
>> Jan Hudec <bulb@ucw.cz> writes:
>>
>> > I can correctly detach head by saying:
>> >
>> >   git checkout master^0
>> >
>> > (or git checkout master^{} or git checkout refs/heads/master), but NONE of
>> > these work, if I currently have master checked out. Shouldn't it detach
>> > anyway?
>> 
>> Yes, and it does as far as I know.
>> 
>> Do you have 3e0318a3?
>
> It does not seem to be in 1.5.1.4, so no, I don't.

As that commit is directly on top of v1.5.1, I think it may not
hurt to cherry-pick that single commit to 'maint' for 1.5.1.5,
although some may argue that it is not strictly a bugfix but a
new feature.
