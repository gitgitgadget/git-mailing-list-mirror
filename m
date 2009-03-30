From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Add diffuse as merge and diff tool
Date: Sun, 29 Mar 2009 21:55:23 -0700
Message-ID: <20090330045522.GA8308@gmail.com>
References: <49CEA3E2.9020805@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 06:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9Xr-0003Eo-1n
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 06:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbZC3Eyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 00:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZC3Eyt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 00:54:49 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:41091 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZC3Eys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 00:54:48 -0400
Received: by qyk16 with SMTP id 16so3304806qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OZcgb2eOo+hXBbJoeZrD3SsTaGejEjop0ZA1OhDvCDE=;
        b=l/sA8cYWGH88khqeD2v7rwqXQCDV8vLQX20iOQYQtmHaSJhzzbND6eurtx50vRt6CH
         jKHAASzi32w2MwWJmQksFOU//E1kwETeOGuKwPVyFeLMff9XKJs6N/Patt8cZDNTp+67
         68RdIwMi4KvOFlEIshpK8tX1QNZEJRfZwaxJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dzoZoJzrmEZVxx9F3nHkqhGIaZ1T0ty73V9QrVFHiywGoCvoKJGV81IsPAcH6J//Gj
         PPVhIu9GyLU26y9EsCZtiiDYzYlay9SKnd640300m8n6DXlvkwHE2xWRj+bZljkdCzu1
         2vlPoqwfcNvk8Wnv+py2eyAEBlCKdnItC3VCQ=
Received: by 10.224.74.9 with SMTP id s9mr5528445qaj.321.1238388885754;
        Sun, 29 Mar 2009 21:54:45 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 26sm5383192qwa.42.2009.03.29.21.54.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 21:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49CEA3E2.9020805@hartwork.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115064>


Hi

On  0, Sebastian Pipping <webmaster@hartwork.org> wrote:
> 

> From e54c153a67cef9b162eb51f4b7cefb65e59c3a13 Mon Sep 17 00:00:00 2001
> From: Sebastian Pipping <sebastian@pipping.org>
> Date: Thu, 26 Mar 2009 20:42:31 +0100
> Subject: [PATCH] Add diffuse as merge and diff tool
> 
> ---
>  Documentation/git-mergetool.txt        |    3 ++-
>  Documentation/merge-config.txt         |    7 ++++---
>  contrib/completion/git-completion.bash |    3 ++-
>  contrib/difftool/git-difftool-helper   |   12 ++++++++----
>  contrib/difftool/git-difftool.txt      |    4 ++--
>  git-gui/lib/mergetool.tcl              |    7 +++++++
>  git-mergetool.sh                       |   15 ++++++++++++---
>  7 files changed, 37 insertions(+), 14 deletions(-)


Hey, thanks for the patch.
Ouch.. too many places with duplicated information, huh?

I'm in the middle of refactoring git-(diff|merge)tool so that
there is less duplication of code.

Junio also has a number of difftool-related patches in his
proposed-updates "pu" branch.

Sebastian, would you mind if I rebased your patch on top of my
work (once I send it out) so that it makes things easier on
our kind maintainer?  I have a big patch series coming down that
does away with the redundancies so I think it'd be best if we
transfered your changes on top of it.  Would you mind if I
rebased your patch and sent it out to the list?

It wouldn't be until much later tonight (or tomorrow) at the
earliest since I have some unpacking to take care of but if
that's cool with you just let me know.

You should see the refactoring patches from me shortly...



-- 
		David
