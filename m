From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 7 May 2014 14:28:59 +0200
Message-ID: <CALKQrgefFQF-6ND9+wb8PXZs+vZMfqEdzgRieOYCUCGOs8u2-A@mail.gmail.com>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
	<CALKQrgc=Xa767S8ZTTYnXjHTfLOg_fDG+aT4cVqpvx4HMhO03Q@mail.gmail.com>
	<536a14f9de982_675a167130cb4@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 14:29:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi0yE-0003xv-JI
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 14:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbaEGM3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 08:29:06 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:50735 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaEGM3F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 08:29:05 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Wi0y7-0005Uk-CF
	for git@vger.kernel.org; Wed, 07 May 2014 14:29:03 +0200
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Wi0y7-0009cB-3o
	for git@vger.kernel.org; Wed, 07 May 2014 14:29:03 +0200
Received: by mail-oa0-f44.google.com with SMTP id i11so1102105oag.3
        for <git@vger.kernel.org>; Wed, 07 May 2014 05:28:59 -0700 (PDT)
X-Received: by 10.60.140.201 with SMTP id ri9mr2093080oeb.74.1399465739334;
 Wed, 07 May 2014 05:28:59 -0700 (PDT)
Received: by 10.182.245.10 with HTTP; Wed, 7 May 2014 05:28:59 -0700 (PDT)
In-Reply-To: <536a14f9de982_675a167130cb4@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248300>

On Wed, May 7, 2014 at 1:11 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Johan Herland wrote:
>> On Wed, May 7, 2014 at 12:03 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > It's better if all our scripts use the same '/usr/bin/env python'.
>>
>> Only if they are source compatible with both Python2 and Python3. See
>> PEP394 <URL: http://legacy.python.org/dev/peps/pep-0394/ >. Otherwise
>> (for python2-only scripts) '/usr/bin/env python2' is the way to go.
>
> It doesn't matter. People and aistributions have to change them anyway.

No, that's _exactly_ what PEP394 addresses. If we standardize on
'/usr/bin/env python2' (I assume all our .py scripts are Python2) then
they should work on _all_ distros, and Arch Linux would not have to do
their current python -> python2 hack (which you referred in another
thread).

If we instead standardize on '/usr/bin/env python' instead, we only
end up annoying forward-looking distros that (want to) enable python
== python3 (but obviously also provide python2 for as long as
necessary).

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
