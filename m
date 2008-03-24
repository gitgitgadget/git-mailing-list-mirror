From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: filter-branch --all?
Date: Mon, 24 Mar 2008 22:44:39 +0100
Message-ID: <8845199E-BDBE-4CFB-8E74-DCF36D1CC9EB@orakel.ntnu.no>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site> <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site> <263C0D8D-0454-402A-B65C-08E91F7BD5C7@orakel.ntnu.no> <47E81E0C.8050609@nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:45:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JduTt-0005Hf-98
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 22:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYCXVop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 17:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbYCXVop
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 17:44:45 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:62008 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbYCXVoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 17:44:44 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id A32F0147AEB;
	Mon, 24 Mar 2008 22:44:40 +0100 (CET)
In-Reply-To: <47E81E0C.8050609@nrlssc.navy.mil>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78104>

On 24. mars. 2008, at 22.33, Brandon Casey wrote:
> Try
>
>    git filter-branch -- --all
>
> It is actually an option to rev-parse.

That works!  Thanks.

I managed to figure out that "--all" is a rev-parse option, but it  
never occurred to me to protect it with a "--".
-- 
Eyvind Bernhardsen
