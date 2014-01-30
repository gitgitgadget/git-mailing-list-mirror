From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Feature Request Google Authenticator Support
Date: Thu, 30 Jan 2014 15:18:45 +1100
Message-ID: <CAH5451k9Urx+OSPZx33AFzqRcKeWJOM_rkHe3NVuS2CP6eNaZg@mail.gmail.com>
References: <20140130040702.GA77226@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Rahm <ac90b671@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 05:19:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8j6E-0004YR-9V
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 05:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbaA3ET1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 23:19:27 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:34019 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbaA3ET0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 23:19:26 -0500
Received: by mail-vc0-f173.google.com with SMTP id ld13so1756329vcb.18
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 20:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Sm+lqAtctXSCiUzxGeMZbnTdWUcTgTQCjIpup5l0vOM=;
        b=r7a3xfU2CcDR5WZvboBtOMfqCI/UwofkSnOnXWnFTqNvXL7QZnHjUruBUmYRrdQDzW
         OqGwcF2SKLA6NOCjq+xrGoHaCNgEawBg8snoE8+YwKrHJB7SjwN75ENGTfhA9HsE23Pv
         YMsoKNhz/7AAO6HUPwavwzI7EU9TCpL8sdpdlCD7IBLD/znTUpRfCcdlFwbV9FCbnoMf
         3cEzjzmow5JCwBAt4AKyebcgpzOi3Be5AUzKacwskrifbMrMQvkfcwaPDuZtDOotGpb4
         1eijRLRonuxsM4r8Y83sM+WZpO4inFQpZhAognCMCD20LNdvvQJ0fPbjyLWpLOmblM4Z
         Zs+w==
X-Received: by 10.220.251.73 with SMTP id mr9mr9547490vcb.2.1391055566220;
 Wed, 29 Jan 2014 20:19:26 -0800 (PST)
Received: by 10.221.8.133 with HTTP; Wed, 29 Jan 2014 20:18:45 -0800 (PST)
In-Reply-To: <20140130040702.GA77226@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241237>

On 30 January 2014 15:07, Max Rahm <ac90b671@gmail.com> wrote:
> Github supports google authenticator 2-step authentication. I enabled it
> and how can't figure out how to connect to my github account through git.
> I've looked pretty hard in the man pages and on google and can't seem to
> find anything on how to set up git to work with a repository with 2-step
> verification. Here's a link to my stackoverflow question with my exact
> problem if there's something I'm missing.
>
> http://stackoverflow.com/questions/21447137/git-github-not-working-with-google-authenticator-osx
>
> As far as I can tell the feature is not supported. I'd like to be able to
> use the 2-step authentication but obviously I'd like to be able to push my
> code :D

I was under the impression that private key authentication worked
regardless of two-factor authentication. Is using git over ssh an
option for you?

Regards,

Andrew Ardill
