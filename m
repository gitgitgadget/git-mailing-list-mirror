From: Junio C Hamano <junkio@cox.net>
Subject: Re: announce: git browser
Date: Mon, 05 Dec 2005 23:45:42 -0800
Message-ID: <7vd5ka653t.fsf@assigned-by-dhcp.cox.net>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
	<20051205004238.GE22159@pasky.or.cz>
	<40b2b7d90512041720i65f63ee1pcfe32d2c0c3c357b@mail.gmail.com>
	<20051205232626.GH22159@pasky.or.cz>
	<40b2b7d90512052240t778f1c8kf182ff065687068c@mail.gmail.com>
	<7voe3u67ik.fsf@assigned-by-dhcp.cox.net>
	<40b2b7d90512052331s22adb055y9f99b8cafe20c0c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXWN-00027N-Aw
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVLFHpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbVLFHpp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:45:45 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58070 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751446AbVLFHpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 02:45:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206074422.WYGK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 02:44:22 -0500
To: Artem Khodush <greenkaa@gmail.com>
In-Reply-To: <40b2b7d90512052331s22adb055y9f99b8cafe20c0c3@mail.gmail.com>
	(Artem Khodush's message of "Tue, 6 Dec 2005 10:31:55 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13263>

Artem Khodush <greenkaa@gmail.com> writes:

>> This is not to discourage yet another web based one, but I wish
>> there were an NNTP interface, that feeds each repository/branch
>> as a newsgroup and each commit as if it is "git-format-patch"
>> output, with References: pointing at its parent commit "articles".
>>
>> A merge commit would probably become a multipart with usually 2
>> attachments (but N attachments for a N-way octopus), showing
>> diff from each branch.
>
> I'll see if I can do something with Perl and Net::NNTP..

"Ask and it shall be given you" ;-)

In case it was not obvious, I was talking about an NNTP server,
not a client.

You would probably have to keep a mapping between sequence
number and commit object name in each "newsgroup", which is the
only nontrivial part.
