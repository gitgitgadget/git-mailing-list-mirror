From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: help reproduce fast-forward in rebase
Date: Wed, 20 May 2009 18:13:33 +1000
Message-ID: <fcaeb9bf0905200113s43eb5693l24a1f8848bafabd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 10:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6gw7-0007bQ-Ag
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 10:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbZETINy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 04:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZETINx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 04:13:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:26880 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZETINw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 04:13:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so200929ywb.1
        for <git@vger.kernel.org>; Wed, 20 May 2009 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=dauwhh1GdK581cO3uB9RQXngsA3p0Rcf/VsensJOTNg=;
        b=UczPW9PUEpkulZJRrDnaDShfLd8osxeMXxj6ugeVHN+ibn/wTAMsJKhW5bECFT+lT8
         kygAqujcb2j6O0M11NxqhmMaycDf+a7ITFegOI/DUrJX8/ekaAe9W/xnI/Grj4fngz+H
         SWCoeLlYDyJt7M2ccwCNkjnaoPXAaOpEOy+KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=MS1LQa0U+AXHa+oMXeBPBSYCWN+TlP5Xb36t71Ntuqbe+GAVCsKFT8nIvSEX5mtpCE
         2Ma1F8NLwDNTL/uvN6AdH4Q1whv8OB1Xyw6eUmIz075/lt5VnjcdWz7If3mlc8sE7yWF
         LBUiYOHI5C5XdKR/d09aVEKPQJMHLHUivr+Nc=
Received: by 10.100.14.2 with SMTP id 2mr2089142ann.68.1242807233301; Wed, 20 
	May 2009 01:13:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119587>

Hi,

I'm rewriting rebase in C and do not quite understand this code inside
git-rebase.sh

# If the $onto is a proper descendant of the tip of the branch, then
# we just fast forwarded.
if test "$mb" = "$branch"
then
	echo >&2 "Fast-forwarded $branch_name to $onto_name."
	move_to_original_branch
	exit 0
fi

Anyone has an example how to make "git rebase" execute that code?
-- 
Duy
