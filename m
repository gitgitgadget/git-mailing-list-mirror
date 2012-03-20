From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: git rev-list -S ?
Date: Tue, 20 Mar 2012 16:21:24 -0400
Message-ID: <20120320202124.GF3601@gmail.com>
References: <4F68CDA4.6060109@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 21:21:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA5Yk-0004RV-By
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 21:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757018Ab2CTUV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 16:21:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52973 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2CTUV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 16:21:28 -0400
Received: by ghrr11 with SMTP id r11so477750ghr.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LnVHdY4vLE9IvZFLpDVpNR0pPsyfvbxWquDRJXX4oeY=;
        b=J9f0ILKinqimnF3wQWY2AMHyH9/P2IzzP67IaPj3iQcLvK6pGxV8oz3SstmwDjVnZg
         H9FFtmggDECxr1uIIttzUiM7CaDF0FdybpxKyGR5LtqbLC+xFSlwTGGICnNezSzFa5sV
         eK8n6FHrVuDZfl84r2TQrOe+1czcjRRzflzIeVSPQS8fxcd/luL+T2wnWjWbRyvKJlyX
         O+pVEW0emCMCK6X8uZIepiRV/o3mxD+zGxjAi8WsUUBUI0jzl1kCuVDs+KIleE0iVdFu
         9hAcdpYjbbZXZ5+aAKMwVmdp8ytdBr9ule3wJwYBxPC4ae0Q9fxeO8p1JiXmkvl0HUJM
         VOfA==
Received: by 10.224.17.202 with SMTP id t10mr2594284qaa.87.1332274888399;
        Tue, 20 Mar 2012 13:21:28 -0700 (PDT)
Received: from gmail.com (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id dv7sm4381486qab.15.2012.03.20.13.21.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 13:21:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F68CDA4.6060109@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193539>

On Tue, Mar 20, 2012 at 07:34:12PM +0100, Holger Hellmuth wrote:
> I read the GsoC page about the ultimate tracking tool just now and
> couldn't find the -S option in git rev-list documentation nor in
> 'What's cooking'. Stealth command or am I just blind?

I use 'git log -S<string>' to pickaxe search my histories for commits
that affect <string> nigh daily. I can't find reference to it in
'git rev-list', but I know similar functionality is available in
'git diff'. Maybe it's just a typo in the wiki page?

--
Christopher Tiwald
