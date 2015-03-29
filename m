From: Ivan Ukhov <ivan.ukhov@gmail.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 11:28:04 +0200
Message-ID: <0AC17F77-A324-40FA-9D5A-772C11E3BBDA@gmail.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com> <CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2093\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:28:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yc9Vx-0000DX-WC
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 11:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbbC2J2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 05:28:09 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33767 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbC2J2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 05:28:08 -0400
Received: by lbcmq2 with SMTP id mq2so89078054lbc.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 02:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fjlQDxR/cRzWw6KrnVfXTqGvSZfCzW682zkOZrmXabg=;
        b=LQ5mC0DGOm/a+ue7+mKwrBl+DWicYpdnHeNQY8uHj+R1kaXa1lG5kIhEuaCUGEnTk6
         ztxnI0+bN1iq6JvxTILRfjv9Hd8UboBAvYa7JuRBr/IqqEpaBu3Vg85KyKMsSir6yd6s
         8lvTxqyJQTMu5JfzhSG53NwFpGv7spWXSlAlbiSVR2cnPfQVG5+XsIJyzAIksySP8WHQ
         MtlcNqQIYxUinwOMLhC2WiP6ckusCTpbYGbg/tHd7wUXgYmupuq3QXv8WM1AmTrF24P1
         2JEDtyCKJK84GbXMPrFLdnMrtXhCmzGPbrjBB4cEGYEz8tlCaO59fkEnluEbW6K9ZZ5K
         Js+w==
X-Received: by 10.152.42.193 with SMTP id q1mr23660584lal.92.1427621286395;
        Sun, 29 Mar 2015 02:28:06 -0700 (PDT)
Received: from c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se (c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se. [85.228.198.21])
        by mx.google.com with ESMTPSA id t9sm1358120laz.21.2015.03.29.02.28.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Mar 2015 02:28:05 -0700 (PDT)
In-Reply-To: <CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
X-Mailer: Apple Mail (2.2093)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266433>

Hello Paul,


> On Mar 29, 2015, at 11:08 AM, Paul Tan <pyokagan@gmail.com> wrote:
> 
> Actually, it can contain a pointer for OPTION_CMDMODE, OPTION_STRING
> and OPTION_FILENAME.

I have checked the definitions of the three macros you mentioned, and it seems that none of them uses defval to store pointers. OPTION_CMDMODE stores chars and integers. OPTION_STRING does not use defval at all (pointers go in a different field of the option struct), and the same applies to OPTION_FILENAME. I am probably missing something; can you please clarify what you mean? Thank you.


Regards,
Ivan