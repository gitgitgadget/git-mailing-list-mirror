From: Mike Swanson <mikeonthecomputer@gmail.com>
Subject: Re: Remove leading/trailing whitespace from commit messages when
 importing from Subversion?
Date: Mon, 09 Mar 2009 23:15:26 -0700
Message-ID: <49B6057E.2020706@gmail.com>
References: <49B5DB01.8080206@gmail.com> <49B5FCD3.8060707@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgvGy-0002WZ-Hw
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 07:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbZCJGPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZCJGP3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 02:15:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:63077 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZCJGP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 02:15:28 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2415548wfa.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 23:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=mf+5bhBi1vqn1A6a0LelPQ1Khe01pLnIMlMZo10EbXg=;
        b=Rybzuo1k8qbmQd+qXU12JzqaWfds9iAfyrI1nLOvVAilK4QcummhLXnyXYv8DwVT6h
         s+pt3OtroQZPNIn5SxJoV5LLle4FX1McR9hoYVB0J+iKXZIEr1vaEc/zNrPVCH41VKDM
         3UQDXqq/rneXnBACth8gAsQmrdkdxHgH+lBqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=LOZJkQ7VnECSyTSQJUkuKLVAocte+CHPAq1okVYMWEQJi3+weLn2hFntrjkbNZ9K+E
         DvaOVcKRm/t9VhZZw9b0Gq+swm0bMVEJdT+4zow+7QofkUGrDzp8dwD4ihG0waAhM/hq
         BHlv61D0RCrCwWSBpO6INHk0n9LHH1CAIPF9U=
Received: by 10.143.163.10 with SMTP id q10mr2916427wfo.324.1236665726858;
        Mon, 09 Mar 2009 23:15:26 -0700 (PDT)
Received: from ?192.168.1.2? (c-76-28-231-90.hsd1.wa.comcast.net [76.28.231.90])
        by mx.google.com with ESMTPS id 30sm10687561wfg.34.2009.03.09.23.15.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Mar 2009 23:15:26 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <49B5FCD3.8060707@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112781>

Marcel M. Cary wrote:
> Try "git filter-branch --msg-filter your-filter-command".
>
> Marcel
>   

Thank you, after-the-fact works fine too.  :)

If anyone else searches the archives and wonders how I did it, this sed
command is it: sed -e "s/^[ \t]*//;s/[ \t]*$//;/^$/d"

Unix rules!
