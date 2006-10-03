From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Tue, 03 Oct 2006 10:39:23 -0700
Message-ID: <7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	<eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 03 19:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUoEx-00035E-Vd
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWJCRj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 13:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJCRj0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:39:26 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58032 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030367AbWJCRjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 13:39:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003173924.RYMG21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 13:39:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VtfJ1V0081kojtg0000000
	Tue, 03 Oct 2006 13:39:18 -0400
To: Martin Waitz <tali@admingilde.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28282>

Martin Waitz <tali@admingilde.org> writes:

>> > My git repository import from subversion, and the latest files has
>> > correct mime-type property, but gitweb commitdiff NO diff output !
>> > 
>> > file:82dc767b3f1425435fa6d8fa7511718d3f614172 ->
>> > file:4c7269ed65bf8691c46541497fbecc706f7d012f
>> > 
>> > file:6817671d9af75b9adcc439d62f9047c7b2a9adb2 ->
>> > file:575d40108f550ac5965bb6ea8b6792fa9cc10536
>> 
>> Not enough information.
>
> A few months ago, I got that a on kernel.org a few times, too.
> After reloading the page it always got shown correctly, so I never bothered
> to report it.

This is just a wild guess without reproduction, but if that was
seen on kernel.org _temporarily_, it could be that rsync was in
the middle of mirroring and things other than these blobs that
were needed for you to reach that page (i.e. the commits and the
trees, and the refs/heads/master to mark the tip of the ancestry
chain) were already on the gitweb public machine but blobs
weren't.
