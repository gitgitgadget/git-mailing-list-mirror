From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Alphabetize the fast-import options, following a
 suggestion on the list.
Date: Sat, 5 Jan 2013 15:11:51 -0800
Message-ID: <20130105231151.GD3247@elie.Belkin>
References: <20130105164415.39B144044B@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrcuW-0007cw-P4
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab3AEXL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:11:57 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47352 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab3AEXL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:11:56 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so10003627pad.10
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 15:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lPy/n4UkndJAcmoCDmDXsASeoSLdtt90rRDFECxwKHk=;
        b=t7BJRA4624cbji0hn3ifjZhxJBWYhwbSZcKZL1obeEuE/mZ1IjQKSHwQNRWc2h095y
         SdgRX2OPRMM/MwGX4UNJBAch6cWR6gOKkIlI5S99t5OuYLv3ZQ5hd/XqwobbO90BSKS5
         dxT8xZQH2ixQR/JObyBH5qiw65gsKinW2uonAQvATJl1ALqU0o7R3DqV+e+PUl4FItqp
         h3lDwKuje7JmpKO1QWoh0EkGALzQpyAwtc/nhWFzHgmF66L9yLPzAaskeTxAW+I8+6oJ
         YAzjxE2xefqz/aGE3dJEcgOexsVd7ErvpO6y3OQAf+ulXkvDQ0AHj7FJsUBvIWa5tKr3
         xlpw==
X-Received: by 10.68.217.200 with SMTP id pa8mr4125920pbc.42.1357427515828;
        Sat, 05 Jan 2013 15:11:55 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id jv1sm29454064pbc.36.2013.01.05.15.11.53
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 15:11:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105164415.39B144044B@snark.thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212737>

Eric S. Raymond wrote:

> ---

Missing sign-off.  Depending on when you prefer to add the sign-off, something
like

	echo '[alias] c = commit --signoff' >>~/.gitconfig

or

	echo '[alias] f = format-patch --signoff' >>~/.gitconfig

might be useful for the future, assuming you already look over what
you are sending out in a mail client to avoid mistakes.

> Documentation/git-fast-import.txt | 94 +++++++++++++++++++--------------------
> 1 file changed, 45 insertions(+), 49 deletions(-)

My knee-jerk response was "If the options are currently organized logically,
wouldn't it be more appropriate to add a sub-heading for each group of options
and alphabetize only within the subgroups?"

But in fact the current options list doesn't seem to be well organized at all.
What do you think would be a logical way to group these?

 Features of input syntax

	--date-format
	--done

 Verbosity

	--quiet
	--stats

 Marks handling (checkpoint/restore)

	--import-marks
	--import-marks-if-exists
	--export-marks
	--relative-marks

 Semantics of execution

	--dry-run
	--force
	--cat-blob-fd
	--export-pack-edges

 Tuning

	--active-branches
	--max-pack-size
	--big-file-threshold
	--depth
