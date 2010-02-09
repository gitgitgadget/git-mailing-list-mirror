From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 6/6] receive-pack: Send hook output over side band #2
Date: Tue, 9 Feb 2010 09:20:27 -0800
Message-ID: <20100209172027.GC26964@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org> <1265403462-20572-7-git-send-email-spearce@spearce.org> <20100209165207.GA12030@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetlN-0000xo-E9
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0BIRUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 12:20:32 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:51085 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab0BIRUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:20:31 -0500
Received: by iwn1 with SMTP id 1so3683492iwn.24
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:20:30 -0800 (PST)
Received: by 10.231.161.143 with SMTP id r15mr1455688ibx.62.1265736030659;
        Tue, 09 Feb 2010 09:20:30 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm188896iwn.4.2010.02.09.09.20.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:20:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100209165207.GA12030@cthulhu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139419>

Larry D'Anna <larry@elder-gods.org> wrote:
> 
> This breaks t5401.  See <7v4olqlva7.fsf@alter.siamese.dyndns.org> in another thread.

No.  Your patch causes t5401 to break.  If you apply this series on
top of maint, its fine.  If you merge this series into master, and
correctly fix the Win32 merge conflict in run-command.c, its fine.

/me goes to look at your series, to see if I can figure out what
broke along the way.

-- 
Shawn.
