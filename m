From: Pieter de Bie <pieter@frim.nl>
Subject: Re: Strange branch merging.
Date: Thu, 12 Feb 2009 12:42:47 +0000
Message-ID: <FADBCA93-6742-43E8-A4A6-0090FBFF8BAB@frim.nl>
References: <49940D93.6000204@movency.com> <E65A809A-65AD-4755-8AA7-32AA11C9AB5A@frim.nl> <499418A4.9060401@movency.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Panayis <adam@movency.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXawZ-0002MD-CD
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 13:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760101AbZBLMm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760095AbZBLMm6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:42:58 -0500
Received: from frim.nl ([87.230.85.232]:32786 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760088AbZBLMm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 07:42:57 -0500
Received: from cpat002.wlan.net.ed.ac.uk ([129.215.5.254] helo=[172.20.196.2])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1LXau6-0003hf-H3; Thu, 12 Feb 2009 13:42:54 +0100
In-Reply-To: <499418A4.9060401@movency.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109611>

Hey,

[ Please don't top-post here, it makes following the discussion harder ]

On Feb 12, 2009, at 12:40 PM, Adam Panayis wrote:
> When I try to do that on box B I get the master branch from box A  
> but I get the changes made to branch blah on box A.
>
> I do not understand why, on box B, the master branch is showing  
> changes made to the blah branch on box A. (Yet on box A the changes  
> to the blah branch are not shown in the master)

You probably pulled in the 'blah' branch rather than the 'master'  
branch because that was
the branch that is checked out on box A. You can verify this by  
looking at 'git log' and
see that the commit on the blah branch is also there. To pull the  
master branch, specify
it explicitly, like this:

	git pull boxA:path/to/repo master

- Pieter
