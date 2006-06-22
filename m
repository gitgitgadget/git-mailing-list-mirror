From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Check and document the options to prevent mistakes.
Date: Wed, 21 Jun 2006 21:05:26 -0600
Message-ID: <m1irmt6gax.fsf@ebiederm.dsl.xmission.com>
References: <m164iu8x78.fsf@ebiederm.dsl.xmission.com>
	<7vy7vqxmb7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 05:05:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtFVl-0006Ja-PT
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 05:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbWFVDFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 23:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbWFVDFi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 23:05:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27054 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030582AbWFVDFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 23:05:37 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5M35QDK014166;
	Wed, 21 Jun 2006 21:05:26 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5M35QtF014165;
	Wed, 21 Jun 2006 21:05:26 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7vqxmb7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Jun 2006 13:53:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22297>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> +# Verify the user input
>> +
>> +foreach my $entry (@to) {
>> +	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
>> +}
>> +
>
> Perhaps, avoiding double negation would be easier on the eyes.
>
>         die ... if $entry =~ /,/

Sure double negation does get confusing.  I think I forgot about that
last if form.  My perl is rusty from disuse.  

> Does it grok '"Biederman, Eric W." <eb@xm.com>' some people seem
> to do properly, or do we care (I personally don't)?

Nope.  If figure that is lesser of two evils.  If I could properly
grok that I would make it do things properly and parse a --cc
option for multiple email addresses.

I think you can still specify those interesting forms in an alias
file, like .mailrc.

The important thing is not to do a mailing and the discover your
recipients didn't get the email.

Eric
