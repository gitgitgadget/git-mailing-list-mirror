From: "Frank Li" <lznuaa@gmail.com>
Subject: how to omit rename file when commit
Date: Mon, 19 Jan 2009 17:13:57 +0800
Message-ID: <1976ea660901190113l5407f108lff8f37d9a8331f58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 10:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqE7-0001Fi-NX
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbZASJOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 04:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbZASJN7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:13:59 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:6197 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZASJN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 04:13:58 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1192847ywe.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=2ueVZ+3q6zZiuDPXwRos5NgsvLcpljzcnEvR4xMz76o=;
        b=cEHKn7qOqwBJibbaOkpa70ndEns8gbsR7rpfVS95wt72eA7HwiiuRcgFZikj6BLWBU
         /mLNpDNWB+TraJXUyIny8HnxMpAy0czeTtzKvMqw71kKtF2ZXUFuIqXhZCGK3iy1gaPs
         Gr4+/ai4aZ0I+uC6Lvkxf7f2RrKWF+dK8i+ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Gkzu6ZyIuE1bhvV8/y/m0CW2Gu2tvGooTy5fTZK1sug+jeJmA+SAZjV8DMkAYv3KGa
         CR8WJbd1VA3+Lw5oYr920evSnHd0rkq9dKGQSBC2k347JheMX1EYsBOC3Gn/+hJJfkVG
         50taK92mHeCIZKT+6uGa1ZrdqJBZWN+veHwpQ=
Received: by 10.151.111.1 with SMTP id o1mr484028ybm.28.1232356437186;
        Mon, 19 Jan 2009 01:13:57 -0800 (PST)
Received: by 10.151.139.13 with HTTP; Mon, 19 Jan 2009 01:13:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106336>

For example there are a file a.c at git repository.
use
git mv a.c b.c

git status:
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       renamed:    a.c -> b.c

If we don't want to stage this change at this commit,  what can I do?
