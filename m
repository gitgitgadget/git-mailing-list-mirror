From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 13:39:43 +0100
Message-ID: <200803011339.50978.jnareb@gmail.com>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <m3tzjrkie4.fsf@localhost.localdomain> <47C8FFFC.3050901@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: eric miao <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 13:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVR13-0005fy-OJ
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 13:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYCAMkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 07:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYCAMkA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 07:40:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:38507 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbYCAMj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 07:39:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so835413ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 04:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=dobj0gys2TsaVWEX0uYSmNY0/ZS3o/TkinE9j/zPCpI=;
        b=eFVR2RTHPFvAlcrEWlrk5j65Yl/1c1Fue7YlogdIgN8BgaJyP63p1u/JFRWC2PrXCLPveL7lNRoYPtmYVlEpMqZkwRdOZ6CojlH1XcB/pU1a+++Lo7fbJRHazTLD/uv/py8/1UwG143a7txZ5RfKD24IiJjn4ZpVjpQ0DK/IS3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ep4AB4FIX+eqJuXO0YaHjxVNXljro+gjSp+S5RYgwpCcZChm4hFY6MrycNPFtI7O8AboBERa8frZLYYVRzNc+qZKBlwOBmwFCQDJOahGrzmGUYrwnDPQUlffqpKIryjs2jTqPw/ypQt6TqMay5J/kKA7siWObUQolbHbf0cKB1U=
Received: by 10.67.89.15 with SMTP id r15mr2962502ugl.12.1204375197880;
        Sat, 01 Mar 2008 04:39:57 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.199.142])
        by mx.google.com with ESMTPS id b35sm3349059ugd.33.2008.03.01.04.39.55
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 04:39:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <47C8FFFC.3050901@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75660>

On Sat, 1 Mar 2008, Sam Vilain wrote:
> Jakub Narebski wrote:
>
>> BTW. the largest git repository is 1.6G OpenOffice.org conversion,
>> with > 2G checkout, and some large binary files under version
>> control. Mozilla and GCC, other large repos, got under 0.5G IIRC.
>> So kernel should be quite smaller.
> 
> I have an 8GB git-svn import of the KDE repository :-)

First, how large full checkout is? And how large Subversion repo?
Second, is this repository tightly packed (large window, big delta
chain)?

And last, KDE repos should most probably be split into submodules.

-- 
Jakub Narebski
Poland
