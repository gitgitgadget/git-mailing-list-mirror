From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 21:53:12 +0300
Message-ID: <20160114215312.255f26416bb93beb2e18f1f2@domain007.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
	<20160114213113.c700484c7e3acddc467d0e75@domain007.com>
	<CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pedro rijo <pedrorijo91@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:53:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJn1P-0005f5-MN
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbcANSxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:53:17 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:57337 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbcANSxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:53:15 -0500
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id u0EIrCPO028290;
	Thu, 14 Jan 2016 21:53:13 +0300
In-Reply-To: <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284081>

On Thu, 14 Jan 2016 18:40:15 +0000
pedro rijo <pedrorijo91@gmail.com> wrote:

> Stefan Beller solution is based on the server, which may not be very
> easy to do when dealing with Github/Bitbucket/Gitlab and other God
> knows which provider.
> 
> Konstantin ls-remote solution is the one I'm already using, but if I
> have several branches on that commit, I will not be able to decide.
> 
> I thought that the 'main' branch information was stored in git, and
> possibly with some way to access it with a git command

It *is* stored in the Git repository -- in the HEAD ref.
The question of how to retreive precisely this bit of information --
I don't really know.  Basically you want `git show-remote-ref --head`
but Git does not have such a command, only `git show-ref` ;-)
