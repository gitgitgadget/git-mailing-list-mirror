From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git sideband hook output
Date: Wed, 09 Jun 2010 08:10:47 +0200
Message-ID: <4C0F3067.9090501@viscovery.net>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 08:12:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMEWV-0002fg-AD
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 08:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab0FIGKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 02:10:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13979 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751268Ab0FIGKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 02:10:50 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OMEUy-0005RK-19; Wed, 09 Jun 2010 08:10:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8DA041660F;
	Wed,  9 Jun 2010 08:10:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148742>

Am 6/8/2010 22:32, schrieb Scott Chacon:
> Prior to 6d525d where Shawn made the receive-pack process send hook
> output over side band #2, how did the hook output get sent to the
> client?  On older clients (before this commit) and on older servers,
> the hook output just shows up without the 'remote:' prefix.  After
> this commit I get the 'remote:' prefix, which is kind of annoying.  Is
> there a way to suppress this to get the old output format?  Or a
> recommended way of patching the client/server in future versions to
> get the old format back?

What happens if your git-receive-pack does not announce side-band-64k?

-- Hannes
