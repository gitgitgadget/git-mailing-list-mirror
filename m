From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Fri, 11 Jun 2010 18:26:18 +0200
Message-ID: <422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:43:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON7K9-0006a5-CY
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab0FKQnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 12:43:11 -0400
Received: from outmail128142.authsmtp.net ([62.13.128.142]:61036 "EHLO
	outmail128142.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755722Ab0FKQnJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 12:43:09 -0400
X-Greylist: delayed 959 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2010 12:43:09 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o5BGQPvj056827;
	Fri, 11 Jun 2010 17:26:25 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o5BGQMGG031380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jun 2010 17:26:23 +0100 (BST)
Received: from [192.168.1.6] (119.Red-88-3-76.dynamicIP.rima-tde.net [88.3.76.119])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o5BGQJ1i028944
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jun 2010 12:26:21 -0400
In-Reply-To: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 1386f67b-7576-11df-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH ax8dDEdVdwdEHAkR AmEBWVJeUl4/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEXcfYGF2 cR4dUxp6d0tHeHZ5 YwhjXXhdCkJ9J1t6 R0lSCGwHMTF9YGBN WV1YdwFWdgdKLBdN aQUxNiYHcQ5nFx4T P0ctZQV5Ei9YNTwd XgEAZV4fT08WGiJ0 SBEeVTUiGVVNQigo NBUpJxYWDQ4NNV0z OjON
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148962>

El 11/06/2010, a las 18:03, Scott Chacon escribi=F3:

> +	puts("The most commonly used git commands are:\n");
> +
> +	puts("Basic Commands:");
> +	print_command("init");
> +	print_command("clone");
> +	print_command("add");
> +	print_command("status");
> +	print_command("commit");
> +	puts("");
> +
> +	puts("Branch Commands:");
> +	print_command("branch");
> +	print_command("checkout");
> +	print_command("merge");
> +	print_command("tag");
> +	puts("");
> +
> +	puts("History Commands:");
> +	print_command("log");
> +	print_command("diff");
> +	print_command("reset");
> +	print_command("show");
> +	puts("");
> +
> +	puts("Remote Commands:");
> +	print_command("remote");
> +	print_command("fetch");
> +	print_command("pull");
> +	print_command("push");

Nice. I'm sure the output will be a bit less intimidating, but I am not=
 sure about some of the grouping choices you've made here.

"git checkout" is almost certainly a "Basic" command, even though it's =
used for creating and switching branches.

"git tag" doesn't really seem to be a "Branch" command, as it's for tag=
ging objects (usually commits), and not branches.

"git reset" is the odd one out in the "History" commands group. The oth=
er three commands are about _inspecting_ history, whereas "git reset" i=
s about changing the current HEAD. I actually think "git reset" fits be=
tter with the "Branch" commands.

I think I'd be inclined to use more descriptive headings and group the =
commands like this:

  Basic operation:
    init
    add
    status
    commit
    checkout

  Inspecting repository state and history:
    log
    diff
    show

  Working with branches:
    branch
    merge
    reset

  Interacting with other repositories:
    clone
    fetch
    pull
    push
    remote

=2E..</end of my 2 cents>

Cheers,
Wincent
