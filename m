From: Dilip M <dilipm79@gmail.com>
Subject: Re: Git Download/Bootstrap Suggestion
Date: Sat, 28 Mar 2009 12:54:24 +0530
Message-ID: <c94f8e120903280024l73e9b072g3f9d31a566cc31eb@mail.gmail.com>
References: <49CD0841.9000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 08:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnSx6-0007uQ-6B
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 08:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZC1HY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 03:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbZC1HY2
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 03:24:28 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54371 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbZC1HY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 03:24:28 -0400
Received: by fxm2 with SMTP id 2so1286923fxm.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=jctlom895uS5OH7mx9LH5Pdq1QGi/sTY8JV0Xn0WIDA=;
        b=paQbfUhEU9XhN6tJhDdaeztTSvQ2r3GqBDFLNp8fkVqxMWkoX9mqZ1f99yVoyXz6UO
         0DqBINEr+Nl0PwH73WFxkAlJUglncQZ1Is+yl5IQnYkdMe5oBkySmL8Bc3rpM4F5k4jG
         nog9ihvQ0viyYORKzVnnKNGZVeFic+u4Sbz94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=xds7/6KWoaYxvr20cmnHTOSxmY2sd4BtXv9x0x7qUa5/OHGLjJeSLG0zwOnOZ5SXWT
         vUkH/LP+dIzykAe7Hqsf3Zcn+8y4+WzDtTz4zpLvzPb7pv8ok6At056irWW07T60wLZ8
         SVuE82kf6sfSpKMqewLmLZ21TFF6M5AU3ides=
Received: by 10.204.62.13 with SMTP id v13mr1016407bkh.50.1238225064295; Sat, 
	28 Mar 2009 00:24:24 -0700 (PDT)
In-Reply-To: <49CD0841.9000602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114938>

I had a same question :) what I want is to distribute a git version
across some team. I maintain a clone and keep the latest tag
checkedout. When ever there is a new release (tag), I switch to master
branch and pull. Than I checkout the new tag and compile.  Is there
any simple way to do this w/o any downtime?. There should be .... I
just miss some extra knowledge on git. Thanks in advance for
suggestions

     Dilip

On 3/27/09, Mike Gaffney <mr.gaffo@gmail.com> wrote:
> I may be missing something, but I would like to request that
> http://git-scm.com/download provide a link to a tarball of the actual
> git clone of the current repository with the repo parked on the latest
> stable. What I mean is that for most of my systems I build git off of
> source but I like to be able to just git pull when I want to update
> them. Currently what I have to do is
> - download the source tarball (or the rpm)
> - make it
> - install it
> - use that git clone the real repo
> - checkout the newest tag
> - make configure
> - configure
> - make
> - make install
>
> It'd be a lot cooler if I could just wget a full get repo on the latest
> tag :)
>
> Just a request, Thanks
>     -Mike
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
