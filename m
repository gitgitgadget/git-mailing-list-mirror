From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Sun, 11 Jan 2009 11:04:23 +0100
Message-ID: <E976B246-AD14-4B03-B204-F6A1014071DF@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de> <1231595452-27698-3-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de> <9CECD102-6D3E-487D-BA1E-C0269D055965@zib.de> <7viqomx5iq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 11:06:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxDA-0006X1-5n
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbZAKKFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZAKKFH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:05:07 -0500
Received: from mailer.zib.de ([130.73.108.11]:62060 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbZAKKFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:05:06 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0BA4Xt1018631;
	Sun, 11 Jan 2009 11:04:38 +0100 (CET)
Received: from [192.168.178.21] (brln-4db930b5.pool.einsundeins.de [77.185.48.181])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0BA4SL0019852
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Jan 2009 11:04:32 +0100 (MET)
In-Reply-To: <7viqomx5iq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105158>


On Jan 10, 2009, at 9:36 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Jan 10, 2009, at 3:34 PM, Johannes Schindelin wrote:
>>
>>> Logically, and to avoid committing a broken revision, 1/6 should  
>>> come
>>> last, methinks.
>>
>> RUNTIME_PREFIX is not defined before 6/6. But I agree,
>> 1/6 should probably be moved after 5/6.
>>
> Hmm, I actually was thinking about applying that (and that one only)  
> early
> to my tree, to make sure it is regression-free.

Does "early" mean that you want to wait and see how the discussion
about the other patches evolves before you consider applying them,
or does "and that one only" mean that you tend to not apply the
other patches at all?

	Steffen
