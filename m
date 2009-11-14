From: Jens Kubieziel <kubieziel@googlemail.com>
Subject: Resolving a merge conflict with git-svn
Date: Sat, 14 Nov 2009 01:30:57 +0100
Message-ID: <76ee5f990911131630k41a91f70n5e717befb7693463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N96Xp-0001vS-GG
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 01:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbZKNAaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 19:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbZKNAaw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 19:30:52 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:53357 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbZKNAav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 19:30:51 -0500
Received: by ywh40 with SMTP id 40so1787049ywh.33
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 16:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=iQSEcBALolR2kuBAsf4THSTMMKplzfmS//dohiDZIck=;
        b=N3eF8bDwh/hMATIUjJOUzxqOcjowAdGvEIZCP+Fsinw2lVrTP/G92mWt1GosSs9bYj
         wOrm8vG65I71YXGSbPTyODdlO4DbW5Sap90EcPU0KbgCR9aQSO/IQc/+oaHNmj9pxrS8
         RcyyhRhEEuGwnTnQSPHThu4JWHbgmccbCX8e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bm94qpqyBM8q3lh+vXOK06hzmDDe8nDjhqKha1xr8acWxVd3Z9x2oFFQHN5PA2AiRE
         4tJH/nCYGxNuAOALfMI6EDcNML1rg1fCInUiL6ak1jCf4uSD3UriStqDOHR1B0KMbOJC
         5TS/OwyPYRmKmrJoeSWU1/u27WlOzMmAYADU0=
Received: by 10.101.133.29 with SMTP id k29mr6111356ann.98.1258158657159; Fri, 
	13 Nov 2009 16:30:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132853>

Hi,

I recently came across a big conflict. Someone used Subversion and
made a complete wrong commit. I did a 'git svn rebase' at some point
and ran into the conflict. My goal at this point was to remove the
wrong commit, but I found no way how to do it (git-revert needs a
clean tree; git stash brought [fatal: git-write-tree: error building
trees,Cannot save the current state]). What way would suggest to
remove that wrong made commit and continue with the rebase?

Thanks for any hints.
