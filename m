From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] archive: allow remote to have more formats than we understand.
Date: Sun, 10 Sep 2006 12:07:39 -0700
Message-ID: <7vwt8br150.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609101202y2ee1a18dwf09d6e104740777@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 21:07:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMUeF-0001Dp-Us
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWIJTG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWIJTG6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:06:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56522 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932510AbWIJTG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:06:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910190657.HCSK12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 Sep 2006 15:06:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Lj6n1V00C1kojtg0000000
	Sun, 10 Sep 2006 15:06:48 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609101202y2ee1a18dwf09d6e104740777@mail.gmail.com>
	(Franck Bui-Huu's message of "Sun, 10 Sep 2006 21:02:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26808>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

>> +static const char *remote_request(int *ac, const char **av)
>> +{
>
> just to be consistent with the rest of the file, I would have called
> this function
> "parse_remote_arg" or "extract_remote_arg"

I was thinking about calling this is_remote_request() actually.
