From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 10/13] transport-helper: implement marks location as capability
Date: Sun, 29 Aug 2010 15:17:54 -0500
Message-ID: <AANLkTinOqoLbmMyzUrKZTgWh67RAYHap-4-pubuF3WOy@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-11-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.1008291536030.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:18:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpoKr-0004M6-9K
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab0H2USU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 16:18:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42044 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab0H2UST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 16:18:19 -0400
Received: by ywh1 with SMTP id 1so1420790ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=tzuTsc1L4skZ1QRYu4nNTyyAfPzfEIyGaBdL7zLfCxw=;
        b=XtCrnrlb9HXhfci0F59+kq02aZvMHJIB4u+fZ5arvPkofNstJrspRS3aNqVY68XR7s
         yweP2EMcvRPQb5P6KxrqU7qEoRGSfo2e65rDgXZZlVmSMpAJH1Hrpi784soeYwlBLY7B
         qtwWKMIEirLmFH5Sb51A18sYACa64GkBJR9kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UTbGojnmmEQ0cCr559FTTjNJcjOsaeA8o0efULXw9QgE907yF27gDLyPlcdaOoov84
         LCO6sUWxh52v0kTa7dIrCuUGYijMxmMhMcfFTfLkH/J+i4S+JPyByzal3zs5/5DJ6EF2
         /lX8vfIMn5YQBPp6Nk31crBv9k4h26PAkke2s=
Received: by 10.151.133.6 with SMTP id k6mr4205334ybn.402.1283113098817; Sun,
 29 Aug 2010 13:18:18 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 13:17:54 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008291536030.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154709>

Heya,

On Sun, Aug 29, 2010 at 14:52, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I think I was annoyed by it being ad-hoc, rather than having the exchange
> of values. I think if you need to get more information to the helper, you
> should have a generic mechanism for that, rather than anything that cares
> about the particular information involved.

Is the capability mechanism such as I used it now a good enough proxy for that?

> I'm a bit unclear on what change you're making here; it looks like the
> helper side is reading another line, but that transport-helper isn't
> writing anything new, and you don't have any changes to the documentation
> here. Did this change get mixed into a different patch or something?

Not at all. It's reading another command: the reply to the 'gitdir'
capability, being the gitdir command.

-- 
Cheers,

Sverre Rabbelier
