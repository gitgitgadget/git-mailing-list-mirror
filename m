From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Exec format error when using gitweb
Date: Sun, 22 Jun 2008 16:04:06 +0200
Message-ID: <485E5BD6.6060105@gmail.com>
References: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 16:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQBn-0007MH-Ue
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYFVOEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYFVOEM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:04:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:43305 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYFVOEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:04:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so960303fgg.17
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=JdUJWkLbBxxAtCkUYjOeuYU+oNwxnptqp4tbmm1pH8w=;
        b=iBx1l4czE9XGF+w+33u7YMHvrYxDfSHNbvH71Nd3j+3e5e1ckMm2gzAExgGxStOzfT
         TCDxtio3pkI9RM03/M27LZEA/pB2nPi18D0iKb4l5ECJaiXIXHLWPkJxAJj2I9hcFUn8
         MjeR3/R14BwTTOARgxJOutwmil1VM+ngABnEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=iuKCOdAddzi32B/6LRrmL2YnKZG5zoRawsgQHYMQFJQL2sM+wKt4OBZqtNSu2POyU7
         AvY32aVO9+OANyBqTyDzcNXT41pycmaHbfVjeHi925ManSujlZc+S/TNSivrvE080Smv
         1tYncZRMDVUb+qqeHtsIwGqeLMsKLVk5Mq6SA=
Received: by 10.86.80.17 with SMTP id d17mr7000156fgb.24.1214143450098;
        Sun, 22 Jun 2008 07:04:10 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.241])
        by mx.google.com with ESMTPS id 3sm8729414fge.3.2008.06.22.07.04.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Jun 2008 07:04:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85774>

Erez Zilber wrote:
> [Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] (8)Exec format
> error: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:

Random guess: Did you make the data files (.css, .png) executable by 
accident, so your server is trying to execute them?

-- Lea
