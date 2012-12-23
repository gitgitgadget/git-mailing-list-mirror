From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Sat, 22 Dec 2012 17:31:12 -0800
Message-ID: <CAJDDKr7fcz=GUs649c4pZDgV=4P_dSRtMHcczzVDvWz_L3_7uw@mail.gmail.com>
References: <1356073023-15376-1-git-send-email-davvid@gmail.com>
	<7v4njf2xrk.fsf@alter.siamese.dyndns.org>
	<CAJDDKr54XBtU4J-A8T9LwXAPL6E8M2_0kaTxH_-LZCAR0fwN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 02:31:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmaPn-00078z-2C
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 02:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab2LWBbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 20:31:14 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:59362 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab2LWBbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 20:31:13 -0500
Received: by mail-vc0-f177.google.com with SMTP id m8so6421281vcd.8
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MM01eVje1zdDFMD79aDF6rhEuYvQQXH+A+5KOudr6sk=;
        b=LEPyKMl0akDZoqbq37GWBuVkN4VVTIU1jJQhZyfGpN6/Fl455jM/wRNWMuy1SS2m19
         2H4CQfdmQ0RKWCrYbdSn+HVno7Xqryn/athqi/SZG7WMJAStY4U6UyzZcO3fiuwH8MqR
         rEJrLSOHNpDxZLB1Ju2OL+Z7991GR67A5+GDmZQ5DGKAxmXwAysaj3lZ9nxtn7AAYbsx
         sRLl6PZSFhRbbnIBWxOU05NVixeV9Z7TgsZwv/5aI/bk+hWbpPVEu5Vp+PULIBNjljJ2
         ZJDX6NKesjsxJHEr0M1EMZ4WNsLyW2mH1cQxD0E3EszGeTC35pgZqtWXOz2w50xVIckL
         BZxw==
Received: by 10.52.37.9 with SMTP id u9mr23461410vdj.83.1356226272112; Sat, 22
 Dec 2012 17:31:12 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Sat, 22 Dec 2012 17:31:12 -0800 (PST)
In-Reply-To: <CAJDDKr54XBtU4J-A8T9LwXAPL6E8M2_0kaTxH_-LZCAR0fwN+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212076>

On Sat, Dec 22, 2012 at 1:56 PM, David Aguilar <davvid@gmail.com> wrote:
> FWIW I'm seeing a "Bus Error" when doing "git update-index --refresh"
> in a repository with large files on a 32bit machine. I'm not sure if
> that counts as a regression since the same error occurs in 1.7.10.4
> (debian testing).
>
> I'll start another thread on this topic in case anyone is interested.

Nevermind.  The machine is an old salvaged laptop and its disk
probably has some bad blocks.

I wasn't able to copy the bad repo since 'cp' kept failing to
copy the index file.  I/O errors..  After deleting the borked
index the problems went away, so I'll chalk this up to
failing hardware.  Sorry for the false alarm.
-- 
David
