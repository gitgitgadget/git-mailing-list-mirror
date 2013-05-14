From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe: make error messages more consistent
Date: Tue, 14 May 2013 23:45:27 +0530
Message-ID: <CALkWK0nDU4o4HT6FXc_z=5DfZzQgexFYLWMLh4+3tevW+VXwBg@mail.gmail.com>
References: <1368540973-25830-1-git-send-email-artagnon@gmail.com> <7vsj1pjvyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJlm-0004mc-B0
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab3ENSQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:16:09 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:49173 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab3ENSQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:16:08 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so1725056iec.20
        for <git@vger.kernel.org>; Tue, 14 May 2013 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=OlEbY4lazyLnZXuehtRp4GRkgEhhKQdr3OfeVaM+DzY=;
        b=yDfc/AnVFM4yfWfr/CR0groZF9eNniQzFDJ8Yfmt4UWCNtyO+D5sVtVTNv8dDXxDTK
         xZMj1gignCM1TMuX82BlfMHXtkn6SGdbQE0GSJPTEJp0X/3Hz9XkruDmj0L4oTbPFbdU
         1w2mBNuA1F60w2uWn9AAusNcquac/S5ebDfHN2LchBbS5/yYO9Yxci1vIZWWsQIqnOF/
         ca3Suu3Gwyx2mzdyh9xPFXkY/cJPp4Qsi8alS0qTlU4eCud7AwPispI/0fzeEupNGlkK
         WV4VAXsHvbeYTl2Sja8n0gRry8gh6hfKdB4j4Jx0NOYXpi5HKcHohJDGq7kjtP086Gh5
         XBAg==
X-Received: by 10.50.73.65 with SMTP id j1mr3060396igv.49.1368555367331; Tue,
 14 May 2013 11:16:07 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 11:15:27 -0700 (PDT)
In-Reply-To: <7vsj1pjvyz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224309>

Junio C Hamano wrote:
> I am debating myself if it is truly easier to explain for users that
> "-G" is a different variant of pickaxe.

Hm, I think it is the correct approach because readers of diffcore are
probably going to look at the source: it's not exactly an end-user
manpage.  I've not explained it as G king versus S kind in the
diff-options documentation.

Or are you just talking about the error message?  That's simple:
--pickaxe-regex is what triggers this off, and we've made it clear
that it applies to both commands (-G implicitly; see doc).
