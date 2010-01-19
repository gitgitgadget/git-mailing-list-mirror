From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: "warning: Updating the currently checked out branch may cause
	confusion" on bare repositories
Date: Mon, 18 Jan 2010 22:29:04 -0800
Message-ID: <20100119062904.GB23212@spearce.org>
References: <xuu2ska3doix.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX7aW-0001X4-28
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0ASG3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271Ab0ASG3L
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:29:11 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:46546 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab0ASG3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:29:10 -0500
Received: by iwn10 with SMTP id 10so2796673iwn.22
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 22:29:06 -0800 (PST)
Received: by 10.231.122.103 with SMTP id k39mr1025998ibr.10.1263882546748;
        Mon, 18 Jan 2010 22:29:06 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm5106152iwn.4.2010.01.18.22.29.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Jan 2010 22:29:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xuu2ska3doix.fsf@nowhere.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137429>

Adam Megacz <adam@megacz.com> wrote:
> 
> It seems that the message "warning: Updating the currently checked out
> branch may cause confusion" is unnecessary when pushing to a bare
> "myproject.git" repository (instead of a "myproject/.git" repository).
> 
> Is this the case?
> 
> If so, perhaps the warning should be omitted when the target is a bare
> repository.

That should already be the case.  Did you create the bare repository
by taking a copy of a non-bare's .git directory?  Check your bare
repository's config file and see if core.bare = false, if so set
it to true to signal it really is bare.

-- 
Shawn.
