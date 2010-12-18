From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] docs: use <commit> instead of <commit-ish>
Date: Sat, 18 Dec 2010 02:39:25 -0600
Message-ID: <20101218083925.GD6187@burratino>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <1292650725-21149-8-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 09:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTsKI-0005Ke-Jn
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 09:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab0LRIje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 03:39:34 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49631 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0LRIjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 03:39:33 -0500
Received: by iwn9 with SMTP id 9so1527565iwn.19
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 00:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Jbn79h1q2S9nbVbbZDNYFyLcg9nk3dnqPRkMJiyIuV4=;
        b=SCcz61j/aNUd/Nbs4Zy77SUEKKncL6bEWkmQ9WYp4hDnLAlziHB1RebXyAOdhhjJav
         vSEe0H6pKB6CbehUJaU8Tdw3xSyvNNycrpbAFG5R6q+fni3oTtNqrFd4vgt7EYfVmmYL
         qiIN2tijZxveKRhM4N1gUzi/lljGXJz1xAm+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VJExFBXDBlyc5CWBWjNNMT4N+XsBd2mWuIqC7As47nXzRc4AX7ZrTvegmWuRwHEi6g
         nBvxPo2+J2dkwKGKq1ZEr0NYiAejeBsQCDdCBZ8wSwlCS9p97VF62hyaGSL731gLwW52
         yjslI1pgCWx1tIenvas0djO69ynZnDCwP5ZXo=
Received: by 10.42.164.201 with SMTP id h9mr1830488icy.254.1292661572554;
        Sat, 18 Dec 2010 00:39:32 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id 8sm1096975iba.4.2010.12.18.00.39.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 00:39:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292650725-21149-8-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163910>

Mark Lodato wrote:

> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -26,8 +26,8 @@ see the -a and -s options to linkgit:git-tag[1].
>  
>  OPTIONS
>  -------
> -<committish>...::
> -	Committish object names to describe.
> +<commit>...::
> +	Commit object names to describe.

Or even

	Commits to describe.

:)

> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -350,8 +350,8 @@ change to the project.
>  	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
>  	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
>  	data
> -	('from' SP <committish> LF)?
> -	('merge' SP <committish> LF)?
> +	('from' SP <commit> LF)?
> +	('merge' SP <commit> LF)?

As the audience of this manual page is people mostly familiar with
other version control systems, it needs to be very explicit.  Not sure
what the best solution is, just pointing out the worry.
