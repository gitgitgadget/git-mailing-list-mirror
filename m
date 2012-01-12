From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: [PATCH] diff --no-index: support more than one file pair
Date: Thu, 12 Jan 2012 10:37:37 -0600
Message-ID: <4F0F0C51.3050706@gmail.com>
References: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 17:37:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlNet-0002Do-NM
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 17:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2ALQhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 11:37:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36508 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2ALQhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 11:37:42 -0500
Received: by yenm10 with SMTP id m10so1028865yen.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 08:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LUq9CJfLtpfi4rR08KoQByXOgYDhBSwPwy29ziH0HtM=;
        b=blU9twNhdHaBgEAM9kNMowVNZYPJQnuRfi7XNVHzbkQrJcVsh5ayL9IQErhLk4WBbQ
         x6Y4x4h9WoMUte35AxspazJoFpFZOLUXvUNi+X0miATwWttoXDPQdJgfdD9FPgAoL0BN
         ndRsSMRHVAX4gJMnw+mg/2aLl9e2qhYiYQRHk=
Received: by 10.236.129.177 with SMTP id h37mr7224045yhi.9.1326386261419;
        Thu, 12 Jan 2012 08:37:41 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id i6sm14919865and.3.2012.01.12.08.37.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 08:37:40 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188453>

On 1/12/2012 3:09 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This allows you to do
>
> git diff --no-index file1.old file1.new file2.old file2.new...
>
> It could be seen as an abuse of "git --no-index", but it's very
> tempting considering many bells and whistles git's diff machinery
> provides.
>
I see that git-diff can be used in place of linux diff for totally=20
untracked file pairs (which is kind of neat, I guess, if you're partial=
=20
to git like I am and would probably prefer to use it as your primary=20
file-system interface if you could).  I assume this new syntax implies=20
manual usage since scripting this input is less straightforward than=20
iterating thru a single pair via xargs, etc.  In that context, I also=20
see that git-difftool doesn't bring up kdiff3 (or whatever) but just=20
does a text diff (git 1.7.1) which is mildly disappointing for mere=20
mortals like myself who prefer to read side-by-side gui diffs over text=
=20
diffS.  This, of course, is also preference for someone like me who=20
wouldn't mind prefixing all of my commands with "git " ;-)

v/r,
neal
