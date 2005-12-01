From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 7/9] Add the accurate changeset applyer
Date: Thu, 1 Dec 2005 17:02:53 +0000
Message-ID: <46a038f90512010902lb11c326p99af9ff99dacf9b4@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
	 <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
	 <20051124074605.GA4789@mail.yhbt.net>
	 <20051124074739.GB4789@mail.yhbt.net>
	 <20051124074857.GC4789@mail.yhbt.net>
	 <20051124075027.GD4789@mail.yhbt.net>
	 <20051124075133.GE4789@mail.yhbt.net>
	 <20051124075243.GF4789@mail.yhbt.net>
	 <20051124075355.GG4789@mail.yhbt.net>
	 <20051124075504.GH4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Dec 01 18:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehrps-0000i7-Os
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 18:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVLARC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 12:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLARC7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 12:02:59 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:3458 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932336AbVLARC6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 12:02:58 -0500
Received: by wproxy.gmail.com with SMTP id 69so9177wri
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 09:02:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=itpJrrSKZZc7RpKVcBIYPAqUDEaSOHTB5dK29vodC7b+ZuFgO0VF/VCbRWLy2OQZ4MVYXuN/HDm6cgGLHni2Re8eebQOD1rmSXYpVkhvfASMi/pq7f7q/+x3bYlaSiOQnIcZBX2aK7z0egRfFVvPlIGZqoT4P4Zf68+na4LRls0=
Received: by 10.64.195.11 with SMTP id s11mr927755qbf;
        Thu, 01 Dec 2005 09:02:55 -0800 (PST)
Received: by 10.64.242.12 with HTTP; Thu, 1 Dec 2005 09:02:53 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051124075504.GH4789@mail.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13064>

Eric,

My test results are a bit of a mixed bag. On one hand, I'm satisfied
that both fast and correct imports reach the same tree (minus file
modes) for the same commit with the arch repos I imported.

On the other hand, with my "moodle" repo, the 'correct' import seems
to have stop importing a lot earlier than it should have. I am
re-running it now to try to continue from where it left off, but it's
unclear why it abandoned -- I didn't see any error. How widely have
you tested this method?

cheers,


martin
