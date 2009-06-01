From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 03/11 v2] Work around a regression in Windows 7, causing erase_in_line() to crash sometimes
Date: Mon, 1 Jun 2009 12:26:29 +0200
Message-ID: <B70B2E5A-970F-4FB1-A109-84EE199A15DF@zib.de>
References: <4A22C674.603@kdbg.org> <1243836256-11958-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0906011025080.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB4jX-0007Yo-O5
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 12:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbZFAK07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 06:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbZFAK06
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 06:26:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:51910 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121AbZFAK05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 06:26:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n51AQZg6026478;
	Mon, 1 Jun 2009 12:26:54 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db93cad.pool.einsundeins.de [77.185.60.173])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n51AQYqQ015136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 1 Jun 2009 12:26:34 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0906011025080.26154@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120456>


On Jun 1, 2009, at 10:25 AM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 1 Jun 2009, Steffen Prohaska wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> The function FillConsoleOutputCharacterA() was pretty content in XP  
>> to take a NULL
>> pointer if we did not want to store the number of written columns.   
>> In Windows 7,
>> it crashes, but only when called from within Git Bash, not from  
>> within cmd.exe.
>> Go figure.
>
> Did I really have too-long lines in my commit message?


Yes.  See aa3abfc9852a4d4cfaa7f0042102eb56ed2e0daa on 4msysgit's devel.
You are author and committer.

	Steffen
