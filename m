From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Getting gitk to display all refs but stgit logs
Date: Tue, 9 Jan 2007 22:31:41 +0100
Message-ID: <e5bfff550701091331u300e9947r922a632327b8c37f@mail.gmail.com>
References: <20070108213259.GB17093@nan92-1-81-57-214-146.fbx.proxad.net>
	 <e5bfff550701090417g3f8ab697n709721939ab36f5d@mail.gmail.com>
	 <20070109194108.GC17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 22:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4OZf-0004Z0-4F
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbXAIVbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXAIVbn
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:31:43 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:40726 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbXAIVbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:31:42 -0500
Received: by nz-out-0506.google.com with SMTP id s1so4097495nze
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 13:31:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o6vdysX+u24jVZ77JlQzFmVLv07UFMwEKzh4vz3YRde7NC1yWD8qdSHSndQJIbykD31cluamKAimzxWGW2Z5fkEiYZ5lui9hmw+VOp2S5vPhFU9RJA4X7MmQH04A1XPSd/lgPVRg9Za2J2sEh+ziVsQgY7gnrkwh6o3njKTmv7E=
Received: by 10.35.26.14 with SMTP id d14mr51664337pyj.1168378301813;
        Tue, 09 Jan 2007 13:31:41 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 13:31:41 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070109194108.GC17093@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36405>

On 1/9/07, Yann Dirson <ydirson@altern.org> wrote:
>
> [1] BTW, as of 1.5.3 it displays them backwards, causing all sors of
> problems - I've not yet collected all of my comments for you, but at
> least that one is sent now ;)

I have quick tested on my  StGit repo and all qgit versions back to
qgit-1.2 show the same unapplied patches in the same sequence. Perhaps
something has changed in StGit or in git-rev-list in the meantime.

BTW qgit uses the following command to get the unapplied patches:

git rev-list --header --parents <unapplied SHA list> ^HEAD

Where <unapplied SHA list> info is retrieved from StGit (well, with
some shortcuts ;-) to speed up the thing).

P.S: The above 'git rev-list' command returns _also_ spurious revs
that must be filtered out matching against the given <unapplied SHA
list>
