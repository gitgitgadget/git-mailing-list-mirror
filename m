From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Editing patch sequences
Date: Sun, 09 Mar 2008 01:37:54 -0800 (PST)
Message-ID: <m3myp8fdae.fsf@localhost.localdomain>
References: <877igcw8gn.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 10:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYHzg-0005mK-AQ
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 10:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYCIJh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 05:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYCIJh5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 05:37:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:57746 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYCIJh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 05:37:57 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1452802fga.17
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=H06+XLm3mxEJfix3RllUGByXwPnS8t8rkq7fMUBTaGM=;
        b=vZthuXf+qHXwjYY8qtt573xgsl/ZLR9L3ODbeBiiVTZjFZ1vNSsC64EQXxdi7+/5uX6xJW4UaTdseQw8bSHRQaTdnGPucMx2jQsqhQuVHvo+W34k22Xt5BVW2uyCexuKCWvLMj3WpPFTWMGqTcLWO9AlLrGEBoQCL3L/lihmDr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=lhy4RLKqQQlfiZFIrsitlbY/0oKQtXsckNFVjel/3CjEEKKvB9e1zuTn7SLMN2tRWPB9+YPjGjeu8sgY3THRnniBEFCcIgTivj2c6us8Tft2nqAC77FObR4sF53VGcGc5AYqHkoxVUoVeJmlfKNSalYp3IVWfbYXMgkifB0kGro=
Received: by 10.82.153.5 with SMTP id a5mr9272520bue.5.1205055475496;
        Sun, 09 Mar 2008 01:37:55 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.176])
        by mx.google.com with ESMTPS id y34sm12985665iky.6.2008.03.09.01.37.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 01:37:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m299c22H007056;
	Sun, 9 Mar 2008 10:38:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m299c1eJ007053;
	Sun, 9 Mar 2008 10:38:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <877igcw8gn.fsf@mid.deneb.enyo.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76642>

Florian Weimer <fw@deneb.enyo.de> writes:

> I've got a patch sequence (a list of file names of patches to apply to
> some directory tree, not necessarily in quilt format), and I need to
> reorder those patches (for instance, I've got a different version of the
> directory tree, but don't want the patch at the beginning of the patch
> sequence, but add the end).
[...]

> Has this already been implemented? "git rebase --interactive" comes
> close, I think.  But minimizing the changes to individual patches seems
> a bit of work.

You can try to use one of two Git patch management interfaces: 
StGit or Guilt.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
