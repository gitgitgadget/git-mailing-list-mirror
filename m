From: Jeenu V <jeenuv@gmail.com>
Subject: first-parent equivalent for show-branch
Date: Thu, 17 Dec 2009 13:01:00 +0530
Message-ID: <5195c8760912162331g53d4a2feob8d955d9abfe935e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 08:31:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLApa-0005PL-T7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 08:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764043AbZLQHbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 02:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764042AbZLQHbV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 02:31:21 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:63842 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069AbZLQHbV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 02:31:21 -0500
Received: by vws30 with SMTP id 30so560108vws.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 23:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=yqaMYivjGAkbsJXVxCog5uy/J4CuR8zIsnnnzroeE8M=;
        b=I0on3CTTlnycnQM2Wd0wy4xiyGW5AqqQobDg9QBQVnP1beDXh7VW0YCyTjBEjX4r/Q
         zHCgl6pxFPDBoWl6cIwMFnN0X5RWLiru4JqfM7zmA45yYgBONMhWVCD4V7nSZPZc57/j
         0+w1T0oX2oKuihqjy6ET6JulKRiidplmoA1AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=kLH7mTlqFHj9x57sYwUC0pfVWRFdRjXJPqkhkAYCjO4vi40txchqwF+sGIUZhrlNIE
         f7pgHeELBDhHhk0nNdj2MF/s8l8poW5sWk37/H5/mNswvKtCHIe7c+aC6w8NbPKVY4DX
         eeYZ/e+9Z9oTQx4GpscxgLo0elVCZDs5bZl0Y=
Received: by 10.220.127.26 with SMTP id e26mr498714vcs.39.1261035080095; Wed, 
	16 Dec 2009 23:31:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135360>

Hi,

I wanted to know if there's a --first-parent equivalent for git
show-branch, where in it shows only the first -parents in a vertical
column. I feel it'd make the display less cluttered.

As of now, I think, a column shows commits in a merged branch, and
even parents of that branch, which makes reading bit uneasy. What
would be preferable instead to show only the first parent in a column
- something like the output of

git log --graph --pretty=oneline --abbrev-commit --first-parent --all
| sed 's#|\|/##g'

along with the header and naming strings of show-branch.

Thanks
-- 
:J
