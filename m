From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Fri, 5 Dec 2008 13:18:54 -0700
Message-ID: <b9fd99020812051218o1c337148u12b8e190c60f32eb@mail.gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
	 <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
	 <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
	 <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
	 <7vskp3d3q9.fsf@gitster.siamese.dyndns.org>
	 <b9fd99020812041558w204e5f48gbed73fdbd289ad@mail.gmail.com>
	 <bb6f213e0812050301t2f18061epfeff7bc74ee6f28a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, spearce@spearce.org,
	sverre@rabbelier.nl, "Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 21:20:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8h9p-0002Gg-FL
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 21:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbYLEUS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 15:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbYLEUS4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 15:18:56 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:24032 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYLEUSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 15:18:55 -0500
Received: by wf-out-1314.google.com with SMTP id 27so149355wfd.4
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 12:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Qe2vrQxhJ9owcUxCit7zuN/ktc7qTIx5NUz6AiDhxwk=;
        b=V3BVdd895Fj+Rkd5brVe27v6WzEf6WuDTNCXZPxGwAeaYfhDyc5og2rplF8MfE7ajU
         we9EnH7YD59/NOfWg3ccSmtyfr7a6cCUeWTXYjt28I4sfDARc2703tx3fn94aujq57Qg
         OpsnyJrHWw+V9zTkLJ4ym66iYDWD0ZVfpt7XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gK0B36HtHyd+GQKgkfwBKbRomWPszp7onx0OALJ0QPpq0qAwU83lwEQJd8EXakJzp8
         LS1lSkZn/7JJpVFCtpQscmHmdskQFOu+lF8uzPt91wkJPpjL3zmCYVKE5XrEhd5TvQuy
         wK24bElH7aG3IQ5UJzrC4k+F9s2nNSdKhZWV8=
Received: by 10.114.106.13 with SMTP id e13mr350790wac.52.1228508334366;
        Fri, 05 Dec 2008 12:18:54 -0800 (PST)
Received: by 10.114.57.17 with HTTP; Fri, 5 Dec 2008 12:18:54 -0800 (PST)
In-Reply-To: <bb6f213e0812050301t2f18061epfeff7bc74ee6f28a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102410>

On Fri, Dec 5, 2008 at 4:01 AM, Alexander Gavrilov <angavrilov@gmail.com> wrote:
> On Fri, Dec 5, 2008 at 2:58 AM, Jeremy Ramer <jdramer@gmail.com> wrote:
>> Yes, that does appear to be the message I get, with the following
>> environment variables:
>> - GIT_AUTHOR_EMAIL
>> - GIT_COMMITTER_NAME
>> - GIT_COMMITER_EMAIL
>> - GIT_AUTHOR_NAME
>>
>> Now that I look closer I see that I am setting these in my .bashrc
>> file.  When I first started using git a year ago I was given the
>> impression that these were needed. But I see that that is no longer
>> the case since I use the config:
>>
>> git config --global user.name "Your Name"
>> git config --global user.email "you@example.com"
>>
>> Removing them from my .bashrc removes the warning.  In hindsight the
>> warning should have clued me in, but I've been seeing that message
>> since I first started using git on Cygwin so I figured it was a cygwin
>> issue that I couldn't do anything about.
>>
>
> I wonder if what the warning says is still true. It's 2 years since
> it was added, so the issue might have been fixed.
>
> If you run "GIT_AUTHOR_NAME=foobar git gui", and make a commit,
> does it set the author name to 'foobar'?

I ran
export GIT_AUTHOR_NAME="foobar git gui"
and then made a commit with git gui and it did not set the author name
to foobar.  It used my global config name.

>
> Alexander
>
