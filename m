From: Thomas Koch <thomas@koch.ro>
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 14:51:48 +0200
Message-ID: <201310241451.48788.thomas@koch.ro>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr> <5268B7D6.5050106@viscovery.net> <1382616665.23343.37953397.70FB76CB@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: james.moger@gitblit.com
X-From: git-owner@vger.kernel.org Thu Oct 24 14:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZKOK-0007tz-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 14:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab3JXMvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 08:51:52 -0400
Received: from mx51.mymxserver.com ([188.94.250.25]:21149 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab3JXMvv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 08:51:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.mx51.mymxserver.com (Postfix) with ESMTP id 5F0201986AE;
	Thu, 24 Oct 2013 14:51:50 +0200 (CEST)
X-Virus-Scanned: by Mittwald Mailscanner
Received: from mx51.mymxserver.com ([127.0.0.1])
	by localhost (mx51.mymxserver.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBMkVDY2oHam; Thu, 24 Oct 2013 14:51:50 +0200 (CEST)
Received: from koch.localnet (46-127-206-63.dynamic.hispeed.ch [46.127.206.63])
	(Authenticated sender: koch@comsolit.ch)
	by mx51.mymxserver.com (Postfix) with ESMTP id 8E42F198723;
	Thu, 24 Oct 2013 14:51:49 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.10-0.bpo.3-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1382616665.23343.37953397.70FB76CB@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236584>

On Thursday, October 24, 2013 02:11:05 PM james.moger@gitblit.com wrote:
> > That said, I don't think that --change-id option that the user must not
> > forget to use is any better than a hook that the user must not forget to
> > install.

I'm a bit paranoid. (e.g. I do all my development in a virtual machine and my 
host machine only runs binaries from debian stable.)

A command line option is a big improvement over having to download a random 
script from some potentially untrusted place and executing it probably even 
with the same user that also has access to my GPG key that signs my code and 
my SSH key that has access to the repository.

Regards, Thomas Koch
