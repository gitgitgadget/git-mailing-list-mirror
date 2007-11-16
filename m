From: "Elijah Newren" <newren@gmail.com>
Subject: Re: git-cvsimport bug with dates
Date: Fri, 16 Nov 2007 07:12:29 -0700
Message-ID: <51419b2c0711160612r1a80bd5o686040f945e8d9c3@mail.gmail.com>
References: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com>
	 <7vr6iq207f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 15:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It1w7-0002ar-6y
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 15:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbXKPOMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 09:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758019AbXKPOMa
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 09:12:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:48504 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbXKPOM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 09:12:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1006995wah
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uLZIoTeP4NRYe4lOGHa5+mHe4NRB5zX5/7R2ajCd9no=;
        b=mDVMk83nR6ycTlxUrB0sNeNk/SIzTUFkU1J1JxJ+UbmeP4t789E/T7wiTQgDueK6Ni5V9rci4BdygT6I9W/cyBgcfgms2Ri/mJwpQU5kZW9QPOwkVy1C9Jgw6Wj0cPA3G99nRQBobkyxQc/8FtQ4X6btdNr1zy1ti75aiw1kNXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GtBSaq4cDifQqho+Q5puRSJZkBdH/rJTw2RuFfCwIUmD241ZNyfDAZW9vyXrdxjRHoOmJYJvtiEBLwESF0S3aU8jwJRBgkzLADt99Rkz0Dl+cZltGu8fRsmUK9MORA1OoAf+IqnQxW5rYMZAIJgev2BmiXzo8L/G34+rGa2DbqI=
Received: by 10.114.60.19 with SMTP id i19mr422257waa.1195222349343;
        Fri, 16 Nov 2007 06:12:29 -0800 (PST)
Received: by 10.114.211.8 with HTTP; Fri, 16 Nov 2007 06:12:29 -0800 (PST)
In-Reply-To: <7vr6iq207f.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65228>

On Nov 15, 2007 11:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When you use "branch@{date}" notation, you are not asking a
> question on the project history, but a question on the local
> view from _your_ repository on that project.

Interesting; that makes sense from a merge or pull viewpoint, but
wouldn't it make more sense to have cvsimport ensure the commits are
treated as though they actually existed in master as of the date
specified in CVS?

Elijah
