From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: git log -S doesn't find some commits
Date: Wed, 5 Nov 2008 00:06:42 +0100
Message-ID: <0A948471-7FAA-489A-A86C-D014C6E4C8C9@ai.rug.nl>
References: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:08:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxV0J-0000Df-Qm
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYKDXGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbYKDXGy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:06:54 -0500
Received: from smtp-1.orange.nl ([193.252.22.241]:51503 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbYKDXGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:06:53 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id A2C001C00087;
	Wed,  5 Nov 2008 00:06:51 +0100 (CET)
Received: from [192.168.1.12] (s55918ba6.adsl.wanadoo.nl [85.145.139.166])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id A9A351C00082;
	Wed,  5 Nov 2008 00:06:43 +0100 (CET)
X-ME-UUID: 20081104230647694.A9A351C00082@mwinf6001.online.nl
In-Reply-To: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100114>


On Nov 4, 2008, at 11:59 PM, Bernt Hansen wrote:

>                  o--o--o--o-------------------M--F--o-- .. --o master
>                 /                            /
> A--o-- .. --o--o-------------o--o--B--C--X--D
>
>
> where commits A, B, C, D, and F all modify lines with
> 'org-publish-validate-link'.  M is a merge commit and X has an empty  
> log
> message.
>
> $ git checkout 8ea076e2de2b3721bd813ea5a2df1b53d0c25055 # commit F
> $ git log -Sorg-publish-validate-link

B,C,X and D are not part of 'F', so why should they be included?

You can do something like 'git log -S... F D' to show commits that are  
also in D, or git log --all to show all commits.
