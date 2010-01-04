From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3] Smart-http documentation: add example of how to
	execute from userdir
Date: Mon, 4 Jan 2010 06:06:16 -0800
Message-ID: <20100104140616.GB22872@spearce.org>
References: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com> <1262467101-5755-1-git-send-email-tarmigan+git@gmail.com> <7vzl4v1t91.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 15:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRnZt-0000Jd-86
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 15:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0ADOGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 09:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254Ab0ADOGW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 09:06:22 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:35420 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab0ADOGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 09:06:21 -0500
Received: by ywh6 with SMTP id 6so15323214ywh.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 06:06:19 -0800 (PST)
Received: by 10.101.117.19 with SMTP id u19mr346930anm.79.1262613979564;
        Mon, 04 Jan 2010 06:06:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm17642557iwn.7.2010.01.04.06.06.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 06:06:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzl4v1t91.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136114>

Junio C Hamano <gitster@pobox.com> wrote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> writes:
> 
> > Smart-http may be an attactive and easy way for people to setup git
> > hosting on shared servers whose primary web server configuration they
> > do not control.  To facilite this, provide an example of how it may be
> > done.
> >
> > cc:  Tay Ray Chuan <rctay89@gmail.com>
> > cc: Shawn O. Pearce <spearce@spearce.org>
> > Editing-by: Tay Ray Chuan <rctay89@gmail.com>
> > Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
> 
> I still see Cc: here; are people named above (and others commented on
> earlier versions) happy with this round?

I don't get why Options +SymLinksIfOwnerMatch is needed here.

If we are linking to the root installed git-http-backend Apache
will actually reject the link, because the link owner is likely to
be $USER while the target is owned by root.

So I really can't ACK this, the instructions don't jive with my
understanding of the Apache configuration.

-- 
Shawn.
