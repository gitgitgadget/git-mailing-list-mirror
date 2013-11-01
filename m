From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc0
Date: Fri, 1 Nov 2013 17:39:02 +0700
Message-ID: <CACsJy8AynEEkGR5Yj6SdzRw4Gc7=z9zekTi2jCBkK41R_eOY2w@mail.gmail.com>
References: <xmqqtxfy9zee.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Nov 01 11:39:49 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VcC8m-0005Fo-Tb
	for glk-linux-kernel-3@plane.gmane.org; Fri, 01 Nov 2013 11:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab3KAKje (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 1 Nov 2013 06:39:34 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:37909 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3KAKjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Nov 2013 06:39:33 -0400
Received: by mail-qc0-f176.google.com with SMTP id s19so2374288qcw.35
        for <multiple recipients>; Fri, 01 Nov 2013 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NeA0LkTQyRXRE5nvuD9GmA3WWz21otHPM5W4ClGelS0=;
        b=AIoX58CJIwGjD804xmaOfqqKSdilzQ9FjwLeNG3JHQBYqcH6Eovru6zjXJFoOs1NOL
         2SNZZ/BM109k7IAvMwrq1p0gKxIb4hYYFeXZegQ/uO/w5jeiE6ODS4IRwQCsfdj+lpqN
         HErO3NK9Ao39Qw9J34RJ+0PEApPLfmLZvzAL5GznEdlZjdaiCS7QI/vvqEDLH0zGztev
         n8h0E0YdaMEdcn6Jg3tAbqOJaOsBaYJ1o9olg4yIg75ZDt1Zdn76U4uzb5YdTq1TLB00
         npYOecil50mEPB7rcYxpRPjKwI+3/kOrB7o6ghe9ECczrGdGUAbi/Dp8lLhQZ5Z8i9d/
         T61A==
X-Received: by 10.224.88.193 with SMTP id b1mr2937720qam.81.1383302372314;
 Fri, 01 Nov 2013 03:39:32 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Fri, 1 Nov 2013 03:39:02 -0700 (PDT)
In-Reply-To: <xmqqtxfy9zee.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237206>

On Thu, Oct 31, 2013 at 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Magic pathspecs like ":(icase)makefile" that matches both
>    Makefile and makefile can be used in more places.

":(glob)foo/**/bar" is another nice thing that could be announced.
-- 
Duy
