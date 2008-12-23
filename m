From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Question with git push
Date: Tue, 23 Dec 2008 12:35:50 -0500
Message-ID: <eaa105840812230935o63ac7960h728c905da12b8cc0@mail.gmail.com>
References: <5591393c0812230859n3b50b1f9k36153f40dd75ff57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Vincent Craven" <paul@cravenfamily.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:37:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBBu-0000oa-T6
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 18:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYLWRfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 12:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYLWRfw
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 12:35:52 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:34801 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYLWRfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 12:35:52 -0500
Received: by an-out-0708.google.com with SMTP id d40so868138and.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=kJsu/k+z6ADEzq8BPfq30Rkpl7JUGb5IF/F55BhhdVc=;
        b=i6v5rvaGcto5MBGL7KQem0PX66aKrLhyJgyHm+gMD0yTpgkCW/8izQqxp51qCxO/Ks
         alETICvRhcLgMJ6i2ZnYrj6q0nzP4GupT08JDW6DFj+FzR7i0Uzs4mMDnhhg8WXlKskX
         xXnD8EavN6sZ1MWU5na70z5NK4r5ixdy0/Zps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=j70px7/ex+YQfP3TYum8emMRmA8TvAKCNp6OG9fiIBqbjELYoCfFhJkFXKD9pMaPBC
         v1PiBaZkVc3i3YpGI6CVGUHsvIv8iFaO9y5wCLO1qDaQFMS+Lpf2TTxAvZbs4HpSHLhl
         64Ammp1uSehxp8hLkU/tg6qF8IIl8ewWXajyU=
Received: by 10.64.181.19 with SMTP id d19mr6153195qbf.24.1230053750905;
        Tue, 23 Dec 2008 09:35:50 -0800 (PST)
Received: by 10.65.214.7 with HTTP; Tue, 23 Dec 2008 09:35:50 -0800 (PST)
In-Reply-To: <5591393c0812230859n3b50b1f9k36153f40dd75ff57@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: af11af2d6155f8f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103837>

On Tue, Dec 23, 2008 at 11:59 AM, Paul Vincent Craven wrote:
> If I do a 'git push' to another repository, my changes are reverted
> the next time that repository is updated, unless I do a hard reset on
> the remote repository first. Of course, then I would lose my changes
> in the remote repository. What is the correct way of handling this?

Pull from the other side, or push to a branch that you never check
out. Better yet, push to a bare (no work tree) repo you can pull from
both sides.

http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

Peter Harris
