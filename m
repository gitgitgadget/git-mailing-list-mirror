From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Anyone running GIT on native Windows
Date: Wed, 09 May 2007 09:08:01 +0200
Organization: eudaptics software gmbh
Message-ID: <46417351.6BBA9313@eudaptics.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed May 09 09:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlgHG-0003lN-7q
	for gcvg-git@gmane.org; Wed, 09 May 2007 09:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967964AbXEIHHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 03:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967970AbXEIHHx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 03:07:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56648 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967964AbXEIHHw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 03:07:52 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HlgH7-0007vV-AT; Wed, 09 May 2007 09:07:49 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 127396D9; Wed,  9 May 2007 09:07:49 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.038
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46672>

Han-Wen Nienhuys wrote:
> I packaged Mingw GIT using NSIS some time ago; see
> 
>   http://lilypond.org/git/binaries/mingw/
> 
> Due various personal reasons, I haven't been able to update this, but I
> will package a new version soon. Please try it to see whether there are
> any rough edges.

I've tried this shortly after you released it. But it did not work as
expected. The symtom was (IIRC) that a simple

   git init

said that 'init' is not a git-command. I tried this from CMD, not rxvt.

There are meanwhile a number of improvements in the port that support
relocation (i.e. an arbitrary installation directory). Could you please
package the latest version from the 'devel' branch?

  git://repo.or.cz/git/mingw.git

-- Hannes
