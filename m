From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Smart-http: check if repository is OK to export before
	serving it
Date: Tue, 29 Dec 2009 07:00:16 -0800
Message-ID: <20091229150016.GA6152@spearce.org>
References: <20091228170811.GE2252@spearce.org> <1262036940-9678-1-git-send-email-tarmigan+git@gmail.com> <7vy6kmjfwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 16:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdYf-000566-9s
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 16:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZL2PAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 10:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbZL2PAV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 10:00:21 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41108 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbZL2PAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 10:00:20 -0500
Received: by yxe17 with SMTP id 17so10098040yxe.33
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 07:00:19 -0800 (PST)
Received: by 10.101.182.33 with SMTP id j33mr10443452anp.114.1262098819342;
        Tue, 29 Dec 2009 07:00:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm11947370iwn.6.2009.12.29.07.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 07:00:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vy6kmjfwo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135803>

Junio C Hamano <gitster@pobox.com> wrote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> writes:
> 
> > Similar to how git-daemon checks whether a repository is OK to be
> > exported, smart-http should also check.  This check can be satisfied
> > in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
> > may be set to export all repositories, or the individual repository
> > may have the file git-daemon-export-ok.
> >
> > Acked-by: Shawn O. Pearce <spearce@spearce.org>
...
> Looks sane to me, although I am afraid that I am not as familiar with the
> codepath involved as I should be.  Shawn, is your Ack still good?

Yes, my ACK is still good.  :-)

-- 
Shawn.
