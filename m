From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Tue, 19 Feb 2008 08:49:17 -0500
Message-ID: <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
	 <20080219074423.GA3982@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSrB-0003ae-I8
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYBSNtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYBSNtX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:49:23 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:56459 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbYBSNtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:49:21 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1980134wra.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K7HMVn0VHeiDqWm7amBBM3d3mvaMvP7/I+yKz3xPSm0=;
        b=x2Mq9OrYDfTae/B9hso08+0PwUmDt/q4QjxUKgnFMb1aceWOMURKwz70G/Q2/7DOc8FqN9bumqrlihg2HujF5QmGSHT5HOn8mYEVWdoxzcmOoFV+PVTPNmMHeBOup2mlPfLMMktZE7QORPkAfd4QB6SJO5aYLeXgkv7wKwUslR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=he7LMY+7mLbNTusV9Kd47jWMJW64LPXPDRxy91dsM5dy5LuaJ1E1ckDfdTz445xbNJCX6LszY4JZ2ouPLt8IR+ZB04CUu/Gxj/ijkgz4jOhO8cB5Yfy0H9b+4kShhIs/QzjGQawNcOzeFcXLFjIh7l/1IdJHOINnHQV0EV6sN3Q=
Received: by 10.114.179.1 with SMTP id b1mr221514waf.143.1203428958075;
        Tue, 19 Feb 2008 05:49:18 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Tue, 19 Feb 2008 05:49:17 -0800 (PST)
In-Reply-To: <20080219074423.GA3982@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74405>

On Feb 19, 2008 2:44 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Jay Soffian, Tue, Feb 19, 2008 03:07:12 +0100:
> > +enum branch_track {
> > +     BRANCH_TRACK_NEVER = 0,
>
> enums start at 0 anyway, don't they?

I don't know, but guys, give me a break on the enums already. What's
the preferred syntax already because the existing code is not
consistent:

enum color_branch {
	COLOR_BRANCH_RESET = 0,
	COLOR_BRANCH_PLAIN = 1,
	COLOR_BRANCH_REMOTE = 2,
	COLOR_BRANCH_LOCAL = 3,
	COLOR_BRANCH_CURRENT = 4,
};

enum {
	TAGS_UNSET = 0,
	TAGS_DEFAULT = 1,
	TAGS_SET = 2
};

enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;

enum exist_status {
	index_nonexistent = 0,
	index_directory,
	index_gitdir,
};

enum CAPABILITY {
	NOLOGIN = 0,
	UIDPLUS,
	LITERALPLUS,
	NAMESPACE,
};

j.
