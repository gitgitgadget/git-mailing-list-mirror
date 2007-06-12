From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-fetch, was Re: [PATCH] Port git-tag.sh to C.
Date: Tue, 12 Jun 2007 14:29:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706121427410.18585@reaper.quantumfyre.co.uk>
References: <11813427591137-git-send-email-krh@redhat.com>
 <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
 <Pine.LNX.4.64.0706112314300.5848@iabervon.org> <Pine.LNX.4.64.0706121341250.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Carlos Rica <jasampler@gmail.com>,
	=?X-UNKNOWN?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 15:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy6RB-0001HK-Dl
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 15:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbXFLN3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 09:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbXFLN3Y
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 09:29:24 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:39110 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754828AbXFLN3X (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 09:29:23 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 99D4CB9BB2
	for <git@vger.kernel.org>; Tue, 12 Jun 2007 14:29:21 +0100 (BST)
Received: (qmail 24064 invoked by uid 103); 12 Jun 2007 14:26:17 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3405. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036381 secs); 12 Jun 2007 13:26:17 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 12 Jun 2007 14:26:17 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0706121341250.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49959>

On Tue, 12 Jun 2007, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 11 Jun 2007, Daniel Barkalow wrote:
>
>> On Sat, 9 Jun 2007, Carlos Rica wrote:
>>
>>> Feel free to choose the script which you need to get replaced first,
>>> or, depending on your urgency, you could ask me for one of them and I
>>> would try to concentrate my efforts on it. Why do you started with
>>> git-tag? For me, it was enough easy to begin with, perhaps you could
>>> have other reasons.
>>
>> Incidentally, I have been working on fetch, based on Julian Phillips's
>> version. I'm trying to split out the "how do I communicate with remote
>> repositories" code, and use it for pushing and ls-remote as well as
>> fetch. I've got a bunch of not-for-official-history development that you
>> should look at if you try any of the remote-repository-access scripts.
>
> How about pushing them onto repo.or.cz as a fork of git.git?

I'd quite like to see these changes too - since I haven't finished the 
fetch work yet, and I don't want to duplicate effort ;)

(It seems that the closer I get to a working fetch the less time I spend 
on it ... :$)

-- 
Julian

  ---
    Old robot: I choose to believe what I was programmed to believe.
