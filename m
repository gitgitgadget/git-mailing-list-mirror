From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Include a site name in page titles
Date: Tue, 11 Jul 2006 12:48:00 -0700
Message-ID: <7v64i353f3.fsf@assigned-by-dhcp.cox.net>
References: <11526131782190-git-send-email-alp@atoker.com>
	<11526131781900-git-send-email-alp@atoker.com>
	<1152613179634-git-send-email-alp@atoker.com>
	<46a038f90607110448p40fd8984ke3e15639cf5ecf46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 21:48:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0ODH-0005Ta-Nj
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGKTsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWGKTsE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:48:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27301 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932102AbWGKTsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 15:48:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711194801.JWMS11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 15:48:01 -0400
To: "Alp Toker" <alp@atoker.com>
In-Reply-To: <46a038f90607110448p40fd8984ke3e15639cf5ecf46@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 11 Jul 2006 23:48:58 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23730>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

>> +# name of your site or organization to appear in page titles
>> +our $site_name = "Untitled";
>
> I generally agree, but as a default, $ENV{SERVER_NAME} should be better.

Sounds like a good suggestion.
