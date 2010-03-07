From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/4] send-email: actually add bcc headers
Date: Sun, 07 Mar 2010 13:53:41 -0800
Message-ID: <4B942065.1000406@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org> <1267997598-20815-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 22:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoOQ3-0004i1-I7
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab0CGVxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:53:46 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50149 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab0CGVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:53:45 -0500
Received: by gwb15 with SMTP id 15so2698310gwb.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kUqYqGZDDV42BYPLGT4zJn7kZ57GFs8zVy9aJsc7KHs=;
        b=VqSoi354nBcUD+fmKTD6Z4RrBIVbzJg5NGwd1tN/Jjh79eB9x9NHLLdqDeqSxstIQ8
         uHS3HB3VUmm+g4gz5U9tL7acALCC0SuVJ1JL0tMuE6sXtzpjWHO5lF9E+UypbqV6oROS
         3RlJDdf1XCq5sUMg3MF4KZmSUDIb6IwQLQO3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=CGRsB7g6s6xBKZ2YJw9kRiWYugRAB6/o9Ikanb3+hThP7k3ZA673P/jxcyWXXkHVcs
         OpOlpKg3EwdluBJMQ7rJ2bG+PQHPqfaEt6FBiQesMz7ZFE5BFRxfrdfDv+q2RHHgRnav
         56E2mLmnPWESxpfwkDpLggfJzh8WJbY1+wstQ=
Received: by 10.151.86.14 with SMTP id o14mr2370539ybl.43.1267998824369;
        Sun, 07 Mar 2010 13:53:44 -0800 (PST)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 5sm1129427yxd.53.2010.03.07.13.53.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:53:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <1267997598-20815-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141738>

On 03/07/2010 01:33 PM, Stephen Boyd wrote:
> This bug looks ancient. In fact it doesn't look like --bcc ever worked
> even when it was introduced in 5806324 (Add support for --bcc to
> git-send-email., 2006-05-29).
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
>   

Haha. Nevermind this one, I'm blind and can't read. Need to figure out a
way to test the bcc list though.
