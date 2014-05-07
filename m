From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 7 May 2014 12:27:14 +0200
Message-ID: <CALKQrgc=Xa767S8ZTTYnXjHTfLOg_fDG+aT4cVqpvx4HMhO03Q@mail.gmail.com>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 12:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whz4O-0004FJ-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 12:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbaEGK1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 06:27:21 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:50056 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbaEGK1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 06:27:20 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Whz4I-0007nx-96
	for git@vger.kernel.org; Wed, 07 May 2014 12:27:18 +0200
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Whz4H-0006Sk-UK
	for git@vger.kernel.org; Wed, 07 May 2014 12:27:18 +0200
Received: by mail-oa0-f48.google.com with SMTP id i4so928400oah.21
        for <git@vger.kernel.org>; Wed, 07 May 2014 03:27:14 -0700 (PDT)
X-Received: by 10.182.97.1 with SMTP id dw1mr43717749obb.23.1399458434144;
 Wed, 07 May 2014 03:27:14 -0700 (PDT)
Received: by 10.182.245.10 with HTTP; Wed, 7 May 2014 03:27:14 -0700 (PDT)
In-Reply-To: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248294>

On Wed, May 7, 2014 at 12:03 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> It's better if all our scripts use the same '/usr/bin/env python'.

Only if they are source compatible with both Python2 and Python3. See
PEP394 <URL: http://legacy.python.org/dev/peps/pep-0394/ >. Otherwise
(for python2-only scripts) '/usr/bin/env python2' is the way to go.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
