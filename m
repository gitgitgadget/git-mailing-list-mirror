From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] t3507: Make test executable
Date: Sun, 11 Apr 2010 11:52:11 -0700
Message-ID: <4BC21A5B.8020802@gmail.com>
References: <1270975426-17459-1-git-send-email-bebarino@gmail.com> <m339z1hoyv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 20:52:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O12Gl-0005p1-KW
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 20:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab0DKSwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 14:52:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62693 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0DKSwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 14:52:16 -0400
Received: by gyg13 with SMTP id 13so2484068gyg.19
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dJJeqhBQmQfAQLGKVZ53QewNNwF74Va8swbedJ9aqXk=;
        b=pV/qpL5JIwNSWmKEw6zGFSxDB54UQjmQ1NppqMHKbN0UypDN105CCk19Iui60WsPNk
         Y7i76Azk9es/TMZlCnqQW82teWcVKzacT8CjJEXNK8rl6ImasWJfPcq/FWxZYk4e5e8m
         qE2tMt3R8A7kfnEKM0hiAaDWl8pV4SzXwXUFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RjAQLhkK2C7iGlfrUpDkpXMG3nwCyF0AS8ZT1XrmFZgh4fL97w+2muvYTHt1HSe02C
         w8RUc2MOB7LyAQD5+MAFEFf43OYi1jwfrk1uT3p0RhkzHjg63+S1uE+povahB4UYAQMD
         +p5GCuxJNECUQJmBQ2T2mr3EW0Tvqaxk5Lt28=
Received: by 10.151.118.9 with SMTP id v9mr2468096ybm.346.1271011934809;
        Sun, 11 Apr 2010 11:52:14 -0700 (PDT)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 4sm910519ywd.58.2010.04.11.11.52.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 11:52:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <m339z1hoyv.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144676>

On 04/11/2010 10:36 AM, Jakub Narebski wrote:
> While at it: should t/test-lib.sh be executable?  Other t/*lib*.sh
> files are not...
>
>   

I don't see a reason why anybody would run t/test-lib.sh directly so I
think no.
