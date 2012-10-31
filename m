From: kevin molcard <kev2041@gmail.com>
Subject: Fwd: Re: [git-users] Git clone fails with "bad pack header", how
 to get remote log
Date: Wed, 31 Oct 2012 15:20:16 +0100
Message-ID: <509133A0.2050909@gmail.com>
References: <20121031152837.4c0f8ce84fae14ba36429605@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 15:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZ9n-0005Gg-AF
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935665Ab2JaOUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 10:20:23 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58225 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422815Ab2JaOUU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:20:20 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so4265218wib.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-forwarded-message-id:content-type
         :content-transfer-encoding;
        bh=km4h/51MFbQ2cx0dWl6rUGX8XYW4bB2qSjIRDfiL7og=;
        b=q88c9xDlOzphzkXFEGRuY+BJrQK7uQ+uirBb7VyHRrefQEaHEcqcXOyBWQtznRL4gV
         L22iyoHAVw5Lx9oEHnXlIJI0gUop3y9Ze94U6I66xIt2zsiF2/TIRMzBiJPj0Iryoknj
         LvLtLKe2djky/3PA1Y1Ak0K6s5BYHHjO06c6LD+3VSjCeWUr9TwfL9Dhdrl63bfuiXx9
         TpCF8MqgD08sGcSW/xg/cEp58VeLYxmAoND45/L96OVXEcNh7b5Ycyy9gwgh8CbUGR6d
         pIoMJd3Cqbt+L84/2rsuoAahQPyj95SoWW45zmK5n7Q3pGhnZF5o2MA1GxdSmOoabAPo
         552w==
Received: by 10.216.145.32 with SMTP id o32mr17556202wej.215.1351693219159;
        Wed, 31 Oct 2012 07:20:19 -0700 (PDT)
Received: from md009.arturia.lan (mey38-2-82-228-181-124.fbx.proxad.net. [82.228.181.124])
        by mx.google.com with ESMTPS id gg4sm6006147wib.6.2012.10.31.07.20.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 07:20:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <20121031152837.4c0f8ce84fae14ba36429605@domain007.com>
X-Forwarded-Message-Id: <20121031152837.4c0f8ce84fae14ba36429605@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208825>

Hi all again,
here is my second email :).
It contains the git versions in my system.
FYI, I updated git to 1.8.0 on my remote but still having the same issue.
Another thing that might be interesting is that it seems to happen only 
when cloning from Windows build machine (i.e. I send 2 clone command on 
from the mac and 2 from the Windows and it seems to always fails on the 
Windows).

Thanks again
Kevin

-------- Original Message --------
Subject: 	Re: [git-users] Git clone fails with "bad pack header", how to 
get remote log
Date: 	Wed, 31 Oct 2012 15:28:37 +0400
From: 	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: 	kevin molcard <kev2041@gmail.com>
CC: 	git-users@googlegroups.com



On Tue, 30 Oct 2012 08:01:12 +0100
kevin molcard <kev2041@gmail.com> wrote:

> thanks for the reply.
> The versions of git are:
> - on remote: 1.5.6.5
> - on windows build machine: 1.7.11.msysgit.1
> - on mac build machine: 1.7.3.4
>
> I will try to install latest git version on my remote server and get
> back to you.

Hi, Kevin.
I noticed my Cc'ed messages did not reach the main Git list for some
reason (even though I did see these my messages coming from the
list-management software), and the did not show up on Gmane [1].
I do not know what's the reason is, so please try forwarding my first
reply to your original message and the message I'm replying to now
(with versions of software involved) to that list yourself -- maybe
you'll be more lucky.

Sorry for the delay.

1. http://thread.gmane.org/gmane.comp.version-control.git/
