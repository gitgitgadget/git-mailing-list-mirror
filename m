From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: [Q] post-commit hook to backup repo by emailing git bundle
Date: Sun, 4 Jan 2009 18:27:09 +0300
Message-ID: <c6c947f60901040727m328a814av8edd72570c39e0b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 16:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJUu7-00009H-Km
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 16:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbZADP1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 10:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZADP1N
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 10:27:13 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:60768 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZADP1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 10:27:12 -0500
Received: by bwz14 with SMTP id 14so21642846bwz.13
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Cqk83d6YJTJ3dt97y9dn+7NUgoft3Mx8a7QVTTR4OJE=;
        b=vsJEnLtKQSfjAqgAIixTE9K+I53z7jipFeZvdmcN4iQ+suBUV6dbdeL8HaCJKkBZdH
         dAmZbgkUiHrBeQv3MXf7sERucw2hL17I3OW2ICcpnhM6AvqhmnZwXHfZjqCNIICrIBF/
         RtKs0lLwlF+Y10qmSax33r2qq++/hIqG+jkjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=iKLtSocqEbKM8AKaeK/wU1hpTTMvPpkVM9GWRBVw2BRL59qIbX3UU5tArAqwe/Ifg7
         JKXpsMW5RjLHtKxnm4EMg3rnQt+qkVw485HY7wYwKxnedRv6xKrpXBS+c20W69v2I0/7
         tisH7ns6PSS2Xn4Xl89+Ex8bnTH07YjC55D6U=
Received: by 10.181.50.1 with SMTP id c1mr7725170bkk.3.1231082829318;
        Sun, 04 Jan 2009 07:27:09 -0800 (PST)
Received: by 10.181.33.14 with HTTP; Sun, 4 Jan 2009 07:27:09 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104520>

Hi, list!

I have a server, where I store my light-weight private data (a wiki
contents) inside a git repo. I need a backup solution for this data.

Setting up a mirror repository and fetching/pushing over the network
is highly uncomfortable for a number of reasons for this specific
case.

I'm thinking of setting up a post-commit hook on my wiki repo, which
would prepare git bundle for the commit and send it to me via e-mail.

Perhaps someone already has something like this, so I would not have
to reimplement the wheel?

Alexander.
