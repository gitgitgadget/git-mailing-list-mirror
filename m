From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Merging only a subdirectory from one branch to the other
Date: Thu, 09 Feb 2012 18:51:45 -0600
Message-ID: <4F346A21.2080008@gmail.com>
References: <CAHVO_90MQamw7oB8ry5YBEWSnRnxDZvQ4ApVuuv4AYR6VRuXSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RveiX-0001vM-N5
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758806Ab2BJAvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 19:51:52 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46129 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2BJAvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 19:51:50 -0500
Received: by yenm8 with SMTP id m8so1248958yen.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 16:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Je5m158xQ5XMHlgFHsi/cqwwnR2s0eMNna5FzoYY6fc=;
        b=buEi9Deh/gS7pzX//Y/mlu+bwF8RN1Uu/DSdaSczJBE/fZF1vFENAIhF9pJFbXi3AC
         zS2awRERaJdNzyo8GacaI6Sl0ye7HNvdnngFnWla7deuNtOUp8y5ZPNoS0tqOGgluyC4
         mn7tcLqkPJs7Rl7//AfUbGf4jxfqR51uMgfGs=
Received: by 10.236.184.129 with SMTP id s1mr6118163yhm.21.1328835109447;
        Thu, 09 Feb 2012 16:51:49 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id a47sm7037247yhj.12.2012.02.09.16.51.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 16:51:48 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.26) Gecko/20120129 Thunderbird/3.1.18
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHVO_90MQamw7oB8ry5YBEWSnRnxDZvQ4ApVuuv4AYR6VRuXSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190357>

On 2/7/2012 3:38 AM, Howard Miller wrote:

> I have a branch with a particular subdirectory tree. The tree has a
> lot of history. However, all the history for that subdirectory is
> exclusive to it (no commits changed anything outside it). I now need
> to merge that subdirectory into a completely different branch without
> loosing any history. I think git-read-tree might have something to do
> with it but I don't understand the help file at all. Any help
> appreciated.
>
Does the 'subtree merge' described in this link do what you want: 
http://progit.org/book/ch6-7.html
(I can't say I've actually tried it myself, yet.)

v/r,
neal
