From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Tue, 27 Mar 2012 13:33:33 +0700
Message-ID: <CACsJy8BfCpH3jtfaOyyAgjH3P5fv4FYjboqjoFYF2GiG44TmoA@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
 <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
 <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
 <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
 <CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
 <CAKTdtZngYaTCwd5cri=XjUu3-o44ECjDotrDBNxqYL-Kcsosnw@mail.gmail.com> <CAFfmPPM_GOkOp6-tE2=YxdrZq6TL3s4EgOjXdRKf8+ffMD29xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: elton sky <eltonsky9404@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPyt-00067M-Uh
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233Ab2C0GeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:34:08 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48887 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788Ab2C0GeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:34:05 -0400
Received: by wgbdr13 with SMTP id dr13so4543802wgb.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 23:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kh2EAkTxRFaovm55yoyzRcqDWCksPFltMG/aR/LE4Lw=;
        b=pUIudufkS7tlcFwV5zpsBYCLlBIwIh5469h1TZVPs510i3O/2n6Xm4nqjNqos02yN+
         Ss8+1moDFxAHGtfr6ZKQlwURwJ8dqmZwalqjYmMpnIQKEcDEjkbF1ZGz2HtJ4nQZbf7w
         /aFL1Yqzq7ZZ3oRa6LETuWpZiXt66nDszsj14Mwoq8f+rZklo1h7qMAhneLkxCSKVSgi
         yIZKe6Wj4eZi30sgHjM+fwcg1v9U3r/Gk2oJOgwdtM2IiFXmoeU9XhRq2L5rf6u+LU46
         TQr52qGeCvHd21q0tIuntv3Iwca0BapwxcwQQMC6+UlVt8IRhqJcv5pCwlqZ9ARsgISI
         Snnw==
Received: by 10.216.135.225 with SMTP id u75mr13055722wei.97.1332830043399;
 Mon, 26 Mar 2012 23:34:03 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 26 Mar 2012 23:33:33 -0700 (PDT)
In-Reply-To: <CAFfmPPM_GOkOp6-tE2=YxdrZq6TL3s4EgOjXdRKf8+ffMD29xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194025>

On Tue, Mar 27, 2012 at 10:34 AM, David Barr <davidbarr@google.com> wrote:
> Another implementation in this general class is TinyCDB[1].
> It is <1600 lines of plain C. Too few to be complete?
> It is a derivative of DJB's CDB[2].
>
> [1] http://www.corpit.ru/mjt/tinycdb.html

"CDB is a constant database, that is, it cannot be updated at a
runtime, only rebuilt.". It does not sound promising to me. I have not
read the description carefully though.

> [2] http://cr.yp.to/cdb.html
-- 
Duy
