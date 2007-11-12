From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: cogito remote branch
Date: Mon, 12 Nov 2007 09:00:50 +0100
Message-ID: <1IrUDz-01jF4a0@fwd29.aul.t-online.de>
References: <Pine.LNX.4.64.0711111359590.9401@castor.milkiway.cos>
 <Pine.LNX.4.64.0711111520260.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrUEZ-00024q-GS
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 09:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbXKLIBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 03:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbXKLIBL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 03:01:11 -0500
Received: from mailout08.sul.t-online.de ([194.25.134.20]:45730 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754421AbXKLIBK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 03:01:10 -0500
Received: from fwd29.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1IrUEH-0000kx-00; Mon, 12 Nov 2007 09:01:09 +0100
Received: from localhost (Xd2DtoZCYhxi9Fyr1vXDh9qGa5kfG3EbWG2Ti74JrykCp7J2g9PtlFw18plrDEAg9a@[172.20.101.250]) by fwd29.aul.t-online.de
	with esmtp id 1IrUDz-01jF4a0; Mon, 12 Nov 2007 09:00:51 +0100
In-Reply-To: <Pine.LNX.4.64.0711111520260.4362@racer.site>
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-0-8
X-ID: Xd2DtoZCYhxi9Fyr1vXDh9qGa5kfG3EbWG2Ti74JrykCp7J2g9PtlFw18plrDEAg9a@t-dialin.net
X-TOI-MSGID: 4a5b04ff-2a5d-4213-ae56-8cda36e764ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64572>


(I forgot to put the subject previously)

> Johannes Schindelin wrote:
>Hi,

>On Sun, 11 Nov 2007, Michael Dressel wrote:

>> 
>> >Michael Dressel wrote:
>> >Ok nice. Another thing is that git-push will push all the tracking 
>> >branches in refs/remotes/origin. 
>> 
>> I learned that I only have to edit the .git/config file to avoid that

>> git-push pushes everything. 

>It is documented that you can use "git push origin ".

>> [remote "origin1"]
>>         url = /home/repo/src
>>         fetch = +refs/heads/master:refs/remotes/origin/master
>>         push = +refs/heads/master:refs/heads/master

>With "push", it is not necessary to specify the ":".
So just a line like
             push = master

A push is needed somewhere in order to prevent every remote to be pushed
by default,
right?

>Also, if "master" is unambiguous, you can write just "master" instead
of 
>"refs/heads/master".

>Furthermore, I suggest not forcing (that's  what "+" does) the push,
since 
>it is quite possible that you push something old in the wrong
direction.  

O.k. I will reconsider this.

Cheers,
Michael
