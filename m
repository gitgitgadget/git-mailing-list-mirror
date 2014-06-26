From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: Is it possible to list unpushed tags without accessing remote?
Date: Thu, 26 Jun 2014 23:20:44 +0400
Message-ID: <5968CD7E-9E90-422C-B4F7-C0151FDEB1B4@jetbrains.com>
References: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com> <CAJo=hJvdMURuaEZA3XEWE_Uuq8QRZ+mt8K2H8XrbTuZsVX9gKQ@mail.gmail.com> <874mz76281.fsf@igel.home> <xmqqlhsj4hmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 8BIT
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0FE4-0006uA-GT
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbaFZTUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:20:49 -0400
Received: from mail1.intellij.net ([46.137.178.215]:41129 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaFZTUs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 15:20:48 -0400
Received: (qmail 6915 invoked by uid 89); 26 Jun 2014 19:20:46 -0000
Received: from unknown (HELO ?10.0.1.3?) (Kirill.Likhodedov@jetbrains.com@109.167.130.96)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 26 Jun 2014 19:20:46 -0000
In-Reply-To: <xmqqlhsj4hmq.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252520>


On 26 Jun 2014, at 23:04 , Junio C Hamano <gitster@pobox.com> wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
>> Not by default, but it is easy to configure your clone to fetch tags to
>> a separate namespace.
> 
> But then in order to learn what tags the remote has, you need to
> talk to the remote and it won't be "complately a local" operation
> anymore, no?

If I understand the solution correctly, it looks like it is not needed, if I’m OK with knowing which tags the remote had during the last fetch. 

Just like with commits: 'git log origin/master..’ can give me incorrect results if e.g. commits were rebased on the remote site. But we usually ignore such possibility as improbable.
