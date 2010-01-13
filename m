From: Leo Razoumov <slonik.az@gmail.com>
Subject: tag namespace?
Date: Wed, 13 Jan 2010 18:03:59 -0500
Message-ID: <ee2a733e1001131503x5a1da0a9g562bbfb5c0f19fd2@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVCG6-0004D0-Rh
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 00:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab0AMXEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 18:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985Ab0AMXEL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 18:04:11 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:51251 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0AMXEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 18:04:10 -0500
Received: by ewy1 with SMTP id 1so188220ewy.28
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=/lB1fZgs+wRNC5ClbSJJ8auNGSNeBw+estqr5Kk5o64=;
        b=hN0wgqAth5sB43DaYjOAny+WLe2k91RTrH9KQOH+8WVCEmyEdL2xTT7KgdaUW5au9p
         Dz9DAI9QVx4SglPXSsaHaWixqc+crFAzJRrQ9+TOdjRdzhbN5zvsp6Ikz4xigVPdB/YL
         4A6jvJJTi4mPBBHj+oJuCsvNVRLvFGibcoegI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=IYI8G7QbDoYy0lTu305zdiue0XIeKg+h4dGKKXZiWNPcAudufSdpAv29+ODVlWzn0B
         s5Vtj45PG6QtC/fvIZz85NZYLhYmyIe6qFf8L8Jr0Jvt583v9156B0nl1Qzk54e2DdC9
         b66TFeIU4BBrmMaLohgUBe9REkpwPJ796JIuc=
Received: by 10.216.91.67 with SMTP id g45mr831965wef.190.1263423839103; Wed, 
	13 Jan 2010 15:03:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136893>

Hi List,
local and remote git branches live in different namespaces
refs/heads/* and refs/remotes/* respectively. thus, fetching from
remote repo never collides with local branches. Unfortunately, tags do
not enjoy such a separation. When I use
       git read-tree -prefix=libfoo/ -u remotes/foo/master
remote tags suddenly populate my local tag space.  v1.0 comes from my
project while v1.1 comes from foo.

When using subtree merges is it possible to create a "remotes"
namespace for tags?
Something like --tagprefix option for git-read-tree or any better solution?

--Leo--
