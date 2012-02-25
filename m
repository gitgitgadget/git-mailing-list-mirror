From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 2/8] gitweb: Use print_diff_chunk() for both
 side-by-side and inline diffs
Date: Sat, 25 Feb 2012 10:00:19 +0100
Message-ID: <20120225100019.719105c4@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-3-git-send-email-michal.kiedrowicz@gmail.com>
	<m3k43ttlh9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 10:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1DUw-000388-5c
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab2BYJAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 04:00:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60547 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab2BYJAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 04:00:25 -0500
Received: by eaah12 with SMTP id h12so1377045eaa.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 01:00:23 -0800 (PST)
Received-SPF: pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.35.65 as permitted sender) client-ip=10.213.35.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.35.65 as permitted sender) smtp.mail=michal.kiedrowicz@gmail.com; dkim=pass header.i=michal.kiedrowicz@gmail.com
Received: from mr.google.com ([10.213.35.65])
        by 10.213.35.65 with SMTP id o1mr903046ebd.128.1330160423734 (num_hops = 1);
        Sat, 25 Feb 2012 01:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ndCZiPh2i9+Agv0RR9kdA154Y5rHjxd1DCMABNl3FDA=;
        b=d7kZRIcHGtqJLj4wNyi3TUgC504BSHZl0ripYU0XWol4jWcqhp9dOEqqZ2PGN1QSb1
         0u4Dsf1lpCafKNo7yn8GLKM3tpRdgTTU8QAgXKwDMWJvz+djGF7Z0lJ87v9C+uAIn9Xi
         y+hNIYsLQfgW3aaV+VDpI2esW0PAqaNuzUydU=
Received: by 10.213.35.65 with SMTP id o1mr675842ebd.128.1330160423616;
        Sat, 25 Feb 2012 01:00:23 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id s48sm28877807eem.0.2012.02.25.01.00.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 01:00:23 -0800 (PST)
In-Reply-To: <m3k43ttlh9.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191508>

Jakub Narebski <jnareb@gmail.com> wrote:

> BTW. I didn't examine the final code, but what happens for binary
> diffs that git supports?  Is it handled outside print_diff_chunk()?

gitweb doesn't produce binary diffs at all except for "?a=patch", but
it isn't HTML'ed. So I don't think there anything I can do with it.
