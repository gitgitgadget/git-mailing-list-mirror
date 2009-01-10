From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Sat, 10 Jan 2009 17:01:11 +0100
Message-ID: <9CECD102-6D3E-487D-BA1E-C0269D055965@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de> <1231595452-27698-3-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 17:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgIf-0004kS-2f
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbZAJQBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbZAJQBe
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:01:34 -0500
Received: from mailer.zib.de ([130.73.108.11]:61334 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbZAJQBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:01:33 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0AG1Ho7008400;
	Sat, 10 Jan 2009 17:01:23 +0100 (CET)
Received: from [192.168.178.21] (brln-4db952c9.pool.einsundeins.de [77.185.82.201])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0AG1HRd014742
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 10 Jan 2009 17:01:17 +0100 (MET)
In-Reply-To: <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105124>


On Jan 10, 2009, at 3:34 PM, Johannes Schindelin wrote:

> Logically, and to avoid committing a broken revision, 1/6 should come
> last, methinks.

RUNTIME_PREFIX is not defined before 6/6. But I agree,
1/6 should probably be moved after 5/6.

	Steffen
