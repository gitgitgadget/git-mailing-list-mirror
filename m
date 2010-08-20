From: Thomas Jampen <jampen@kinet.ch>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 23:21:02 +0200
Organization: Gymnasium Kirchenfeld - Informatikdienste
Message-ID: <4C6EF1BE.6040603@kinet.ch>
References: <4C6E46A4.8050502@kinet.ch> <20100820125119.GA9762@burratino> <alpine.LFD.2.00.1008201327120.622@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Aug 20 23:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmZ1W-0001gp-2U
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 23:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab0HTVVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 17:21:08 -0400
Received: from hermes.gymkirchenfeld.ch ([86.118.137.202]:56562 "EHLO
	hermes.gymkirchenfeld.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0HTVVI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 17:21:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTP id 4C7238C42E6;
	Fri, 20 Aug 2010 23:21:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at hermes.gymkirchenfeld.ch
Received: from hermes.gymkirchenfeld.ch ([127.0.0.1])
	by localhost (hermes.gymkirchenfeld.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b29sKLTKibz1; Fri, 20 Aug 2010 23:21:03 +0200 (CEST)
Received: from [192.168.2.10] (212-41-91-206.adsl.solnet.ch [212.41.91.206])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTPSA id 6352A8C4089;
	Fri, 20 Aug 2010 23:21:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2 ThunderBrowse/3.3.2
In-Reply-To: <alpine.LFD.2.00.1008201327120.622@xanadu.home>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154083>



On 20.08.2010 22:59, Nicolas Pitre wrote:
> On Fri, 20 Aug 2010, Jonathan Nieder wrote:
> 
>> (+cc: Nicolas, who knows the packing code pretty well)
>>
>> Hi,
>>
>> Thomas Jampen wrote:
>>
>>> I'm experiencing the following error while pushing a git repo (home
>>> directory) to my QNAP TS-210:
>>>
>>> user@mypc:~$ git push origin master
>>> Counting objects: 12532, done.
>>> Delta compression using up to 2 threads.
>>> Compressing objects: 100% (8974/8974), done.
>>> fatal: Out of memory, malloc failed, 986.06 MiB | 1.65 MiB/s
>>> error: pack-objects died of signal 13
> 
> How much memory is there on the machine where the pushed data is going?

My NAS has 256MB RAM. While the push is running, there is between
20-50MB RAM available according to MemFree reported by 'head
/proc/meminfo'. The harddrive space should not be an issue, its about 2TB.
