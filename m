From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: failing to send patches to the list
Date: Fri, 13 Jul 2007 14:57:36 +0200
Message-ID: <81b0412b0707130557g6cf04365j232654734b148c3f@mail.gmail.com>
References: <20070713093050.GA18001@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "martin f krafft" <madduck@madduck.net>
To: "git discussion list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 14:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9KiM-000385-N9
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 14:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758674AbXGMM5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 08:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758272AbXGMM5j
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 08:57:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:50279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbXGMM5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 08:57:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so557970ugf
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 05:57:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MLLIewjpjBYoxqkZAh0TRzgoUa/5AQkSKUyUN7cBWCgWBMzB91g8Vuxe22SXa8qU8bWi+Vqew0YybnCPNzDABuNE0FGYuzOcFTgDRfROpfJOWw2WaG5wS4sQCoH5tQtGDg1TlyeycrVQfJUQT9Ei0xPyJzrIDzbxPgRjtRoOi0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XWVtFDnlan6Jga7o/zJJLqUZXoGzPfy8ZcyOxNvKBIe6xVv3Dwnh8rb1T5FKKYNt1JWKdURNYFDC0rmZsY5e76CxpmFUvpv+/72UWgmDSjRukue2Zu/tn9n3I/5UvE3XPPUfUHFszd9lkUt7KCSB9zO8rb4x+CVCf0zuG++3EJ4=
Received: by 10.78.153.17 with SMTP id a17mr467513hue.1184331456582;
        Fri, 13 Jul 2007 05:57:36 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 13 Jul 2007 05:57:36 -0700 (PDT)
In-Reply-To: <20070713093050.GA18001@lapse.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52390>

On 7/13/07, martin f krafft <madduck@madduck.net> wrote:
> attached you may find two patches, which I've previously sent to the
> list with
>
>   git format-patch -s --stdout | sendmail git@vger.kernel.org
>

I suggest you try "git format-patch -s --stdout |less" before sending
format-patch without parameters produces nothing.

Even assuming you run something like "git-format-patch start.."
(note the range specification), its output is NOT what sendmail
can use (unless you have a special sendmail which understands
mboxes).
