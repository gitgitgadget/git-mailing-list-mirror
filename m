From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any
 time
Date: Wed, 2 Dec 2009 11:04:17 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0912021053040.27454@tvnag.unkk.fr>
References: <25718488.post@talk.nabble.com>  <20091127234110.7b7e9993.rctay89@gmail.com>  <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>  <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>  <20091201161428.GC21299@spearce.org> 
 <alpine.DEB.2.00.0912011914270.30348@tvnag.unkk.fr> <be6fef0d0912011803u2ec9ab1bsa167cf59de4dd47c@mail.gmail.com> <alpine.DEB.2.00.0912021011430.19179@tvnag.unkk.fr> <alpine.DEB.2.00.0912021130300.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1470944514-1530367627-1259748258=:27454"
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:04:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFm4f-0004DF-1O
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbZLBKEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbZLBKEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:04:16 -0500
Received: from giant.haxx.se ([83.168.254.42]:44448 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbZLBKEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:04:15 -0500
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id nB2A4HiU026028;
	Wed, 2 Dec 2009 11:04:17 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <alpine.DEB.2.00.0912021130300.5582@cone.home.martin.st>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134321>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1470944514-1530367627-1259748258=:27454
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 2 Dec 2009, Martin Storsjö wrote:

>> Thinking about this particular problem, what is the motivation for git to 
>> forcily add that header in the first place? I mean, libcurl does add the 
>> header by itself when it thinks it is necessary and then it handles it 
>> correctly.
>
> As far as I saw, the reason for it being manually added is that curl 
> actually didn't add it automatically in that case. That was the reason for 
> the second patch/rfc thread that I sent to curl-library (where postsize == 
> 0, as in unknown, didn't trigger the addition of any Expect header).

Ah right, thanks for the clarification. An unfortunate combination then... :-(

-- 

  / daniel.haxx.se
---1470944514-1530367627-1259748258=:27454--
