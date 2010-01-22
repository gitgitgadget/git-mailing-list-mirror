From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Fri, 22 Jan 2010 09:43:05 +0100
Message-ID: <4B596519.8060508@viscovery.net>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain> <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211811140.13231@localhost.localdomain> <alpine.LFD.2.00.1001211823590.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 09:43:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYF6n-0001kp-3f
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 09:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab0AVInJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 03:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339Ab0AVInJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 03:43:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45850 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0AVInI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 03:43:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NYF6g-0007Vo-GW; Fri, 22 Jan 2010 09:43:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3BB731660F;
	Fri, 22 Jan 2010 09:43:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.00.1001211823590.13231@localhost.localdomain>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137748>

Linus Torvalds schrieb:
> @@ -347,8 +347,6 @@ int main(int argc, char **argv)
>  
>  	git_extract_argv0_path(argv[0]);

This line must go away as well.

> -	setup_git_directory();
> -

-- Hannes
