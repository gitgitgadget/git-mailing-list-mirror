From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: error: packfile while git fsck
Date: Wed, 22 Oct 2008 17:22:09 +0200
Organization: atmel
Message-ID: <48FF4521.5070303@atmel.com>
References: <48FF337F.3050505@atmel.com> <alpine.LFD.2.00.0810221049340.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:23:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfYY-0004Sz-R1
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbYJVPWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbYJVPWR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:22:17 -0400
Received: from mail.atmel.fr ([81.80.104.162]:56764 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYJVPWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 11:22:16 -0400
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id m9MFL1I02444;
	Wed, 22 Oct 2008 17:21:01 +0200 (MEST)
Received: from meyreuil ([10.159.254.132]) by fwat; Wed, 22 Oct 2008 17:19:35 +0200 (MEST)
Received: from [127.0.0.1] (pc245_112.atmel.fr [10.159.245.112])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id m9MFM7b17437;
	Wed, 22 Oct 2008 17:22:08 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <alpine.LFD.2.00.0810221049340.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98879>

Nicolas Pitre :
> On Wed, 22 Oct 2008, Nicolas Ferre wrote:
> 
>> Hi all,
>> (please cc me on response)
>>
>> I am facing error during git status & git fsck on my tree.
>> This tree is cloned from various linux kernel trees.
>>
>> Here are a sample of the error I see :
>>
>> $ git fsck
>> error: packfile
>> .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not
>> match index
>> error: packfile
>> .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be
>> accessed
> [...]
> 
> What git version?

$ git --version
git version 1.5.3.7

Kind regards,
-- 
Nicolas Ferre
