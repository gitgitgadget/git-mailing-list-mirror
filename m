From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: 2 questions on git-send-email usage
Date: Mon, 10 Jul 2006 19:00:10 +0000 (GMT)
Message-ID: <20060710190010.94648.qmail@web25808.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 10 21:00:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G00zS-0002bc-91
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWGJTAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbWGJTAN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:00:13 -0400
Received: from web25808.mail.ukl.yahoo.com ([217.12.10.193]:31362 "HELO
	web25808.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422749AbWGJTAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 15:00:12 -0400
Received: (qmail 94650 invoked by uid 60001); 10 Jul 2006 19:00:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=i0+7o+J5ohGmj2Z5KoZbcuWiV+Isl3p7VtWrat3z8YOUOVygkSS0RaDsTuRHDUkbX5jFEny5nQm4DyUH9NOIldxYlgEuK/mBd6+5StaCQCLWQ2kUM6CvisUQe+apF7W4T33qYq8iLucl9allJ3maqGG3eolc4XVBTA/VcZnQ93U=  ;
Received: from [82.235.205.153] by web25808.mail.ukl.yahoo.com via HTTP; Mon, 10 Jul 2006 19:00:10 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23637>

Hi

I'm wondering what am I supposed to answer when git-send-email
is asking me :

Message-ID to be used as In-Reply-To for the first email?

I'm running this command:

$ git-send-email --no-signed-off-by-cc --no-chain-reply-to --to foo@bar.com --compose /tmp/patch/

to write an introductory message, and all patches are sent as replies to
this introductory email sent.

I also noticed that git-send-email removes the commit message of each
patches I sent, I don't think this is the normal behaviour though. What 
am I missing ?

Thanks

Francis
