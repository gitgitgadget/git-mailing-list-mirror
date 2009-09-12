From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v7 4/6] fast-import: test the new feature command
Date: Sat, 12 Sep 2009 21:31:46 +0200
Message-ID: <fabb9a1e0909121231l7586bb5cn90f3153e22988f42@mail.gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-4-git-send-email-srabbelier@gmail.com> <1252247748-14507-5-git-send-email-srabbelier@gmail.com> 
	<20090912185212.GR1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmYKU-000615-Sb
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbZILTcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbZILTcE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 15:32:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:35311 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbZILTcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 15:32:03 -0400
Received: by ey-out-2122.google.com with SMTP id 25so398291eya.19
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=BCXMdlNirw+lNtU+iWziYsfMxYLITcxqSfgTWe9ZudU=;
        b=geNm/xYoeOxMObqPfffpB/P9cnuKeZCdJr5lHOVaPU2pbXP6kf2PVUjRnCn6sEzZXg
         GoI4p8zNpGLOIG1fa3CFf2J9WPLSUmnb0wdZufZGCz1HW0FbnWHDYTL+XvpXafzYGw1P
         D3fb1jzlTw4gy/QhRrUqVs0jlese+PSnwga8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tQLJRgLJByX8qsmINb250UY6CdBzz+02dksY9zZ1Quhgqccohnll/2sNdcj2t9IpMt
         KNDL2zOl6yO24+3sxtjSktVWvzeMWblmaqM+KNH/wRP7LaW4adJXFoK9CrWd8U7gmn3j
         Uw+Gwq79PivJ6WyXdfTjK2AD1ih2Wy10ZkSTA=
Received: by 10.216.1.21 with SMTP id 21mr536129wec.70.1252783926116; Sat, 12 
	Sep 2009 12:32:06 -0700 (PDT)
In-Reply-To: <20090912185212.GR1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128289>

Heya,

On Sat, Sep 12, 2009 at 20:52, Shawn O. Pearce <spearce@spearce.org> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Test that an unknown feature causes fast-import to abort, and that a
>> known feature is accepted.
>
> This should be squashed with the prior patch.

Is that still possible since the series is in next now? Also, with the
series being in next, should I send incremental patches?

-- 
Cheers,

Sverre Rabbelier
