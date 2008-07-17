From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Contributors, please check your names
Date: Thu, 17 Jul 2008 07:49:48 -0700 (PDT)
Message-ID: <m3sku8sh01.fsf@localhost.localdomain>
References: <7v8ww0j4ye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:51:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUp4-0001He-1z
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbYGQOuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758183AbYGQOuB
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:50:01 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:46264 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbYGQOt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:49:59 -0400
Received: by ti-out-0910.google.com with SMTP id b6so3363844tic.23
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=30b8AJpUiPXnCT2Yg8KwaGvdyCTdQdsGVeKx5oJSzSU=;
        b=i7g96wjep2suGfIlC5ahncroYy6vsBTTtRN4jVEyilcgbTpFrGsSrtzNMfiMahEf7E
         uUr2nUu1Amsno7NEuZS1xvTM1Kagfymm+rv6g2S84TQo5mOrh2vjIrXQHMElE23D4YZ5
         ygefG9rBbQbtKv5IzpenoZiePOjNIhWBFXLeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HC77bGkTn1RCJYTyvxshtCfHT8np77hZ5fT1lhkPHStiC6sOO1HcXMJ7vz7BVk0znR
         o0PE15coYdhqlc0rGBY1A/25cWj5hFR6jCEbVq4uG8LcYKaUh+qOnwxiYoJ1EdrKZTP7
         GqCoFPNe6jE6IHKMqAmfiNwUozc8RUqVETWT4=
Received: by 10.150.192.7 with SMTP id p7mr547706ybf.91.1216306196619;
        Thu, 17 Jul 2008 07:49:56 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.74])
        by mx.google.com with ESMTPS id m30sm15130elf.12.2008.07.17.07.49.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 07:49:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6HEnKVk011521;
	Thu, 17 Jul 2008 16:49:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6HEnJ9V011518;
	Thu, 17 Jul 2008 16:49:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8ww0j4ye.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88860>

Junio C Hamano <gitster@pobox.com> writes:

> There is a "mailmap" mechanism to consolidate them; it allows us to
> specify what human-readable name should be used for given e-mail address.
> The hypothetical Mr. Thor might want to say "I am A. U. Thor; some commits
> from me, <author@example.xz>, are marked without abbreviating periods in
> my name", and we can add this entry to the toplevel .mailmap file to fix
> it:
> 
> 	A. U. Thor <author@example.xz>
> 
> It tells the shortlog (and --pretty=format:%aN in recent enough git)
> mechanism to give huma readable name "A. U. Thor" anytime it sees
> <author@example.xz> e-mail address, regardless of what the Author:
> header in the commit object says.

What about if some authors use different _email_ address, instead?
Is there any way for shortlog to consider them the same?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
