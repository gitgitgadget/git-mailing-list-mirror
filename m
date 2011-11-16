From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 11:11:23 +0400
Message-ID: <CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
	<CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
	<7v1ut9uglb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 08:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQZea-0001y6-Pj
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 08:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab1KPHLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 02:11:24 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58793 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1KPHLX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 02:11:23 -0500
Received: by ggnb2 with SMTP id b2so8411286ggn.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 23:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0g2z6uvtBvwJgw0R4bC7J40z8FjxS4jiLIEDDJtQzWo=;
        b=jbg7STgztln0HIdFGZY9YTMzrDrkvkCW9c/epFCfemFMH/R0YVTbur2IQQHjRu+x7W
         hzV/fpV1yFIC6EU8fQDVliEX5Hk3mbtlVKkrGPye2kil7aiVmJv6yr1OuHQCpK2Kkr1K
         5uNnHsQcZ6qN/l063GKEPcJU3+Xxa/kLc/UaA=
Received: by 10.68.25.198 with SMTP id e6mr66014537pbg.19.1321427483074; Tue,
 15 Nov 2011 23:11:23 -0800 (PST)
Received: by 10.68.66.230 with HTTP; Tue, 15 Nov 2011 23:11:23 -0800 (PST)
In-Reply-To: <7v1ut9uglb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185515>

2011/11/16 Junio C Hamano <gitster@pobox.com>:
> $ git ls-remote https://git.kernel.org/pub/scm/git/git.git |
> =A0grep -e HEAD -e master

in my case this command produce no output.

What if problem is caused by curl or TLS lib (libcurl-gnutls?) which
is used by my git? Is there any to log something from git-remote-https
?

Dmitry
