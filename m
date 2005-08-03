From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Email patch -> git commit?
Date: Wed, 03 Aug 2005 09:47:47 +0100
Message-ID: <tnx64unjtjg.fsf@arm.com>
References: <42EFF077.6080606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 10:50:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0EwQ-00024v-QG
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 10:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVHCIsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 04:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVHCIsm
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 04:48:42 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:20185 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262151AbVHCIse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 04:48:34 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j738les4027252;
	Wed, 3 Aug 2005 09:47:40 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA19341;
	Wed, 3 Aug 2005 09:48:20 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 3 Aug 2005 09:48:19 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42EFF077.6080606@zytor.com> (H. Peter Anvin's message of "Tue,
 02 Aug 2005 15:15:19 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 03 Aug 2005 08:48:19.0485 (UTC) FILETIME=[18E68CD0:01C59808]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Anyone have any good scripts for taking patches in email and turning
> them into git commits, preferrably while preserving the author
> information?

StGIT can do this as well, via the 'stg import -m' command. You will
see it as a GIT commit (with 'git log') as well as an StGIT patch. It
preserves the author information taken from the From: line (can be
overwritten with command line options).

-- 
Catalin
