From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-svn: make it play nicely with submodules
Date: Sat, 10 Jan 2015 17:13:27 -0500
Message-ID: <CALkWK0kNZyEedL16fru+hWqw7tDz8q3ftQn4=xGUjb2qv8E4SA@mail.gmail.com>
References: <1420901711-81679-1-git-send-email-artagnon@gmail.com> <20150110221121.GA30202@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 23:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA4IQ-00017v-Eu
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 23:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbbAJWOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 17:14:09 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55570 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbbAJWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 17:14:08 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so20333672ieb.3
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ndupH3r3X86YxxYm/JaFtxEa3B2Jc5s+TaZ3fUCtiP0=;
        b=BEXh5K3IFI59+zGF/b1HXtJhmymcIEaIYTt+5pjQ1oTGrMeTK52Bycnwf7DOOCc8mv
         x1D4SYfbFW0FsMvrUHSFe6enFMjcuY28s7IE3MfpevJs/nT6MpbXgmKJfc5R7wb0Ize3
         1RHYF6o6vgmWkJq3sRDER/ZJzNqNC01NJbGAw388bxXgZ2YzAGpgt5GdCh/WBc5LIPma
         Bh3AmRH8llfM+DSXlovmz1xZU5fCYTn5S4EtmfvhzO8Ig7tj2gR0SbFJ4JRbPW6/3uA/
         u63JslYXiHxzFR/TZoFKfVXTy44CkWmmhHcclR1+TS6HHXKHcw6YtozTYQ1bxUeNh8Gh
         kB7A==
X-Received: by 10.50.117.68 with SMTP id kc4mr8848798igb.25.1420928047832;
 Sat, 10 Jan 2015 14:14:07 -0800 (PST)
Received: by 10.107.3.75 with HTTP; Sat, 10 Jan 2015 14:13:27 -0800 (PST)
In-Reply-To: <20150110221121.GA30202@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262275>

Eric Wong wrote:
> How portable is open on a directory?  Perhaps it'd be better to
> check if it's a file, first:

Sure, that works; feel free to fix it up locally before committing.
