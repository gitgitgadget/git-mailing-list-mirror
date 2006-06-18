From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make t8001-annotate and t8002-blame more portable
Date: Sun, 18 Jun 2006 15:21:54 -0700
Message-ID: <7virmydrzx.fsf@assigned-by-dhcp.cox.net>
References: <20060618203321.G2e8b0080@leonov.stosberg.net>
	<7v3be218ri.fsf@assigned-by-dhcp.cox.net>
	<20060618220654.G4a2f724@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 00:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs5eZ-0006XB-ER
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 00:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWFRWV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 18:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWFRWV4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 18:21:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54402 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750952AbWFRWV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 18:21:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618222155.CJSA11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 18:21:55 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060618220654.G4a2f724@leonov.stosberg.net> (Dennis Stosberg's
	message of "Mon, 19 Jun 2006 00:06:54 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22106>

Dennis Stosberg <dennis@stosberg.net> writes:

>> It would have been more obvious if it were written like this:
>> 
>> 	$_ = "" if ($. == 1);
>> 
>> but probably it is just me.
>
> I have no strong preference...

Nah, don't worry -- I've already applied your version to my
tree.
