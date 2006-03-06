From: Brandon Philips <brandon@ifup.org>
Subject: Re: SSH with alternative port number?
Date: Mon, 6 Mar 2006 13:59:39 -0800
Message-ID: <20060306215939.GD14725@osuosl.org>
References: <20060306214418.66E153525CB@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 23:00:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGNk6-00009T-St
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 22:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbWCFV7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 16:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbWCFV7n
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 16:59:43 -0500
Received: from ns2.osuosl.org ([140.211.166.131]:48830 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1752449AbWCFV7l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 16:59:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ns2.osuosl.org (Postfix) with ESMTP id 30A8F121ADA;
	Mon,  6 Mar 2006 13:59:43 -0800 (PST)
Received: from ns2.osuosl.org ([127.0.0.1])
	by localhost (ns1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09210-06; Mon, 6 Mar 2006 13:59:42 -0800 (PST)
Received: from shell.osuosl.org (shell.osuosl.org [140.211.166.149])
	by ns2.osuosl.org (Postfix) with ESMTP id EEABC121ACD;
	Mon,  6 Mar 2006 13:59:41 -0800 (PST)
Received: by shell.osuosl.org (Postfix, from userid 1000)
	id BBF1F62C00A; Mon,  6 Mar 2006 13:59:39 -0800 (PST)
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20060306214418.66E153525CB@atlas.denx.de>
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at osuosl.org
X-Spam-Status: No, hits=-3.8 tagged_above=-999.0 required=5.0
	tests=ALL_TRUSTED, AWL, BAYES_00
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17307>

Hello Wolfgang-

man(5) ssh_config

Add something like this to your .ssh/config file:

Host example
	Hostname ssh.example.com
	Port 2222
	User wolfgang

Then use "example" as the hostname for the git commands instead of
ssh.example.com.

Best,

	Brandon

--
http://ifup.org


On 22:44 Mon 06 Mar     , Wolfgang Denk wrote:
> Hi,
> 
> is there any way to specify an alternative port number for SSH  based
> remote repository access?
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> "Here's a fish hangs in the net like a poor man's right in  the  law.
> 'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
