From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cannot pread pack
Date: Wed, 4 May 2011 06:55:52 -0700
Message-ID: <BANLkTi=FDah2SGKzXWxsAv-xxH0SYirt9w@mail.gmail.com>
References: <60260.35977.qm@web27605.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: richard parkins <p1rpp@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Wed May 04 15:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHcYs-0006Nj-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 15:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1EDN4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 09:56:14 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54569 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab1EDN4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 09:56:13 -0400
Received: by vxi39 with SMTP id 39so1197805vxi.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 06:56:12 -0700 (PDT)
Received: by 10.52.73.196 with SMTP id n4mr1429920vdv.145.1304517372077; Wed,
 04 May 2011 06:56:12 -0700 (PDT)
Received: by 10.52.161.169 with HTTP; Wed, 4 May 2011 06:55:52 -0700 (PDT)
In-Reply-To: <60260.35977.qm@web27605.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172743>

On Wed, May 4, 2011 at 02:31, richard parkins <p1rpp@yahoo.co.uk> wrote:
> fatal: cannot pread pack file: No such file or directory
> fatal: index-pack failed
>
> I'm running under SUSE 11.1 Linux 2.6.27.39-0.2-default #1 SMP 2009-11-23 12:57:38 +0100 x86_64 x86_64 x86_64 GNU/Linux using git version 1.6.0.2, which is the latest built release for SUSE 11.1.

Upgrade Git. The pread() bug was fixed post 1.6.0.2, I don't remember
what version, but I would suggest moving to one of the later 1.7.x
releases.

-- 
Shawn.
