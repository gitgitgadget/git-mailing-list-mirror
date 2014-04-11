From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Sat, 12 Apr 2014 02:30:05 +0300
Message-ID: <20140411233005.GA14564@abyss>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
 <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
 <CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
 <xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com>
 <xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:30:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYktw-00038T-Ko
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 01:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbaDKXaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 19:30:19 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:39746 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaDKXaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 19:30:17 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so4656831eek.10
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ki6dRfQQeQliLUHREt78pMJZKEzsxEdQBq3UahtCPXw=;
        b=TO5ctdi/U9JxWWoCnsAjRfm+MpFKn//PlR45aoI0QA/8N6caBiPGEL2I3LpKiNBJjb
         f2bD8I8RAsOBq83GHWy9uvccbalpRk/x8nAL6HzmPnjthW7qjGzhFkDm977/5wT2iK5V
         Y1i8dld/iAcoticWF+Atz3lv0hBUbZhBoZGWOZ/nELd5N0kFVdZdduzbWawcrWLmDwDf
         EFiadKEDnDRIKFoHc1zXZY7ACFirS4FnRbO3IuoVWXJDFdLlFNdAYMC1Yy19CnARvE8m
         qI9j2uKKMKa5aGEMY96q/DpYDml5BLo1nCBi6ojMcrW7e77GFhkCtks5Vr2nyOppbGng
         m9YQ==
X-Received: by 10.14.214.198 with SMTP id c46mr32162654eep.29.1397259016348;
        Fri, 11 Apr 2014 16:30:16 -0700 (PDT)
Received: from abyss (87-130-173.netrun.cytanet.com.cy. [87.228.130.173])
        by mx.google.com with ESMTPSA id w1sm21033777eel.16.2014.04.11.16.30.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 16:30:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246156>

On Fri, Apr 11, 2014 at 01:43:47PM -0700, Junio C Hamano wrote:
> Having said that, nobody sane would be running two simultaneous
> operations that are clearly write-oriented competing with each other
> against the same index file.  So in that sense that can be done as a
> less urgent follow-up for this topic.

I'm willing to take this task, I decide to spend some of my free time
for git development. But since I'm a newbie with it's architecture I
don't know when it will be ready because I want to explore the code a
bit.

--
Yiannis
