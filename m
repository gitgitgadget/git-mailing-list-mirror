From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: count --max-pack-size in bytes
Date: Thu, 4 Feb 2010 11:13:01 -0800
Message-ID: <20100204191301.GA18668@spearce.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net> <1265255308-20514-3-git-send-email-nico@fluxnic.net> <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org> <7vtytxexjl.fsf@alter.siamese.dyndns.org> <20100204172421.GA18548@spearce.org> <alpine.LFD.2.00.1002041249200.1681@xanadu.home> <20100204175918.GB18548@spearce.org> <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd78z-0001Cs-2c
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 20:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281Ab0BDTNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 14:13:06 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:38641 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758269Ab0BDTNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 14:13:04 -0500
Received: by gxk24 with SMTP id 24so3844200gxk.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 11:13:04 -0800 (PST)
Received: by 10.101.6.22 with SMTP id j22mr2128370ani.224.1265310783772;
        Thu, 04 Feb 2010 11:13:03 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm316275iwn.10.2010.02.04.11.13.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 11:13:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138998>

Junio C Hamano <gitster@pobox.com> wrote:
> Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
> pack-object' count in bytes, 2010-02-03) which made the option by the same
> name to pack-objects, this counts the pack size limit in bytes.
> 
> In order not to cause havoc with people used to the previous megabyte
> scale an integer smaller than 8092 is interpreted in megabytes but the
> user gets a warning.  Also a minimum size of 1 MiB is enforced to avoid an
> explosion of pack files.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> ---
> 
>  Ok, third-time lucky?  Knock wood...

Yea, I like it.  Thanks Junio.

-- 
Shawn.
