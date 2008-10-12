From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Sun, 12 Oct 2008 23:36:47 +0200
Message-ID: <4ac8254d0810121436x6285d17ew631f04e768a6fb62@mail.gmail.com>
References: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com>
	 <20081012200833.GC5255@spearce.org>
	 <4ac8254d0810121431v1a67afc8ua92842b3d8c39328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 23:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp8dW-0000WA-JU
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 23:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYJLVgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 17:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbYJLVgu
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 17:36:50 -0400
Received: from hs-out-0708.google.com ([64.233.178.246]:42559 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYJLVgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 17:36:49 -0400
Received: by hs-out-0708.google.com with SMTP id 4so644580hsl.5
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4/PSju/KM2CZXQ0NrXKL8xySEQ2f8FlAbL0yE34U+gs=;
        b=gRN3tJtGPmMAMd8wdt0O3jHCpHZl/RCLPurv9nt6j4CmpBKVnWBnZpC+6J/9DEjL/l
         ZGv50TayTHujLGOeCLf9Gt8GWNLJpZYkZbLD6u5IEHQeJID0Jg/PZUxwQhIngt9g9hT/
         hCdUyASN03lszDJYxQ3TrPLcryKV0C2iaQh4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Hp2SJCf8yugA4V9dyWA8/Xtxtv0EW0F+PREo/9gS+Mj2IutoDZABAiG7EIU92mZvOB
         AtPrhr35LrqJ+IuJRGZnOn9TxkYlcC2NYAN/DyROXFN6hNrzCMv2FsXN3+XdqfzmcVm5
         PPMgDZslqpYgUslygrqZdkkvZJpHRGKcuOzYo=
Received: by 10.64.242.13 with SMTP id p13mr7075452qbh.43.1223847407911;
        Sun, 12 Oct 2008 14:36:47 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Sun, 12 Oct 2008 14:36:47 -0700 (PDT)
In-Reply-To: <4ac8254d0810121431v1a67afc8ua92842b3d8c39328@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98058>

On Sun, Oct 12, 2008 at 11:31 PM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On Sun, Oct 12, 2008 at 10:08 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>
> <snip>
>
> I've incorporated all defects as noticed by Shawn and

I did of course intend to write
s/incorporated/repaired/ :-)

> thanks to him found out that the changes in
> squash_message() are definitely not needed and are
> more of a left-over of my tryout/devel session.
> Moreover I've avoided further whitespace changes.

<snip>
