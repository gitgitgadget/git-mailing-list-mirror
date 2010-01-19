From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: undo delete of remote-tracking branch
Date: Tue, 19 Jan 2010 07:59:11 -0800
Message-ID: <20100119155911.GC23466@spearce.org>
References: <87bpgqnlws.wl%leoboiko@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leonardo Boiko <leoboiko@ime.usp.br>
X-From: git-owner@vger.kernel.org Tue Jan 19 16:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXGUD-00029f-In
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 16:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab0ASP7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 10:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173Ab0ASP7Q
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 10:59:16 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33391 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0ASP7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 10:59:15 -0500
Received: by yxe17 with SMTP id 17so5075350yxe.33
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 07:59:14 -0800 (PST)
Received: by 10.91.121.2 with SMTP id y2mr6856691agm.105.1263916754410;
        Tue, 19 Jan 2010 07:59:14 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 6sm1384597yxg.66.2010.01.19.07.59.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 07:59:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87bpgqnlws.wl%leoboiko@ime.usp.br>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137470>

Leonardo Boiko <leoboiko@ime.usp.br> wrote:
> I'm a complete idiot and just typed this:
> 
>     git branch -d -r origin/master
> 
> Is there a way to undo my act of idiocy?

git fetch origin

Which will create it again during the fetch cycle.  Unfortunately
the reflog for origin/master is gone, so you won't get results for
origin/master@{4.days.ago}.

-- 
Shawn.
