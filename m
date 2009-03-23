From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/4] builtin-fast-export.c: fix crash on tagged trees
Date: Mon, 23 Mar 2009 02:01:03 +0100
Message-ID: <40aa078e0903221801o1ffd9fa2l3f7939d702440c3a@mail.gmail.com>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
	 <1237758620-6116-2-git-send-email-kusmabite@gmail.com>
	 <1237758620-6116-3-git-send-email-kusmabite@gmail.com>
	 <7vab7d9in4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 02:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYZA-0004Ed-D9
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 02:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbZCWBBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 21:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756979AbZCWBBI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 21:01:08 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:36433 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864AbZCWBBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 21:01:06 -0400
Received: by ey-out-2122.google.com with SMTP id 4so464548eyf.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=90ngshFD7A4TVIk4s3qcFtS+pPnTM6Bk/oB4WV9SogI=;
        b=KpioEIPhFmFXUhozgMGtXt6fMQS8UUIwcT2OJHJZpUdxzDmiMsCWuvBTtRCFsVmwQZ
         0qhzJ7ufekHM/ovfyD29vYCBMT+AQoMezZ3kwXBdRkWkGgmbOgSFl1Yl95VFw+MKrbtz
         1FF7DaAlhGQ1ydkyZY2RcMWE5TIbkY3C1UVzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K0uQXkJ1gcmK0DI9lHVY6/XMOgXNjlF9RC6SvsfRZyJGJsMJYzySV9dsGlieriyTDO
         Ya/ASgQ6lIcg32+8cApl0fH6vDGsOCh+DWbysPvZ1nG1WhrcilaA1Gq2ZsaN68f+arxa
         MiQA4aorbxRb76c6PnU5TeZ3bYKABzzJbchis=
Received: by 10.210.54.15 with SMTP id c15mr666315eba.16.1237770063849; Sun, 
	22 Mar 2009 18:01:03 -0700 (PDT)
In-Reply-To: <7vab7d9in4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114222>

> The comment is good but only if you make this the last patch that comes
> after the one that actually fixes the tag-to-tag (currently 4/4), no?

Ah, good catch! I'll reorder the commits. The order of the last two
patches isn't really important, so if it makes the comment more
senseful, I'm all for it ;)


-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
