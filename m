From: "Chris Hoffman" <chris.c.hoffman@gmail.com>
Subject: Re: git-daemon on Windows?
Date: Thu, 12 Jun 2008 14:24:50 -0400
Message-ID: <63c5d3820806121124p490ecf3eh87cb7c3742937fb2@mail.gmail.com>
References: <63c5d3820806110551y69e895eeg4fde4bfdaf22bbf2@mail.gmail.com>
	 <484FD8FA.3060003@viscovery.net>
	 <1033a22d0806120823j40185f9dj28672803490f8bdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "John Yesberg" <john.yesberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6rUX-00074U-Uf
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbYFLSYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYFLSYv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 14:24:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:19632 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbYFLSYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 14:24:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2134656rvb.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oQ5h+xOyrP5WBTIwnhQONgKCvAk7/9oGC06qkg3vn6E=;
        b=F1Oz8Yc83oqyvhJEguaHBdbD/EyZyJMKrGmmVM+OcJdPwJE07UyIbdwC6y3b03v1CL
         kjSwBhPphqhIypHTZM6IThnfLmKqOrmN4P+kkjYotU7IO9pLP15ujhyKICiP4ACYaAyc
         wh/oepqaFnhlEhrXapPkRE9nRqLFiIsu9ie2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rqY9Pn9pptT8gsGGKCJjFe0PHziIHl1YttiZH9Sgpg52S6UqEIHRUyuPP1PNVRPNvW
         xYhveftjZ8PqAyW2FfAl1pZcP+7v16vGEuu3h2NgGofpkUziMqOx4YLEvBFEi4EyOTki
         epJ5dsEpmyj+F4lo+Nx1Cozi2muA+lNBIqBZY=
Received: by 10.140.131.11 with SMTP id e11mr1248582rvd.104.1213295090093;
        Thu, 12 Jun 2008 11:24:50 -0700 (PDT)
Received: by 10.141.87.15 with HTTP; Thu, 12 Jun 2008 11:24:50 -0700 (PDT)
In-Reply-To: <1033a22d0806120823j40185f9dj28672803490f8bdb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84769>

Yes, I think that this is a very good section of the tutorial to
consult.  It is just hard for me to beat back my subversion thinking.

On Thu, Jun 12, 2008 at 11:23 AM, John Yesberg <john.yesberg@gmail.com> wrote:
> I'm trying to learn about this too.
> I found the gittutorial
> http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
> useful.
> See the section "Using git for collaboration", which explains how use
> can use a shared filesystem.
>
> Or maybe I don't understand the subtleties of the issue.
>
> John.
>
> On Wed, Jun 11, 2008 at 2:54 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Chris Hoffman schrieb:
>>> Is there a distribution of the git server for Windows, or am I totally
>>> missing the point of git?  Will a simple file share work, or do I have
>>> to worry about file locking and such (e.g., two people try to commit
>>> at the same time).
>>
>> You are missing *some* point of git: Usually, everyone has his own
>> repository, hence, commits that happen concurrently won't be a problem.
>>
>> But you must exchange your work, and for this it is common that everyone
>> in addition has a publically accessible (bare) repository. These you can
>> place on a normal file share. I do this all the time.
>>
>> You *can* choose to have only a single (bare) repository that everyone
>> uses to exchange work. But then you do have to worry about concurrent
>> *pushes* that get in the way of each other. You have this problem no
>> matter which form of server you chose (file share, ssh, git daemon,
>> WebDAV). If you go this route, you need a policy how people publish their
>> work (eg. branch namespaces). msysgit and 4msysgit do it this way.
>>
>> -- Hannes
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
