From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Improve sed portability
Date: Sun, 13 Jul 2008 13:00:34 -0700 (PDT)
Message-ID: <m34p80rm5w.fsf@localhost.localdomain>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
	<484FDB5D.7060606@viscovery.net> <484FEF71.2030909@isode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Chris Ridd <chris.ridd@isode.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI7lH-0005kr-V0
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbYGMUAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbYGMUAh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:00:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:20735 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYGMUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:00:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2585746fkq.5
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=yEAq7TK4WIpzL+tBPhcXs8Dt1DRlcXcoo32kbljTjH8=;
        b=HH8mC8YVJvVE5JRT4z94ehS1T5frdeSmbPCHprZAfxcWplBj0SeaGcFLfL1CSs5fHB
         +O326MX1fsG0xrYNPnGrW8bPTuzN7F+j2BczkFN4ldRBU+p07d9jx7Gj4HXJdJvjyVTM
         TarJATAFC514RzzUV1otb4Vu454EVECeR7xy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=uZtHmHolagCPli4FOZ1EYiN/67xMgi2JZb7o7AoPv1yh6AUrQh8YoqCl1NsfXPX1T5
         isam9J+kL64BSQZBHVZ3YT4lbgqIyaKo5GfpsEX71rszBojHze3G9Vyd6gABasgajMEJ
         caq2jm2EhgIHZSMDjFj4zMX4nwls+RvTzhUo8=
Received: by 10.187.194.7 with SMTP id w7mr1123511fap.75.1215979235651;
        Sun, 13 Jul 2008 13:00:35 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.203.164])
        by mx.google.com with ESMTPS id 39sm2870031hug.5.2008.07.13.13.00.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jul 2008 13:00:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6DK4fXC002121;
	Sun, 13 Jul 2008 22:04:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5BG6Z2A020190;
	Wed, 11 Jun 2008 18:06:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)git@vger.kernel.org
								     ^-missing end of address
In-Reply-To: <484FEF71.2030909@isode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88326>

Chris Ridd <chris.ridd@isode.com> writes:

> Of course, using a plain old:
> 
>      echo "$1"
> 
> should work well too. Why is printf being used here and not echo,
> anyway?

Uh, because 'echo -n' is not portable enough, and for some reason it
was though that there shouldn't be final newline?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
