From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 09:25:38 -0700
Message-ID: <7viro7tful.fsf@assigned-by-dhcp.cox.net>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
	<7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
	<20060515092704.GB6855@localdomain>
	<7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
	<20060515101142.GD6855@localdomain>
	<46a038f90605150337l3357ce3by22834823eee7b87c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 18:26:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfftB-0000r2-DG
	for gcvg-git@gmane.org; Mon, 15 May 2006 18:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWEOQZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEOQZl
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 12:25:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:50672 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932332AbWEOQZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 12:25:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515162539.RBQW19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 12:25:39 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605150337l3357ce3by22834823eee7b87c@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 15 May 2006 22:37:18 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20064>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 5/15/06, Eric Wong <normalperson@yhbt.net> wrote:
>> Junio C Hamano <junkio@cox.net> wrote:
>> > I am not opposed to have an option to run a local submission
>> > agent binary (I said I like that if(){}else{} there, didn't I?).
>> > The ability to do so is a good thing.  I am not however sure
>> > about changing the default when no option is specified on the
>> > command line.
>>
>> By "I believe this is what Martin wanted", I meant changing the default to
>> sendmail: <46a038f90604271804j195d62f3x93ae816e809f4ffd@mail.gmail.com>
>>
>>         > Oh, it should just work with sendmail if it's there and we don't
>
> Thanks Eric! git-send-email used to default to using local binaries.
> It was only with the switch to Net::SMTP that the default changed to
> localhost:25.

Thanks, and I think it makes sense.
