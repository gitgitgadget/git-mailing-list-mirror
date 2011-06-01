From: Arnaud Lacurie <arnaud.lacurie@gmail.com>
Subject: Re: git annotate with date option not working?
Date: Wed, 1 Jun 2011 11:41:12 +0200
Message-ID: <BANLkTik2bTqScNLRwRwdz3h=cPJJxX6v2Q@mail.gmail.com>
References: <4DE5F655.9020400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Chengwei Ding <waterding@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 11:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRhvv-0007RR-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 11:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117Ab1FAJlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 05:41:37 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41878 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161096Ab1FAJld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 05:41:33 -0400
Received: by vxi39 with SMTP id 39so3938461vxi.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9P5ltbwhEmYEjXi4trOMHN2JIpZAOOkvSmmArQeANnw=;
        b=AWAL5I/ef+DXUhtBZTjVrxqYMiVm0YlzjZw/TMijzRPNEah9q+qZ72HItaaHvX74pK
         18bu0cArUOh0B5MkqM5rOdTkMzaijzxifnzF7QH4/zto9pZRyboSu5OS/xnd60VFk9d7
         46I/fnIXEXOXcpuGk7Q6KxfQYmkERfJ3ULC78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=q64IOm3SpFgqGkx47tKVnr0bik4sfOvXr73RecpThjKIQzuaYIfxvgxMTv/RI90VBo
         vP+/WBN5Y1BrX8jSr3pSOtufXyi0UdcfMkFaGEXTCLDuLQXuuooRtKshHJeJrWJkb7A/
         rwrcV7dm0UrN14EhcYNuE57dzE0MmX3W244/A=
Received: by 10.52.99.38 with SMTP id en6mr905855vdb.301.1306921292051; Wed,
 01 Jun 2011 02:41:32 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Wed, 1 Jun 2011 02:41:12 -0700 (PDT)
In-Reply-To: <4DE5F655.9020400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174858>

Hi,

> can anyone confirm that this "--date" option is working for git annotate
> cmd.

I tried 'git annotate --date=relative <onefile>' and it works perfectly here.
git version 1.7.4.1
ubuntu 11.04

It works also well on the git version 1.7.5.3.401.gfb674 (The latest on master)

Regards

-- 
Arnaud Lacurie
