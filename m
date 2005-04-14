From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 23:46:50 +0100
Message-ID: <1113518810.12012.256.camel@baythorne.infradead.org>
References: <Pine.LNX.4.21.0504141758310.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:44:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMD3d-0001nR-Kh
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDNWqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDNWqz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:46:55 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:65167 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261617AbVDNWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:46:53 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMD6p-00015b-9x; Thu, 14 Apr 2005 23:46:51 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504141758310.30848-100000@iabervon.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 18:23 -0400, Daniel Barkalow wrote:
> I personally think renames are a minor thing that doesn't happen
> much. What actually happens, in my opinion, is that some chunk of a
> file is moved to a different, possibly new, file. If this is supported
> (as something that the SCM notices), then a rename is just a special
> case where the moved chunk is a whole file.

Certainly we'd discussed the possibility that the 'rename' field may
contain more than one destination, or more than one source filename.
This could happen when a file is split into two, or when two files are
merged into one, for example.

-- 
dwmw2


