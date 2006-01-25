From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: StGIT: defaults for authname, authemail
Date: Wed, 25 Jan 2006 13:39:34 +0000
Message-ID: <tnxzmlk1l61.fsf@arm.com>
References: <200601242213.36996.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 14:40:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1ksP-0006i5-JI
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 14:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWAYNjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 08:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWAYNjx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 08:39:53 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:9971 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750924AbWAYNjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 08:39:52 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k0PDde6s012198;
	Wed, 25 Jan 2006 13:39:40 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 25 Jan 2006 13:39:40 +0000
To: Andrey Borzenkov <arvidjaar@mail.ru>
In-Reply-To: <200601242213.36996.arvidjaar@mail.ru> (Andrey Borzenkov's
 message of "Tue, 24 Jan 2006 22:13:36 +0300")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 25 Jan 2006 13:39:40.0248 (UTC) FILETIME=[CA898D80:01C621B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15131>

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> Would be nice if StGIT honored GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL if they are 
> set and took them as default. Would be more plug'n'play, I was rather 
> surprised why stg export gave me From: <>.

Indeed, that's a bug. The GIT commit is properly created since GIT
will use the environment but the export and mail commands are not
aware of this (they only use the ~/.stgitrc or .git/stgitrc files).

Thanks for pointing out.

-- 
Catalin
