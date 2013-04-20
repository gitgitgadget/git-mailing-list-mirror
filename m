From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] git-log.txt: fix description of <since>..<until>
Date: Sat, 20 Apr 2013 15:25:28 -0700
Message-ID: <20130420222528.GA10043@elie.Belkin>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 00:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTgEG-00088E-O2
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 00:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737Ab3DTWZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 18:25:42 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:62434 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab3DTWZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 18:25:41 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so2454635dan.5
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 15:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vEwSly4rPwWc0qzS5lQpzkGbyRQBFS+2pK9c3zVRC0g=;
        b=N/mDKVFLx9wu8Ra8tHL2jfwhNLCOBKFT5fpUhHqAGOteBO2LTDMh6ovGZ8dJdk4f1p
         UQiZRSV/3J+c2arVD4m5N38/sNamNAv909Ii82pYnZT/W7S9uEkHRdY2kvVeCjpVTjG4
         VRv0kJh92Qh9lMbZwuKpyvR/hs8So+3Lxcr1ZqlTiiTdqQxRD7X2tIOpd02cuyBjzL/x
         a4wSWLpmHQ+qQaVVEk6zkfQ4xr7cHeO96+3DcVu0c3/NjTXlnArif8XG3PLWF034B9nz
         XM/Tf/sDoWK4NZb3eLPZOdvhh9Gk4Q1ENML0VI36AXCKZf/F1LGei+U2KlxD4yQ59qE7
         7Z5A==
X-Received: by 10.68.251.194 with SMTP id zm2mr24805874pbc.81.1366496740937;
        Sat, 20 Apr 2013 15:25:40 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vk7sm18572310pbc.41.2013.04.20.15.25.38
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 15:25:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366458313-7186-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221879>

Ramkumar Ramachandra wrote:

> First, <since> and <until> are ways to specify "revisions", not
> "commits", as gitrevisions.txt would indicate.

What's the difference between a revision and a commit?  The definition
in gitglossary(7) only confuses me.
