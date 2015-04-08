From: Johan Herland <johan@herland.net>
Subject: Re: Notes do not follow rebase
Date: Thu, 9 Apr 2015 00:56:18 +0200
Message-ID: <CALKQrgcvofZJNq5yQV0sohfEpVG-S=Q_26mp=vFKryrmiY9HWw@mail.gmail.com>
References: <5525763B.3020300@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 00:56:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfytc-0002y3-8n
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 00:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbbDHW41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 18:56:27 -0400
Received: from mail14.copyleft.no ([178.255.144.193]:51969 "EHLO
	mail14.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbbDHW40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 18:56:26 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail14.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1YfytU-0004d0-UF
	for git@vger.kernel.org; Thu, 09 Apr 2015 00:56:24 +0200
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1YfytU-000DqL-Kb
	for git@vger.kernel.org; Thu, 09 Apr 2015 00:56:24 +0200
Received: by pabtp1 with SMTP id tp1so23321286pab.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 15:56:18 -0700 (PDT)
X-Received: by 10.66.229.9 with SMTP id sm9mr28956508pac.1.1428533778136; Wed,
 08 Apr 2015 15:56:18 -0700 (PDT)
Received: by 10.70.83.67 with HTTP; Wed, 8 Apr 2015 15:56:18 -0700 (PDT)
In-Reply-To: <5525763B.3020300@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266977>

On Wed, Apr 8, 2015 at 8:40 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> After doing a rebase -i to fix up some older commits, I noticed that
> notes I had associated with commits failed to follow the commit across
> the rebase, so the notes are now orphaned and will be pruned.
> Shouldn't notes be copied to the new commit during an ammend/rebase?

It depends. Which notes do you want copied? (i.e. from which notes
ref?) Please have a look at the notes.rewriteRef config option
(documented in the git-config and git-notes manual pages)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
