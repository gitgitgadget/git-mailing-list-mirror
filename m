From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/5] difftool: Eliminate global variables
Date: Mon, 23 Jul 2012 08:30:26 +0200
Message-ID: <CAHGBnuM9LgeLiOoFfny8NbF547okjQBLDXfzrbTj6vt+d=M4Eg@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<1343014940-16439-2-git-send-email-davvid@gmail.com>
	<500CEB9F.4030406@gmail.com>
	<CAJDDKr7oDc2CxoiWqUMri93FM3WHecanCYBkezLYY1A_BZXdxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:30:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCA4-0000SH-9h
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab2GWGa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:30:28 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64013 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab2GWGa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:30:27 -0400
Received: by vbbff1 with SMTP id ff1so4364214vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OS9liLUM/s5U93bkzSPFDhlEIxI6IATBsJ/yShltMo0=;
        b=FpuooG5XCO3Ff+7BfErYRO9Sh9YfZQhS6XKWId/yhwUAprNx9W8A7BYdVSMHwrAc/L
         fDceP+4+jxOPjVfbp2c8rPw4sattI/Pc7tQsnaq/SzDNrIctaFys/QJ8ai8fEYvh0J4F
         4UIZbBLBKd5uk7WfZ+shYGHRl2SLxnbFcloQtjjWMzEhPmdcmjdgYEXNU/tYjE6zVeoa
         WwHoROqzItPFf2lN2bhurH49kWiGHP2riZRyNJ8cQepzFaip68wkGfha9GAvqbdPS+LM
         gRhCMi7vIced7JBpgr7GX/XRwoW9o8HNaJcSIme+4OKDBo0t3Qp5Ip8WoXa3fIvOan3e
         8x2A==
Received: by 10.52.69.83 with SMTP id c19mr2874107vdu.79.1343025026482; Sun,
 22 Jul 2012 23:30:26 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Sun, 22 Jul 2012 23:30:26 -0700 (PDT)
In-Reply-To: <CAJDDKr7oDc2CxoiWqUMri93FM3WHecanCYBkezLYY1A_BZXdxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201910>

On Mon, Jul 23, 2012 at 8:21 AM, David Aguilar <davvid@gmail.com> wrote:

>> Funny, I just have prepared a patch along the same lines so that one can
>> call git-difftool -h and --tool-help also outside a repository, see below.
>> Does you patch offer the same? If so, I'll drop mine.
>
> It *should*. I did not consider this case but that is indeed the
> desired behavior.
>
> What my patch did not offer was a test to ensure this behavior...

Well, I'm not asking for a test. From my side, I'd be happy if you
could just try it and confirm that it works, as I currently cannot
easily apply your patch.

-- 
Sebastian Schuberth
