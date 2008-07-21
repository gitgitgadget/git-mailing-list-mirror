From: Jonathan Biolaz <jonathan.biolaz@sikatizen.com>
Subject: Re: error: hook declined to update refs/heads/master
Date: Mon, 21 Jul 2008 13:33:39 +0200
Message-ID: <33E8E17B-D34A-4035-945A-CDB8A786A975@sikatizen.com>
References: <80F1AC38-8A10-4184-BBFB-870399DE9A3A@sikatizen.com> <alpine.DEB.1.00.0807211153340.3305@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:34:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKtfD-0003Ne-Ae
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYGULds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 07:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYGULdr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 07:33:47 -0400
Received: from 42.mail-out.ovh.net ([213.251.189.42]:54450 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750719AbYGULdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 07:33:47 -0400
Received: (qmail 30166 invoked by uid 503); 21 Jul 2008 11:33:33 -0000
Received: from gw2.ovh.net (HELO mail22.ha.ovh.net) (213.251.189.202)
  by 42.mail-out.ovh.net with SMTP; 21 Jul 2008 11:33:33 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 21 Jul 2008 11:33:37 -0000
Received: from cust.static.84-253-35-196.cybernet.ch (HELO migiwork.sikalab) (jonathan.biolaz@sikatizen.com@84.253.35.196)
  by ns0.ovh.net with SMTP; 21 Jul 2008 11:33:36 -0000
In-Reply-To: <alpine.DEB.1.00.0807211153340.3305@eeepc-johanness>
X-Mailer: Apple Mail (2.928.1)
X-Ovh-Tracer-Id: 8362903035002397150
X-Ovh-Remote: 84.253.35.196 (cust.static.84-253-35-196.cybernet.ch)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89349>



> Hi,
>
> On Mon, 21 Jul 2008, Jonathan Biolaz wrote:
>
>> $ git push origin master
>>
>> Counting objects: 1709, done.
>> Compressing objects: 100% (1523/1523), done.
>> Writing objects: 100% (1709/1709), 1.95 MiB | 3818 KiB/s, done.
>> Total 1709 (delta 535), reused 0 (delta 0)
>> *** Project description file hasn't been set
>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>> error: hooks/update exited with error code 1
>> error: hook declined to update refs/heads/master
>
> Apparently, you have a hook installed on the remote side which  
> checks for
> a valid description, and refuses even updating refs before you set the
> description correctly.

Ok.
So, what's a hook ? and how I set the description ??

Thanks
