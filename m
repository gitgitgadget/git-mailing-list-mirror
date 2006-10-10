From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-revert in branch next
Date: Mon, 9 Oct 2006 18:11:34 -0700 (PDT)
Message-ID: <20061010011134.58584.qmail@web31809.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 10 03:11:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX69j-0008Un-M2
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 03:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWJJBLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 21:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWJJBLg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 21:11:36 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:45229 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751939AbWJJBLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 21:11:35 -0400
Received: (qmail 58586 invoked by uid 60001); 10 Oct 2006 01:11:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xAlgsLqeIj4O+5bGVEz3c1McyCU8zQQRRig7K+ULpIz/eK6iU6vuUgCwzM4yFybY9/Jadi2tJqrpvGZSqK3IGfIh8/UkEUCnVZ1R/625hEu+RKxJk2Oe6jbyHVWqFSv4rU02st6UuqDlVVpeFvPIksBHvD5Q2Y7KvUz3u7IyX0g=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 18:11:34 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28591>

--- Luben Tuikov <ltuikov@yahoo.com> wrote:
> Has anyone successfully used "git-revert" from branch next, lately?
> It seems to print USAGE no matter what arguments are given to it.

Line 50:

test "$me,$replay" = "revert,t" && usage

is suspicious after commit abd6970a.

   Luben
