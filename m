From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: The way to make work with git a bit more easier.
Date: Sat, 19 Mar 2011 19:30:40 +0700
Message-ID: <AANLkTik3_tE6DdCQkS5ssqB9OBBNSvj5KO3WK=0Vj4YG@mail.gmail.com>
References: <AANLkTimrYGXQ_wWrj-Sr3UB9YbddW613oebddUoLat7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alexey Homyakov <alexey.homyakov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 13:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0vJX-0008O9-Br
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 13:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab1CSMbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 08:31:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42543 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1CSMbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 08:31:11 -0400
Received: by wwa36 with SMTP id 36so5818918wwa.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=uLjilQLm2Ztr0UeZEhcqktYZaL+HAWwBFm+n47k/DM8=;
        b=C3szY/LTw+aq16/FHG6ZuiNXe3lFCUCggED2GBVg35p9NEL0/7r8w7x83KfnWJxiff
         cjunG0UBmAr+yJPa9E6vkSIZ32sMkhGE4o3MjBwfP7nMPPY2/gAOsMo2zDIacU6a7UM/
         eOKOprtRBPSiMShvHFAzWK0mKfoqERCOpB5aU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xh7MGt69wj3l5CRDSgzzS7juzInev78otkF5jwgnr37k58UYH1IcUUI/ZNsF9/1cEH
         eGo1pDybJVxBEXF5FP7NaPq7jJpcc8UamU/mvV8e2OyR62ErYHg5cDvYJNLTMqav14AV
         QqS+z5Ylym59Hd/b/1kGz+/HQBIHcH4PlKaN4=
Received: by 10.216.157.68 with SMTP id n46mr3445897wek.111.1300537870089;
 Sat, 19 Mar 2011 05:31:10 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sat, 19 Mar 2011 05:30:40 -0700 (PDT)
In-Reply-To: <AANLkTimrYGXQ_wWrj-Sr3UB9YbddW613oebddUoLat7b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169429>

2011/3/19 Alexey Homyakov <alexey.homyakov@gmail.com>:
> Hi, guys, i'm enjoy to work with git, but think it's possibly to make
> one of the operation more easier.
> What do you mean about mark a parts of files which don't need to be
> tracked by git once instead using interactive adding each time?
> For example using statement in comments like this:
>
> ................
> tracked part
> ...............
> //@git off
> ...............
> untracked part
> ...............
> //@git on
> ................
> track again
> ................

That's interesting, provided that this is only enabled by command
argument (i.e. never activated by default). Another option is to make
"git add -p" only show chunks that match a pattern.
-- 
Duy
