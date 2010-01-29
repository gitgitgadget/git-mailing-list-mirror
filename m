From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] request-pull: avoid mentioning that the start point is
	a single commit
Date: Thu, 28 Jan 2010 17:19:38 -0800
Message-ID: <20100129011938.GC20488@spearce.org>
References: <20100129011817.GT12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 02:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NafWZ-0006oO-Fy
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 02:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0A2BTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 20:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756589Ab0A2BTm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 20:19:42 -0500
Received: from mail-iw0-f172.google.com ([209.85.223.172]:35708 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab0A2BTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 20:19:41 -0500
Received: by iwn2 with SMTP id 2so749302iwn.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 17:19:41 -0800 (PST)
Received: by 10.231.153.205 with SMTP id l13mr181548ibw.64.1264727980923;
        Thu, 28 Jan 2010 17:19:40 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm759814iwn.1.2010.01.28.17.19.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 17:19:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100129011817.GT12429@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138290>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> Previously we ran shortlog on the start commit which always printed
> "(1)" after the start commit, which gives no information, but makes the
> output less easy to read. Avoid doing so.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Nice fix, that was annoying me too, but I didn't care enough to
write a patch.  :-)
 

> -git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
> +git log --max-count=1 --pretty=format:"  %an: %s%n%n" $baserev

-- 
Shawn.
