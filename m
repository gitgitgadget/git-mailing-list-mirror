From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Silly Question About Timing
Date: Thu, 09 Feb 2012 22:54:32 +0100
Message-ID: <op.v9fls6op0aolir@keputer.lokaal>
References: <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=6zh3s-OyT71vcDm=wQ@mail.gmail.com> <201202092116.q19LGnTY024797@no.baka.org> <CAE1pOi14LW6ayNiRd2KogKZn2zLMbRsTS1kkMFgFBtx5J=yFNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Git Users" <git@vger.kernel.org>
To: "Seth Robertson" <in-gitvger@baka.org>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:54:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvbwv-000438-Kj
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab2BIVyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:54:37 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59196 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab2BIVyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:54:37 -0500
Received: by eekc14 with SMTP id c14so744115eek.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 13:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=bkMWsdahqzCQrzjdUSKezESbUEBYJRCNn/VIr89UhI4=;
        b=srjxjQaDgzAWgeLCLK0iJeEWLt4Gh8KOTNUE1nlVJRKC9IhD3D0Z9OHhRzMZ2QQ6Ng
         TzM14aNC4eieHzOxODdVrsaKl7W62ut4PTa8i0N4yJigO9kwJIAkwBW94E7V+T6GA+K0
         RFAPAznLbzIEhbqjkVUJVveMbif4F2QdhQUTg=
Received: by 10.213.17.203 with SMTP id t11mr622561eba.127.1328824475641;
        Thu, 09 Feb 2012 13:54:35 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id e12sm14228946eea.5.2012.02.09.13.54.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 13:54:34 -0800 (PST)
In-Reply-To: <CAE1pOi14LW6ayNiRd2KogKZn2zLMbRsTS1kkMFgFBtx5J=yFNA@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190331>

On Thu, 09 Feb 2012 22:48:25 +0100, Hilco Wijbenga  
<hilco.wijbenga@gmail.com> wrote:

> ... and I have been unable to get the __git_ps1 part to do anything.

I get the following on msysgit:

/c/msysgit (devel) $ time __git_ps1
(devel)
real    0m0.406s
user    0m0.136s
sys     0m0.107s

Would be odd if that doesn't work on Linux.
