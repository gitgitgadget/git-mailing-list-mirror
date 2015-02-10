From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/8] reflog: fix documentation
Date: Tue, 10 Feb 2015 15:25:36 -0800
Message-ID: <CAGZ79kYsJ9Zy32LYOu=JoJ2nOYZMjTnqX_YwPZB1rSmTU5d-0Q@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLKBa-0001PE-3c
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 00:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbbBJXZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 18:25:38 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35055 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbBJXZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 18:25:37 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so999674igb.5
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 15:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wAv9MJVROCa2qcoYiFRCQ+mHQI0eMRahBdQnahtYJeI=;
        b=mcrEVX94G/Qgpa3YyjqiKYVhuJniG7wW4CstbkAdTAwSoSTIjwvjidgB2u6wGHhDWP
         Ey6WszwWOdL6TH6x5B3IuUUF+Cf/wNR26jdZHAUMzmbNt8I1aLyJZAOAsKmtgaTan1c/
         qiGfwmts+pkAtSYwFPWFCGGPNNeWPTotyvpl8SauDWOfsRRloKqqJHrfGHiau0hxciwj
         zBWD2jzIixUKxB/x66KvlU9874hAPpd+GieqqqPkd4q43XqjGKiIv5WcQ7NJZC2rkBy6
         zTorftBWrccgUZ3wJtPQjos45k80aZozThggIHI+Jphx5Njiov7rdERU2ixm6Bx7AAv9
         ZiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wAv9MJVROCa2qcoYiFRCQ+mHQI0eMRahBdQnahtYJeI=;
        b=mdsByPQc+OUh9bZ+Yr/1B4WAz7r4z6hksF6qgTLaqp/ZkBIRK4o7XAaEM02HaWR8OU
         7O5jNDk9NZmg893f17w9Ez3cOeNOFT8/zVlKk87Aq+MAPksbCAS1+Mq/ixjBISYj1t1I
         IG5ySeXVKZzWVPzjgtOuTmEb9STfBAWj/Jrts+0hW8azimXgrRHEnlQ6UE3mKIwK/sEV
         wqCsHH02p8k7vvAQX0qBB5Vvj0vxyjxsoZU0WF0y7yY9w51Q4TUE94w2UUCDr4lH6e7r
         Lq7MuZZc3xmY5FHRolUcQRbPDQY4hPaq0Zr8eN5l7Zx1uxzWSY6HaP69mERW8rpphATD
         S1HQ==
X-Gm-Message-State: ALoCoQmA97FnTphLcVc3C4i1IVk4UPBjC/Xfhqao8l24ff5BxrrD+cK9U5LE1k03Mo0pDyOyrhCi
X-Received: by 10.107.18.148 with SMTP id 20mr7592489ios.34.1423610736958;
 Tue, 10 Feb 2015 15:25:36 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 15:25:36 -0800 (PST)
In-Reply-To: <1423473164-6011-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263660>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Update the "git reflog" usage documentation in the manpage and the
> command help to match the current reality.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
