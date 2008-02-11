From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: Trouble with gitk and ActiveState tcltk on OS X
Date: Mon, 11 Feb 2008 12:59:45 -0500
Message-ID: <76718490802110959y10df4bc6xfe98a9de57a4f8a@mail.gmail.com>
References: <m2ve4wh5sx.fsf@ziti.evri.corp>
	 <20080211044941.GX24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Seth Falcon" <seth@userprimary.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOcxJ-0001nK-9t
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbYBKR7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 12:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbYBKR7t
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 12:59:49 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:58698 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502AbYBKR7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 12:59:47 -0500
Received: by el-out-1112.google.com with SMTP id v27so1758688ele.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=icDz89pI5e3OSmdLIopb1KBkEU32IMDPRgn9X6IjVqc=;
        b=eeoWIZU1ghZ/L0KOE1Kzfz3FDF72Q5mQHUNe0YQM5vz667bSE/oSD0bijRevjBdKepPBGdXf+aMnqm/VLIKCtoQzQ7qiVmvlhKszUhlQ07uwdDTDjSWwTtXiUig8r1578rzWUcm7dwFoizLpzGfXx01LPZ0bkFMwpwfkY0AMc6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OvLa7hi9Y1laNA0q0ltC07eMzKsozaJxd4GNxRC0FwYXRETXgNJRttUUr1xdD5I6f4t+Ls4xYY8uPLk6oW6Ujdwosm+gTBwV2wUsNGFhNiyYCsE4sxb3TmHARchoy/f7qvkER4GR4c65lcDC3oYCQmbx9NN7/gPzkrWA8V171s0=
Received: by 10.114.210.2 with SMTP id i2mr313724wag.36.1202752785194;
        Mon, 11 Feb 2008 09:59:45 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Mon, 11 Feb 2008 09:59:45 -0800 (PST)
In-Reply-To: <20080211044941.GX24004@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: a7379881e846790d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73556>

On Feb 10, 2008 11:49 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> For what its worth I use the native Tcl/Tk that ships with Mac OS X,
> /usr/bin/wish, which is really in /Library/Frameworks/Tk.framework.

Under 10.5, it's /System/Library/Frameworks/Tk.framework and the app
is now /System/Library/Frameworks/Tk.framework/Resources/Wish\
Shell.app. I'll work on a patch for the git-gui Makefile in next (or
master?) to work w/both 10.4 and 10.5 if I can figure out the darn
Makefile quoting (loathe whitespace in path names).

j.
