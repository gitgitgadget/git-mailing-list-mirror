From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 01:50:29 -0800
Message-ID: <7vfy91ximy.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:50:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRds-0007Nb-51
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbXBTJuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbXBTJuc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:50:32 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36271 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381AbXBTJub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:50:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220095030.TPSE1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 04:50:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RlqV1W0051kojtg0000000; Tue, 20 Feb 2007 04:50:30 -0500
In-Reply-To: <200702200942.18654.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 09:42:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40219>

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2007 February 19 20:07, Junio C Hamano wrote:
>
>> > -	if (!strncmp(path, "refs/tags/", 10)) {
>> > +	if (!strncmp(path, PATH_TAGS, STRLEN_PATH_TAGS)) {
>> >  		if (object->type == OBJ_TAG)
>> >  			prio = 2;
>> >  		else
>>
>> This is PATH_REFS_TAGS isn't it?
>
> I'm uncomfortable that this one managed to get through; in view of this 
> mistake if you are thinking of applying this - don't.  I'm going to review 
> the patch itself line by line.

I'd send the prefixcmp() patches first, as yours would touch the
same lines.

> Also - I should learn how to run the tests - is "make test"
> good enough or is there something special I should do?

Should be enough.
