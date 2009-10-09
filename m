From: Eugene Sajine <euguess@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Fri, 9 Oct 2009 18:32:25 -0400
Message-ID: <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
	 <m3ab00gr25.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwO2N-0007CT-T0
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 00:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934673AbZJIWdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 18:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934539AbZJIWdD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 18:33:03 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:37311 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934274AbZJIWdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 18:33:02 -0400
Received: by gxk4 with SMTP id 4so8347693gxk.8
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zhj0S9W0Ms2Og0Qmr1Hvbv/QSgPC2NmqqfhXlwdkJFY=;
        b=V6KDug2xLba9olD8eLp0Yyy/GvVvqWb4rz2OdPY7X2FEfUCi9fOnBaC7w4qNswLaGl
         IcaeQb63I0Q2ANOmenaAsXijNWRg3FHkHEx54ovnxt8sIkzXC5jGD9nT70CQu/w6BXzm
         xqcUz3mUU6AJS1IZpjrsDcuBNLCF5Mk8naPnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rEi1ijEQu7UqSvGncuwxW7cfZw728S8fNaMp15XT/rWiWxED7oX06AKgdtiixjJckE
         Y6AJZF4ZLEDHNZK2XrmWrDUsZmyhAqFYFeUH6Rh5GARIC4QxsItTW0LyWTGVBzS2BZP7
         Le4Q/mUbXIP5cML82Mz7d7v3S6V6Tys1Z9siA=
Received: by 10.90.10.1 with SMTP id 1mr1696659agj.62.1255127545318; Fri, 09 
	Oct 2009 15:32:25 -0700 (PDT)
In-Reply-To: <m3ab00gr25.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129853>

>
> RTFM (in this case gitweb/README). =C2=A0gitweb.owner and gitweb.desc=
ription
> configuration variables in per-repository config.
>

Ok, my bad, didn't get there;)It is good to know there are places
where to keep the info. But it is not the point. The point is to
integrate gitweb with bare repo creation more than it is right now by
providing keys which will help filling out this info at the bare repo
creation stage.

shortly i'm talking about command like this (the key names are for samp=
le only):

$ git clone --bare repo repo.git -desc "description" -gwowner
"gitwebowner@server.com" -cloneurl "git://host/repo.git"

seems to me quite comfy, and no headache...


> %
> "To be fair, there are uses for XML. On Halloween, for example."
>
> =C2=A0 =C2=A0 - Johannes Schindelin, on git@vger.kernel.org
> %

yeah, to show kids xml print outs as an answer to "trick or treat!".
Can save on candies;)

Thanks,
Eugene
