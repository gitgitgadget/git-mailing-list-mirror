From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: problem with plain git clone
Date: Wed, 3 May 2006 10:46:18 -0500
Message-ID: <7814FB77-0073-40F3-BF1C-E2C7CEC7412D@kernel.crashing.org>
References: <7CAB7A96-2C63-4B05-B0C6-72FC5B74D960@kernel.crashing.org> <20060503143130.GA9172@spearce.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 17:46:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbJYZ-0001hS-Od
	for gcvg-git@gmane.org; Wed, 03 May 2006 17:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWECPqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 11:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWECPqY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 11:46:24 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:38174 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S965229AbWECPqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 11:46:23 -0400
Received: from [140.242.26.81] (helo=[172.26.64.92])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.52)
	id 1FbJYR-0003Ji-Oq; Wed, 03 May 2006 10:46:20 -0500
In-Reply-To: <20060503143130.GA9172@spearce.org>
To: Shawn Pearce <spearce@spearce.org>
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19494>


On May 3, 2006, at 9:31 AM, Shawn Pearce wrote:

> Kumar Gala <galak@kernel.crashing.org> wrote:
>> Anyone see an issues like the following:
>>
>> [kgala@kgala_lnx z]$ git clone git://git.kernel.org:/pub/scm/boot/u-
>> boot/galak/u-boot.git
>> git clone git://git.kernel.org:/pub/scm/boot/u-boot/galak/u-boot.git
>> fatal: unable to connect a socket (Connection timed out)
>
> There's no GIT daemon running on the empty port.  Notice the ':'
> appearing right after '.org'.
>
> Hmm, that sounds like a bug in the protocol URL parser...

Yeah, that was it. thanks.

- kumar
