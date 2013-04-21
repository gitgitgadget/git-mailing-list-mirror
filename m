From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] git-log.txt: fix description of <since>..<until>
Date: Sun, 21 Apr 2013 00:41:18 -0700
Message-ID: <20130421074118.GE10429@elie.Belkin>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-4-git-send-email-artagnon@gmail.com>
 <20130420222528.GA10043@elie.Belkin>
 <CALkWK0n7e-GQ8eBjgd4pnB5AzLGN0bik-n8_McbK68CvJh6P=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTotw-0003jg-0A
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab3DUHl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:41:28 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:62012 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab3DUHl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:41:27 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so2546784daj.8
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+ON4bhaxUeQlMxdUFCMuy9OdogPCL1SiWEFh8+PVEJY=;
        b=KUoHHI0+ojScElMVYmI4OiWLH5Bkqn3GzZgYVCr68yGpVkv8JQzT0lmh0wjKwjNpd9
         e7B2yJ6Kj8naTsGuliq3xT4xg16my/KyB8KKPhYfwtaIqbmKQhHenZj/cZGDnsFlIads
         3ZbR/0V91FpYk6oqq1qgWooTo1Gmro/MnuARPdGB4FpekE7+6/WYL+xuvJTUOXA47diC
         uaUD1f0H5Oi4qmZ10htOHsRd/twazXz7JCUVEMJCNXzNVPcuTH7Ut5vNykz0ssJ/wpnq
         lje9Fedh5PtllHro2Gi80lo3dpyUXV2P9uFW35wUgvCNK6zSBwPF38SAM9GW5iRHUSFu
         A1lQ==
X-Received: by 10.66.174.143 with SMTP id bs15mr6522215pac.17.1366530087190;
        Sun, 21 Apr 2013 00:41:27 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id kd7sm20073882pbb.34.2013.04.21.00.41.25
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 00:41:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0n7e-GQ8eBjgd4pnB5AzLGN0bik-n8_McbK68CvJh6P=A@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221910>

Ramkumar Ramachandra wrote:

> What's so confusing about it?
[...]
> revision:: A particular state of files and directories which was
> stored in the object database. It is referenced by a commit object.

So a revision is a tree?  ("one of the things pointed to by a commit
object, representing a particular state of files and directories")
