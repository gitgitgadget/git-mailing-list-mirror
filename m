From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 21:03:42 -0400
Message-ID: <513E7EEE.3060107@gmail.com>
References: <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com> <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de> <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com> <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de> <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com> <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de> <20130312010114.GA21026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Max Horn <max@quendi.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 02:08:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFDi2-0003QP-7k
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 02:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab3CLBI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 21:08:27 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54981 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3CLBI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 21:08:27 -0400
Received: by mail-ie0-f177.google.com with SMTP id 16so5715080iea.36
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 18:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FMVC5gKKL8Z4agWQ64oU86wtK+DCyyvwvBEhG1+6hoA=;
        b=ZMT7aY8z02eARRhvWYgk4aDfBbd+19FBKCtEAAau2Pw/7jOCihe3o4xMhgoM73+n31
         PwrP/Zfxv0+rXSq/9JdkFjSgpoa4HL/eCIahfqIs+NIFeokka9Az9io2RPsUT/bHuhjn
         +XPxTn08YIFntIqMraYDX7ZSpyjYW/MBUYgB0CQr4Ld5AIuUUMiZ5cYfyQ0N1xzIAy8C
         dwXOsqdmOt8o1O2Ac2zjQwI06t8u4zoOH9JyokJxmvzbl96ZfwCCtpeOS3KXW46n3CXq
         pxnx7+I8gjpc7Qbo2ZiyVKh2k4M1v4MLptxBIApYGw+ZE+VhoXr9SfPX954Z0L1GMzK+
         FgVA==
X-Received: by 10.50.152.173 with SMTP id uz13mr9759844igb.106.1363050506547;
        Mon, 11 Mar 2013 18:08:26 -0700 (PDT)
Received: from [192.168.1.4] ([69.165.234.69])
        by mx.google.com with ESMTPS id gy3sm17662662igc.10.2013.03.11.18.08.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 18:08:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121202 Thunderbird/10.0.11
In-Reply-To: <20130312010114.GA21026@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217931>

On 03/11/13 21:01, Jeff King wrote:
> From "git help config":
>
>   core.trustctime
>     If false, the ctime differences between the index and the working
>     tree are ignored; useful when the inode change time is regularly
>     modified by something outside Git (file system crawlers and some
>     backup systems). See git-update- index(1). True by default.
In an earlier email, Max did mention setting the config does workaround
the issue. But it's still strange that it only happens to a few specific
files in this particular repo. The issue never popped up in other repos
that he has, which I assume has all been excluded from Time Machine...
