From: "Ramagudi Naziir" <naziirr@gmail.com>
Subject: Re: rsync vs. git-push/pull ? (+kudus)
Date: Wed, 10 Sep 2008 09:31:29 +0300
Message-ID: <dfb262380809092331i3399731cqdec3b2bb79d2fcdd@mail.gmail.com>
References: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
	 <alpine.DEB.1.10.0809062326000.8096@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Sep 10 08:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdJFo-0007ob-ED
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 08:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbYIJGbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 02:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbYIJGbb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 02:31:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:47879 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYIJGba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 02:31:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2253159rvb.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=U0G7v2idrMvF75fOFU+ihMaUoUj+H1TKLbmllQus8I0=;
        b=q796QnqTp+a0XH3V//t4xkJNm0pNHZMHhUjcMti8JGkX1Ly2myMOuX+xvALgBzmHjH
         uVOoGpPbXlIFvTt2f/TSYZSr/JicobHCPWOGLmQe0wpALXAQFSUbkqLpJm3XgNgTRChO
         iM7sBENOzdUMVjhq1jZd2HSImMie4mjjZbNzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eqnuw1mxWWvBKR9XyMw0mDyErD1mSdAuTxceKVczTtEgtpjFS2fFQQ8fNAT4fYvPQ5
         jOnkr4zTMXZJ9mH0tKNnXURV6AxyEDkswq4BqOfYiEWX+ebO0Up/7RyOBF7I3YGK9t/M
         aIESArAyw1HQWMNSVCsGNHqGebns2wuMHE5ZM=
Received: by 10.141.123.4 with SMTP id a4mr504166rvn.172.1221028289706;
        Tue, 09 Sep 2008 23:31:29 -0700 (PDT)
Received: by 10.141.29.1 with HTTP; Tue, 9 Sep 2008 23:31:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0809062326000.8096@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95486>

Hi David,

On Sun, Sep 7, 2008 at 9:27 AM,  <david@lang.hm> wrote:
> On Sun, 7 Sep 2008, Ramagudi Naziir wrote:
>
>> Hi all,
>>
>> I have several local git repositories on my machine. I'm the only
>> user, and use them only locally. Now, sometimes when I need to work
>> remotely, I just rsync my repositories to my laptop, and keep working
>> there. When I finish (few hours, days or sometimes weeks later), I
>> just rsync everything back to my local git repositories on my main
>> workstation, and continue working there.
>>
>> Now I was wondering whether it's OK or whether there are bad
>> implication I might not think of working this way. For example, maybe
>> some of these little git files are named differently on each machine,
>> and rsyncing them back and forth makes me piling a lot of clutter (in
>> that case maybe git-gc will clean up everything). Or maybe something
>> else horrid is going on and I really should just use git-push or pull.
>
> the git files are names by their content so you don't need to worry about
> them being named differently

But can I end up having a lot of clutter ? e.g. if these files change,
then rsync will copy the new files, and the old ones will still be
kept, piling up like crud. is this correct ? is it problematic ? will
git-gc fix it ?
