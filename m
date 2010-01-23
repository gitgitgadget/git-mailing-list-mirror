From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (resend 3)] git gui: Use git diff --submodule when
	available
Date: Sat, 23 Jan 2010 14:34:58 -0800
Message-ID: <20100123223458.GB12679@spearce.org>
References: <4B5B725C.6060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYoZS-0005bW-Cy
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0AWWfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367Ab0AWWfE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:35:04 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:65208 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0AWWfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:35:01 -0500
Received: by iwn16 with SMTP id 16so1113611iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:35:00 -0800 (PST)
Received: by 10.231.153.69 with SMTP id j5mr7573555ibw.33.1264286100744;
        Sat, 23 Jan 2010 14:35:00 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm3240988iwn.7.2010.01.23.14.34.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:34:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B5B725C.6060301@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137869>

Jens Lehmann <Jens.Lehmann@web.de> wrote:
> The necessary feature is present since 1.6.6, it would be good
> to have this patch in the next release (see numbers below).
> 
> Shawn, This is a third re-send, in case you missed the previous
> rounds. Thanks.

I didn't miss them, I just was ignoring git-gui patches for a while.
I only work on git-gui in short spurts.

I actually just applied a modified version of your patch, so diff
on submodules still works via submodule summary if git < 1.6.6.

-- 
Shawn.
