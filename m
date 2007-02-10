From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 17:35:44 +0100
Message-ID: <e5bfff550702100835x6d5c0d40y42b3fe0f50f78fd7@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vveiaj7y5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFvCX-0003vw-Ty
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXBJQfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXBJQfq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:35:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:54137 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbXBJQfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:35:45 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1224881wri
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 08:35:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UxJFddjvJrd2oMYHaodZSULGylKBCsTcV0JAtlchmnz+N+IJtZoenPlVevW0OnhXZhqu+7Wqu8+BAi/VZK92zLv6O7dSaOxvD7R1IScvSi4q9CJnqjmcFWzEoiJKvgm0L/+CduyHUSldINbNGgNoDa5pcPLHLpCeO0hL/Op13yw=
Received: by 10.114.198.1 with SMTP id v1mr5403357waf.1171125344646;
        Sat, 10 Feb 2007 08:35:44 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 08:35:44 -0800 (PST)
In-Reply-To: <7vveiaj7y5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39239>

On 2/10/07, Junio C Hamano <junkio@cox.net> wrote:
>
> But when they ask "git status", they care more about the real
> change, and at that point (since they feel they may be ready to
> make a commit -- and that is the whole point of running
> "git-status") they do want to lose the cache cleanliness
> information.  So "git-status" to be read-write application to
> discard the cache-cleanliness information is probably a good
> thing.
>

The "let's see what I'm going to commit today" it's definitely the way
I and probably most of qgit users look at the status info shown in
main view left bottom pane and also in commit dialog.
