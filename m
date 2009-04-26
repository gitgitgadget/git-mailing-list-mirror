From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 14:00:24 -0400
Message-ID: <49F4A138.6040808@gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain> <49F475B8.20903@gmail.com> <alpine.DEB.1.00.0904261854460.10279@pacific.mpi-cbg.de> <49F49AF0.1020301@gmail.com> <alpine.DEB.1.00.0904261943070.10279@pacific.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:37:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8fy-0001O4-6R
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZDZSA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbZDZSA1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 14:00:27 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:41604 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZDZSA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 14:00:27 -0400
Received: by gxk10 with SMTP id 10so4016238gxk.13
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=POzNzB24WRcnWT7bABV01D8QOmDY3XJrGOjhr6RUhCY=;
        b=qMN5ir7I4tG25Q5mOzfa6uKDDA04w53SdfQD8kRrpSEICiovYU/909eSz3yDweb7QO
         AnDUyfitupNnITD1up0gZDWyplaEFph/yne2yygjPPSE5WaTDtz5Jng5x+gYuannwwTS
         nVLHqe5CV0YFjgu+EuteolazqROhpKI4k1XH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=dm8N3sPbsUaWKNmJvGCMKUOG4G2Sw2KjVGgz1ZHcZt48qbTGkQadaAnbw4TKCFbtNR
         Exveb/c88pyaU0kYmSrKz//dvmcg6dAGHPDMjBjAjrMfpceRs+qepvOF7WQrLc1YOHRR
         XH96dg0ZKAVGDuCjPvJQ9Y5vBBZJf/VGThdbA=
Received: by 10.90.65.14 with SMTP id n14mr5901581aga.29.1240768826133;
        Sun, 26 Apr 2009 11:00:26 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id 32sm7648180aga.44.2009.04.26.11.00.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 11:00:25 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904261943070.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117628>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 26 Apr 2009, A Large Angry SCM wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Sun, 26 Apr 2009, A Large Angry SCM wrote:
>>>
>>>> Another important criteria was which, both or neither of Git and Hg 
>>>> would actually work and perform well on top of Google Code's 
>>>> underling storage system and except to mention they would be using 
>>>> Bigtable, the report did not discuss this. Git on top of Bigtable 
>>>> will not perform well.
>>> Actually, did we not arrive at the conclusion that it could perform 
>>> well at least with the filesystem layer on top of big table, but even 
>>> better if the big tables stored certain chunks (not really all that 
>>> different from the chunks needed for mirror-sync!)?
>>>
>>> Back when I discussed this with a Googler, it was all too obvious that 
>>> they are not interested (and in the meantime I understand why, see my 
>>> other mail).
>> I don't remember the mirror-sync discussion. But I do remember that when 
>> the discussion turned to implementing a filesystem on top of Bigtable 
>> that would not cause performance problems for Git, my response was that 
>> you'd still be much better off going to GFS directly instead of faking a 
>> filesystem on top of Bigtable without all of the Bigtable limitations.
> 
> Umm, GFS is built on top of Bigtable, no?

Other way around.

>> Bigtable _is_ appealing to implement the Git object store on. It's too 
>> bad the latency in Bigtable would make it horribly slow.
> 
> If you store one object per Bigtable, yes.  If you store a few undelta'd 
> objects there, and then use the pack run to optimize those tables, I think 
> it would not be horribly slow.  Of course, you'd need to do exactly the 
> same optimizations necessary for mirror-sync, but I might have mentioned 
> that already ;-)

But now you have to find where you stored those "few undelta'd objects" 
and then go get the object you're interested in. The only way you can 
win with that scheme is if you can find groups of objects that are 
(almost) always accessed together, for all objects (and still not get 
tripped up by the other limitations of Bigtable).

One method would be to group all of the commit objects into one BT entry 
and then create a BT entry for each commit that contains all the trees 
and blobs. This may be fast enough for some operations but would cause 
the storage requirements to explode.
