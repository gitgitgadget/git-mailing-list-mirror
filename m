From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS update
Date: Mon, 22 Jan 2007 20:02:29 +1300
Message-ID: <46a038f90701212302v458019fcxcde72a34aa46e7bd@mail.gmail.com>
References: <200701211425.12971.andyparkins@gmail.com>
	 <7vmz4bwzy4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 22 08:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8tCN-0006yD-4F
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 08:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXAVHCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 02:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXAVHCc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 02:02:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:15925 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbXAVHCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 02:02:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1234802nfa
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 23:02:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QYZ7mqQh+hO/RC7x4kPnzuZkab1c2EWKJd0gy0Ec6pVQhOYriuC26bIEtb7M3OD50I4Q0YUZLwTOqRNM7U7DsoARY/naxn1ZJcUjich4WRWPZRXieUHKazuG9OcA8ou8me48gMwGhiwotDpKQPk5BCuOHB+PW/4naTa2BIDp1F8=
Received: by 10.48.162.15 with SMTP id k15mr6153341nfe.1169449349405;
        Sun, 21 Jan 2007 23:02:29 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Sun, 21 Jan 2007 23:02:29 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vmz4bwzy4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37400>

On 1/22/07, Junio C Hamano <junkio@cox.net> wrote:

> > This is in response to Simon Schubert's suggestion that T_ADDED is an
> > inappropriate category for a remotely added file.  Instead this treats
> > remotely added files the same as remotely changed files.
>
> Martin, I think this looks like a sane change.

It does -- sorry I've been offline for a few days and catching up with work.

> I do not have anything other than the real CVS running on a
> Linux box to try this change (most notably I do not do Eclipse
> nor Tortoise) myself and I am reluctant to touch things I cannot
> personally test at this stage near the release.

Fair enough. I'll give it whirl later tonight. For a quick test, you can always

export CVS_SERVER=/home/martin/src/git/git-cvsserver.perl
cvs update

> tested this for his own use in his environment, but I would
> really appreciate a third party Ack from an environment
> different from the originator of the patch.

Yup. Will test later tonight.


martin
