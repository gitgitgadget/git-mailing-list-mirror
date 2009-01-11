From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Sun, 11 Jan 2009 13:57:59 +0100
Message-ID: <C817EA53-5326-4C60-B781-41B90514F3A7@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de> <1231595452-27698-3-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de> <9CECD102-6D3E-487D-BA1E-C0269D055965@zib.de> <7viqomx5iq.fsf@gitster.siamese.dyndns.org> <E976B246-AD14-4B03-B204-F6A1014071DF@zib.de> <7v1vvata6o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 14:00:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLzv3-0005L8-QA
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 13:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbZAKM63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 07:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbZAKM63
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 07:58:29 -0500
Received: from mailer.zib.de ([130.73.108.11]:48485 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbZAKM62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 07:58:28 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0BCw6fI002577;
	Sun, 11 Jan 2009 13:58:11 +0100 (CET)
Received: from [192.168.178.21] (brln-4db930b5.pool.einsundeins.de [77.185.48.181])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0BCw5pp024735
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Jan 2009 13:58:05 +0100 (MET)
In-Reply-To: <7v1vvata6o.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105174>


On Jan 11, 2009, at 11:21 AM, Junio C Hamano wrote:

> My initial impression after reading 1/6 was that no matter how the  
> actual
> runtime prefix detection logic that is implemented in the later  
> parts of
> the series for particular platform will turn out to be, the update  
> to the
> Makefile that is done by 1/6 won't have to change.  If I apply 1/6  
> first
> without applying anything else, we can make sure that it would not  
> regress
> for Unix people (and catch regressions early if any), while Windows  
> people
> polish the platform specific parts of the implementation in the later
> parts of the series that can be replaced.
>
> Because changes to Makefile variables tend to have unexpected side  
> effects
> (people have their own definition to override them in their build
> procedures and you can easily break them unless you are careful), I  
> wanted
> to make sure the common part is solid before waiting for the other  
> part.
>
> But if you think it is better not to apply any one, until other parts
> mature, it is Ok by me, too.

I think you should apply it.

	Steffen
