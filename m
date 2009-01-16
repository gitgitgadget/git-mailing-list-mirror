From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Fri, 16 Jan 2009 15:28:25 +0100
Message-ID: <22A54F3C-DC15-4589-B796-D0E7032EC515@wincent.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <200901161050.13971.johan@herland.net> <49548.bFoQE3daRhY=.1232101666.squirrel@webmail.hotelhot.dk> <200901161158.06828.johan@herland.net> <20090116124239.GA28870@neumann> <alpine.DEB.1.00.0901161357230.3586@pacific.mpi-cbg.de> <20090116132714.GN9794@neumann>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 15:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNpiC-0008JU-6r
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 15:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934477AbZAPO2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 09:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936125AbZAPO2q
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 09:28:46 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:44544 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936445AbZAPO2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 09:28:45 -0500
Received: from cuzco.lan (249.pool85-53-13.dynamic.orange.es [85.53.13.249])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0GESPcu007446
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 16 Jan 2009 09:28:27 -0500
In-Reply-To: <20090116132714.GN9794@neumann>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105963>

El 16/1/2009, a las 14:27, SZEDER G=E1bor escribi=F3:

> On Fri, Jan 16, 2009 at 01:57:57PM +0100, Johannes Schindelin wrote:
>> Hi,
>>
>> On Fri, 16 Jan 2009, SZEDER G=E1bor wrote:
>>
>>> On Fri, Jan 16, 2009 at 11:58:06AM +0100, Johan Herland wrote:
>>>
>>>> "rephrase"?
>>>
>>> This is the first one that I found acceptable.
>>
>> I assume you missed
>> http://article.gmane.org/gmane.comp.version-control.git/105783 in =20
>> all that
>> bikeshedding?
>
> Yes, I indeed missed that.  And still think that 'rephrase' is best
> among all the suggestions for this "edit just the commit message"
> thing.  ('editmsg' conflicts; 'amend', 'modify', and  'correct' are
> not obvious enough (they don't clearly indicate what will be
> modified); and I'm not sure about 'redact', but I don't really like i=
t
> because I had to look it up in the dictionary first).

Two more colors for consideration:

   - "msg"/"msgedit"/"message" or similar
   - "reword"

I agree with G=E1bor that options like "modify" aren't clear because =20
there's nothing in them that suggests that they're intended to operate =
=20
on the commit _message_.

Wincent
