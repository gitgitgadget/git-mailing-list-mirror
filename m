From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Wed, 25 Aug 2010 22:53:03 +0200
Message-ID: <201008252253.04516.j6t@kdbg.org>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com> <201008242124.23890.j6t@kdbg.org> <AANLkTinboi+L3fvC___pULO0u_ZBNNOM6er+chxt7s07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 25 22:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMyB-00076G-BB
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab0HYUxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 16:53:14 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17303 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451Ab0HYUxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:53:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 006D42C4007;
	Wed, 25 Aug 2010 22:53:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9ABAE19F5FD;
	Wed, 25 Aug 2010 22:53:04 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTinboi+L3fvC___pULO0u_ZBNNOM6er+chxt7s07@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154470>

On Mittwoch, 25. August 2010, Erik Faye-Lund wrote:
> But I'm curious, what's the best way of import a couple of foreign
> source files, while maintaining a couple of patches on top of them?
> I'm thinking that perhaps a import-commit followed by the patches
> would make it easier to merge in changes than to just import the
> patched version, but I'm not entirely sure how to do such a merge
> without merging a full subtree...

This is about only two files. When a new version is available from upstream, 
just branch from the import-commit, apply the two new files, and merge the 
result.

-- Hannes
