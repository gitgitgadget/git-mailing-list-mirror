From: Darrin Thompson <darrint@progeny.com>
Subject: Re: git-ls-files -o no recurse?
Date: Thu, 05 Jan 2006 12:15:52 -0500
Message-ID: <1136481352.5597.2.camel@localhost.localdomain>
References: <1136400692.5919.11.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 05 18:16:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYiY-0003nh-2k
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 18:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWAERP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWAERP6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 12:15:58 -0500
Received: from zealot.progeny.com ([216.37.46.162]:28864 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1751852AbWAERP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2006 12:15:57 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 5D1C0636AE; Thu,  5 Jan 2006 12:15:53 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14208>

On Wed, 2006-01-04 at 13:31 -0800, Linus Torvalds wrote:
> 
> On Wed, 4 Jan 2006, Darrin Thompson wrote:
> > 
> > Would it be hard to make git-ls-files optionally do this?
> 
> Something like the appended may or may not be what you're looking for..
> 

Worked great!

> @@ -19,6 +19,7 @@ static int show_stage = 0;
>  static int show_unmerged = 0;
>  static int show_modified = 0;
>  static int show_killed = 0;
> +static int show_ignored_directories = 0;
>  static int line_terminator = '\n';

Did you perhaps mean s/ignored/other/g ? I thought maybe you were being
clever but I couldn't get it to do anything useful with -i, only -o.

--
Darrin
