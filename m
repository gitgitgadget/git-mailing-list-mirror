From: nadim khemir <nadim@khemir.net>
Subject: Re: Git Books
Date: Sat, 6 Dec 2008 15:38:17 +0100
Message-ID: <200812061538.17700.nadim@khemir.net>
References: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com> <m34p1hihx4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 15:38:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8yIa-0001oI-0N
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 15:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487AbYLFOhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 09:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758266AbYLFOhH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 09:37:07 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:35405 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756487AbYLFOhG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2008 09:37:06 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id E0B92940137
	for <git@vger.kernel.org>; Sat,  6 Dec 2008 15:37:03 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 8181E12640A7
	for <git@vger.kernel.org>; Sat,  6 Dec 2008 15:37:03 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <m34p1hihx4.fsf@localhost.localdomain>
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102458>

On Saturday 06 December 2008 13.54.06 Jakub Narebski wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
> > I have been talked into helping write a real, paper-based book on Git
> > ...
>
> What I really would like to see in a paper book is _diagrams_, in the
> form of simple graphs (and not UML-like diagrams, of flow-control like
> diagrams).

I was thinking about buying the pdf below. The little I can see looks like 
there are a bunch of diagrams in it.

http://peepcode.com/products/git-internals-pdf

> You can find them in various slides for presentations 
> (among others Junio's talks), and sometimes in blog posts[1], but
> usually only as ASCII-diagrams[2] in git documentation.  (And the
> examples in"The Git Comminity Book" I've seen so far are a bit too
> complicated).

I like doing my ASCII-diagrams with Asciio, unsurprizingly.


                                         ********
                                         * HEAD *
                                         ********
                                             |
                                             v
                           .-----.      .--------.
                           | tag |      | branch |
                           '-----'      '--------'
                              |              |
                              v              v
..........               ..........     ..........
. commit .<--------------. commit .<----. commit .
..........               ..........     ..........
     |                        |              |
     v                        v              v
 .------.                 .------.       .------.
 | tree |--------.--------| tree |       | tree |
 '------'        |        '------'       '------'
     |           v            |              |
     v       .------.         v              v
 .------.    | blob |     .------.       .------.
 | tree |--. '------'  .--| tree |       | blob |
 '------'  |           |  '------'       '------'
           '-----.-----'      |
                 |            v
                 v        .------.
             .------.     | tree |
             | blob |     '------'
             '------'         |
                              v
                          .------.
                          | blob |
                          '------'

cheers, Nadim.
