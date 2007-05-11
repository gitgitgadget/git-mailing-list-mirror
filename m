From: "Eugine Kosenko" <eugine.kosenko@gmail.com>
Subject: Repo cleanup problem
Date: Fri, 11 May 2007 11:03:32 +0300
Message-ID: <9909dee80705110103h5b848490m296c001beecfa1f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 10:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmQ6I-0007V8-1C
	for gcvg-git@gmane.org; Fri, 11 May 2007 10:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbXEKIDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 04:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756076AbXEKIDg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 04:03:36 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:63909 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbXEKIDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 04:03:33 -0400
Received: by nz-out-0506.google.com with SMTP id o1so907163nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 01:03:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QTMfFEmfdYuIkgZQ1uVOAkRZQY5c6UqgHq/TkztAgJRGJ3Hu4PcXEZc3SKDw/F7HAJfKpq4YsWnbWjoX+agwkpVzKr9xEpZE2wOP/+4H2W8FOGlriXanPf1KXorAAvJ7SdRbfyU3HcuM8syrvSdKsj1xpbeF/bY4GG4WWuN9Uuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=poQuuhZfHSJ6AzrL3lZOxHNhJabFuzom/oHtNeraMZyuxvmkjq1wzY9QlypVg5E5j8h6PEi3b/xpPBHMlvXV8WMsMo82l0ig+8445zVBWaP2Wpge/rPemxVgMtjiIPYRUCa3jhvH9YTKIanpH+E6KLG/Ct+hsDyzSvHU/7ka4HM=
Received: by 10.114.127.1 with SMTP id z1mr904152wac.1178870613062;
        Fri, 11 May 2007 01:03:33 -0700 (PDT)
Received: by 10.114.210.5 with HTTP; Fri, 11 May 2007 01:03:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46942>

I'm sorry, if it is a FAQ.

I use git to track my own changes in a project, i.e, this is a private
(not public) repository. Some time ago I've accidentally committed a
big amount (about of 50M) of crap into the repository, and make a
mature set of commits after this.

For now I'm looking for a way to remove the garbage commit. I've found
a way to remove any commit using git-checkout, git-reset and
git-rebase. But, when I even git-reset the repository to the very
first (root) commit, I see the size is still large enough, i.e., the
crap is still there. I've tried many combinations of git-gc,
git-prune, git-repack, git-prune-packed etc, but the size of the
repository is still the same. The only way I see now is to git-clone
the repository -- the new one is essentially smaller, but needs to
reconstruct the local branches.

Is this (make a clone) the only proper way to clenup a repository, or
there is another magic tool to cleanup the repositories?
