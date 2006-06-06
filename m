From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 09:58:23 -0700
Message-ID: <7vlksate4w.fsf@assigned-by-dhcp.cox.net>
References: <200606061605.k56G5gHo006581@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 18:58:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnesu-0004yN-Nx
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 18:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWFFQ60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWFFQ6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 12:58:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39859 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750738AbWFFQ6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 12:58:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606165824.BHPB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 12:58:24 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200606061605.k56G5gHo006581@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Tue, 06 Jun 2006 12:05:42 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21389>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>>                                                     but I am
>> inclined to do this instead:
>> 
>> 	my $domain_regexp = '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';
>> 
>> (i.e. still require at least two levels).
>
> OK, but be careful as this (?:...) is an extended regexp (needs /x on
> match).

Are you sure about /x?
