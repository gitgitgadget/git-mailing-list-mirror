From: Kate Ebneter <kate@ning.com>
Subject: Re: Strange behavior (possible bug) using bash command
 subsitution  with "git branch"
Date: Sun, 08 Nov 2009 14:50:18 -0800
Message-ID: <C71C8B2A.22436%kate@ning.com>
References: <fabb9a1e0911081446o7793eef1kcbad964c9a73edda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 00:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GkG-00054Z-T0
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 00:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbZKHXAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 18:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbZKHXAQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 18:00:16 -0500
Received: from server107g.exghost.com ([69.20.5.112]:2298 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755255AbZKHXAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 18:00:14 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2009 18:00:14 EST
X-Policy: GLOBAL - ning.com
X-Policy: GLOBAL - ning.com
X-Primary: kate@ning.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: kate@ning.com ALLOWED
X-Virus-Scan: V-
X-Note: Spam Tests Failed: 
X-Country-Path: UNITED STATES->UNITED STATES->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 207.97.230.106
X-Note-Reverse-DNS: fe08.exg3.exghost.com
X-Note-WHTLIST: kate@ning.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 120 121 122 123 127 128 139 225 
X-Note: Mail Class: ALLOWEDSENDER
X-Note: Headers Injected
Received: from [207.97.230.106] (HELO FE08.exg3.exghost.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 120981311; Sun, 08 Nov 2009 17:50:27 -0500
Received: from be32.exg3.exghost.com ([207.97.230.171]) by FE08.exg3.exghost.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 8 Nov 2009 17:50:19 -0500
Received: from 207.97.202.210 ([207.97.202.210]) by be32.exg3.exghost.com ([207.97.230.171]) via Exchange Front-End Server exg3.exghost.com ([207.97.230.162]) with Microsoft Exchange Server HTTP-DAV ;
 Sun,  8 Nov 2009 22:50:18 +0000
User-Agent: Microsoft-Entourage/11.4.0.080122
Thread-Topic: Strange behavior (possible bug) using bash command
 subsitution  with "git branch"
Thread-Index: AcpgxdfeFiM5fMy5Ed6LBwAX8g2h+g==
In-Reply-To: <fabb9a1e0911081446o7793eef1kcbad964c9a73edda@mail.gmail.com>
X-OriginalArrivalTime: 08 Nov 2009 22:50:19.0548 (UTC) FILETIME=[D8CAE5C0:01CA60C5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132426>

On 11/8/09 2:46 PM, "Sverre Rabbelier" <srabbelier@gmail.com> wrote:

> Heya
> 
> On Sun, Nov 8, 2009 at 23:11, Kate Ebneter <kate@ning.com> wrote:
>> That is, if you run 'git branch' inside $() or ``, it lists the directories,
>> too. I can't imagine that this is intended behavior, but perhaps I'm wrong.
> 
> Try enclosing it in quotes ;).
> 
> That is, compare:
> $ echo "`git branch`"
> with
> $ echo `git branch`
> 
> The kicker is that there's a * in the output of git branch, which your
> shell helpfully substitutes with the contents of your current
> directory :).

*head desk*

You know, I spent hours last night trying to figure that out. So simple.
Duh.

Thanks for pointing that out -- I knew it had to be something simple, but
sometimes you just can't see the forest for the trees! :-)

Thanks again,
Kate Ebneter
