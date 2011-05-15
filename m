From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: GLib
Date: Sun, 15 May 2011 19:38:40 +0200
Message-ID: <BANLkTik4ap_oBhWo4f-SQ6gKmgu98AELZw@mail.gmail.com>
References: <1305477377.3612.5.camel@mamburu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Zganyaiko Dmitry <zdo.str@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 19:38:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLfHC-0000w5-Rz
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 19:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081Ab1EORim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 13:38:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52294 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1EORil (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 13:38:41 -0400
Received: by fxm17 with SMTP id 17so2616226fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GecqMBIwrUvVRSARnoPoB8JNRHxRwXLx00WcVfHyQCA=;
        b=CUBcYBELCqlPu/6Xsi+tv8K5ACECKUPn9EdVP2QmseIg/6Cz1o1KAC0ubJTMsIjaT5
         ZnHNJ9porbqxQYhhGTn/+Azcvd5sApzISXvvl8Om+59s4k63q6R18CMxQuMZlt70X4L3
         2EzhigNtIQ9eNwcUr16NKPYXo4+/iPzghVxFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WzfoWLHRqJuIeihwWE7a7XCaH7IfBLXwg+BUSrMQQCd3NC9IA/8jVMfSniK2QV2EYO
         H5+gmqV2sPt5Jobl64yMQYix/fDOE/uYu/SjQN1R51y1MF1fbeHY1pliRlCk/s+tlWdZ
         2mzJYzP0yV8UxmeYmX/Sm09syUO/cf/AtLDGI=
Received: by 10.223.59.81 with SMTP id k17mr4338208fah.94.1305481120366; Sun,
 15 May 2011 10:38:40 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 15 May 2011 10:38:40 -0700 (PDT)
In-Reply-To: <1305477377.3612.5.camel@mamburu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173641>

On Sun, May 15, 2011 at 18:36, Zganyaiko Dmitry <zdo.str@gmail.com> wrote:

> So, why git was designed and is developing now without mature stable C
> library like glib?

Initially because it wasn't written by the sort of people who use big
C libraries when they need some relatively small functionality.

Nowadays because nobody has proposed a patch to use glib instead of
our own toolkit, and even if someone did it might be rejected.
