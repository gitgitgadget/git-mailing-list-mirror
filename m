From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 12/14] mingw: import poll-emulation from gnulib
Date: Sun, 10 Oct 2010 14:15:00 +0000
Message-ID: <AANLkTim1BZR89M22tAkT0qtfk70QeN0QuyKi5Q2KQQKR@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
	<1286716854-5744-13-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 16:15:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4wgB-0001eY-JX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 16:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab0JJOPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 10:15:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64074 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0JJOPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 10:15:03 -0400
Received: by iwn6 with SMTP id 6so2273034iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=40nsPrzMLOkPzHbxENXEdEDY2cjtdlXA7Lg1Xs+A8d8=;
        b=eBB28KlmCxn/G1npo4G4GHUVOd1gRGabkNPq8++CPBXI7jOMpu33xg/tmz/7sCYw9j
         zhWWGvuHY+W4JSpBZZuz8EcuOJMNVU5IblCWL0JSVB4rrpU6bcFpp7lQP5iO0XHkiKqf
         6/w+DP/gwcLuECXHiYTMdluFv+9rcW4sIm250=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GsvsKOvQV9hqO0+LMxmB7dmjacPGtoztt7R+OCOVAVpn56CYa0RHqmkqnSPNk2XMIP
         q2Ji/HuB0L2RBEXEQU6K6P0b/TIJUZ6julzlVkV9synoLy9AweFfwdC32N+nwm7dsAHd
         wygiQdbZ6jzFX7IHiMsecMfoH7RpbO8zlBrPA=
Received: by 10.231.166.139 with SMTP id m11mr3937414iby.136.1286720100295;
 Sun, 10 Oct 2010 07:15:00 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 10 Oct 2010 07:15:00 -0700 (PDT)
In-Reply-To: <1286716854-5744-13-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158674>

On Sun, Oct 10, 2010 at 13:20, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> lib/poll.c and lib/poll.in.h imported from 0a05120 in
> git://git.savannah.gnu.org/gnulib.git

Having fought with importing things from gnulib myself using their
tools it would be useful to note in the commit message *how* you
imported this. Did you use the gnulib command with some archane
options so it wouldn't touch the build system while it was at it, or
did you just copy the relevant files manually?
