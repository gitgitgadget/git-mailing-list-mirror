From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 02/11] trailer: process trailers from stdin and arguments
Date: Fri, 7 Mar 2014 13:41:38 +0100
Message-ID: <CAP8UFD1RF79YpdORs7_HNYDOufwPEoRj62YRvyL9Pp7j5YAPCA@mail.gmail.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.7378.chriscool@tuxfamily.org>
	<xmqqiors1cn4.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3pg7xeFok6wKPc=iP3D87qhZwyOJm=kiUnAj09NcUJKQ@mail.gmail.com>
	<20140307080850.GC4774@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 13:41:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLu5w-0001wU-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 13:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaCGMlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 07:41:40 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:53771 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaCGMlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 07:41:39 -0500
Received: by mail-ve0-f176.google.com with SMTP id cz12so4052975veb.21
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 04:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Hd/5Tk3K5pCHPx7Gh5fsat3vTrMlKwJ5KFh4bTnx9aA=;
        b=rS7nUlN7zezKF1QD+otZIklblEND2osdcCStCWvOxYc+Ujsr3PDO0j9Gtlp4SHGxq8
         KW3EHgy81oUP06hjVWdKrA4IyoH0Nx6As6nECGDWQ82SYkUWft8CE89+Kl3UO3VyT3Dz
         hH6a4p6l73O2syTCcDSWZIlM6ESkqemckCMXKnVAiftO2+B9RvOq06jyCGTVm+HK7xH6
         zLMGramTV29Ykv+7RhL6fjacyzhMhXW52KKU58/uz/zSgc+Lewa7flxl1TTtiG6sdDbs
         2mCH2bdERmS+eVv0pZSuBf46D6w7jLO6B/eD8+9py8VHGXMpWlUoVcO9lZ/P66+m06Dm
         BKYg==
X-Received: by 10.52.12.36 with SMTP id v4mr8426230vdb.20.1394196098870; Fri,
 07 Mar 2014 04:41:38 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Fri, 7 Mar 2014 04:41:38 -0800 (PST)
In-Reply-To: <20140307080850.GC4774@mwanda>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243613>

On Fri, Mar 7, 2014 at 9:08 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Fri, Mar 07, 2014 at 07:19:15AM +0100, Christian Couder wrote:
>>
>> Yeah, I don't know why, but these days I find it very hard to review
>> style issues in my own code without being distracted.
>> And by the way is there a good script to check them?
>
> Many of these would have been caught with kernel.org's checkpatch.pl
> script.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl

Yeah, I already thought about using it in the past, but I was not sure
about its status regarding the git source code because it's use is not
suggested in CodingGuidelines, and the discussions about adding it
there went nowhere:

http://thread.gmane.org/gmane.comp.version-control.git/223698/focus=224653

Thanks,
Christian.
