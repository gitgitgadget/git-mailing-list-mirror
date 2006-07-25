From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow an alias to start with "-p"
Date: Tue, 25 Jul 2006 13:34:29 -0700
Message-ID: <7v8xmhe84q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060725050312.GA5618@coredump.intra.peff.net>
	<Pine.LNX.4.63.0607250813450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 25 22:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Tbu-0007pe-JY
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 22:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWGYUeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 16:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWGYUeb
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 16:34:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64475 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751532AbWGYUea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 16:34:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060725203430.DPZZ985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Jul 2006 16:34:30 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607250813450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 25 Jul 2006 08:18:46 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24186>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Patch is below (wow, that +++ is kind of ugly!).
>
> Same here.

Same here ;-).

> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
>> @@ -289,8 +289,8 @@ int main(int argc, const char **argv, ch
>>  	if (!strncmp(cmd, "git-", 4)) {
>>  		cmd += 4;
>>  		argv[0] = cmd;
>> -		handle_alias(&argc, &argv);
>>  		handle_internal_command(argc, argv, envp);
>> +		handle_alias(&argc, &argv);
>>  		die("cannot handle %s internally", cmd);
>>  	}
>
> Alternatively, you can just delete it. IIRC we decided that aliases with 
> "git-" commands do not make sense.

I think that is reasonable and simpler.
