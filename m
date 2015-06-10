From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git lock files (Was: GIT for Microsoft Access projects)
Date: Wed, 10 Jun 2015 09:47:33 +0200
Message-ID: <20150610074733.GM30511@paksenarrion.iveqy.com>
References: <5576F02B.4040002@gmail.com>
 <1433870383-7631-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kostix+git@007spb.ru, hackerp@suddenlink.net,
	sitaramc@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:47:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ajn-0004eu-5l
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933469AbbFJHrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:47:42 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36488 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbbFJHrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:47:37 -0400
Received: by laar3 with SMTP id r3so27030522laa.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bOWi9H0TPGD5HGyQ3f2LI1q5B5XU4lvlTvgnANHWotk=;
        b=YRgZfby96TCdlWvJL1QNvn3gTeyEq3lQuLtY9oOjkeB8zraNTUTb4w7xIwfFAW1K7y
         ciL0t569eV9LmwZhG2kb/Y2Jk8gYE1aRO5wyuBWnOZpqhPpGHGCLp4RJvr11isbfFZHn
         AnyyiFz8sAQ9nu0W6qzKYPxqisoBvCRKL03GXxaUBg4pqFE8XOnsJhfdAIS9x9Z/1tcH
         cpfPuwsByi3B47onxPv0jBG7CqolGoumumEpBeQbk+2e9uptb2H8o140I+h/VIwh4CNy
         xsW7bla+BoNV9UFS6fiN7kLkIDl1d9J1lfShCw1S/9iAPCT0zzo6fYjPCAfTPP8dQOy9
         7omg==
X-Received: by 10.152.87.13 with SMTP id t13mr1913704laz.66.1433922455423;
        Wed, 10 Jun 2015 00:47:35 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by mx.google.com with ESMTPSA id ef5sm1979813lac.30.2015.06.10.00.47.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 00:47:34 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Z2ajV-0001A7-KP; Wed, 10 Jun 2015 09:47:33 +0200
Content-Disposition: inline
In-Reply-To: <1433870383-7631-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271268>

On Tue, Jun 09, 2015 at 10:19:43AM -0700, Stefan Beller wrote:
> Just because Git allows distributed workflows, doesn't mean we
> should only focus on being distributed IMHO.
> 
> The question for content not being mergable easily pops up all
> the time. (Game/Graphics designers, documents, all this binary
> stuff, where there is no good merge driver).
> 
> I could imagine a "git lock" command which looks like this:

You do know that gitolite has locking functionality?

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
