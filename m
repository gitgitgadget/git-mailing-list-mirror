From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/2] Add --expand to 'git notes get-ref'
Date: Thu, 6 Sep 2012 00:44:06 +0200
Message-ID: <CALKQrgc-NZJrxvm_gJcWYCpsOprF=Rzf8=jGuARoit53T8KVkw@mail.gmail.com>
References: <cover.1346848834.git.wking@tremily.us>
	<CALKQrgdRqd59pfLtpROwxtrFjvO5oYgKKN3KCp1NA4aMEEcj1w@mail.gmail.com>
	<20120905175344.GA8619@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Sep 06 00:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9OKa-0003tx-3D
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 00:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759752Ab2IEWoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 18:44:12 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64480 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759738Ab2IEWoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 18:44:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1T9OKP-000J0o-Il
	for git@vger.kernel.org; Thu, 06 Sep 2012 00:44:09 +0200
Received: by obbuo13 with SMTP id uo13so1339309obb.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 15:44:06 -0700 (PDT)
Received: by 10.182.131.37 with SMTP id oj5mr50864obb.54.1346885046176; Wed,
 05 Sep 2012 15:44:06 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Wed, 5 Sep 2012 15:44:06 -0700 (PDT)
In-Reply-To: <20120905175344.GA8619@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204850>

On Wed, Sep 5, 2012 at 7:53 PM, W. Trevor King <wking@tremily.us> wrote:
> On Wed, Sep 05, 2012 at 05:58:37PM +0200, Johan Herland wrote:
>> On Wed, Sep 5, 2012 at 2:48 PM, W. Trevor King <wking@tremily.us> wrote:
>> > If I'm missing a good reason to keep everything under
>> > 'refs/notes/', feel free to ignore the second patch.
>>
>> This has been discussed a couple of times on this list, but it never
>> resulted in any actual changes. Read up on this thread to get some
>> context:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/160503
>
> Thanks for the pointer, it looks like there are a bunch of good ideas.
> I assume the lack of changes was due to nobody having the
> time/inclination to implement
>
>   http://article.gmane.org/gmane.comp.version-control.git/160655

Yes, I think time/inclination probably has a lot to do with it. Also,
I forgot to link to the largest mailing list thread that discusses
these changes in _much_ more detail:

http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165885

As you can see, the discussion quickly balloons into something much
larger than a simple discussion of where remote notes should be
located...

That said, your patch 2/2 might be an acceptable stopgap measure for
the time being, and then we can reevaluate it if/when we implement a
larger ref restructuring.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
