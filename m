From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: git rev-list --boundary from..to
Date: Mon, 23 Apr 2007 15:34:54 +0200
Message-ID: <8aa486160704230634m130d1877k9e965847a2029751@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 15:35:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfyhV-0006fg-7W
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 15:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXDWNe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 09:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbXDWNe5
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 09:34:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:42842 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXDWNe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 09:34:56 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1539959wra
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 06:34:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BEvwf9JcjhJ+DjHa/4BVOVKDC3suvHwMonHV1zztp9cg3rEnNWmXrymSqNaECtThFRaTc45R5qEWKLitmZfldPRpY3TjgurH7/DJcWJzWp/H7DarBYiz6C+7Z2wmUBBY2Cx0zvqPRO0wnnVHdtWGZZTCRzjEiORwlV7g45h1OCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ooj6Oiwds1Hr7cdO9ZoTX7tKBD1er7etezZnMdGklQEoudqCbi3jHu3ZNpmTxk2sm3uv3MKP8y4AhjuUXom1zK3ywen/uhq+tJF8jQGEOyIgr01K2+Bsa8O6zbsPQsXaoQ8FOg2tRnl+36iE/TyCiBdiSbhQe6maqM8VL2+He5k=
Received: by 10.78.148.8 with SMTP id v8mr1054271hud.1177335294314;
        Mon, 23 Apr 2007 06:34:54 -0700 (PDT)
Received: by 10.78.131.7 with HTTP; Mon, 23 Apr 2007 06:34:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45320>

Hi *,

  git rev-list ${order} --boundary ${commitlimit}

  is what is used in gitk. In v1.5.0.3:

  $ gitk from..to

shows the boundary commits next to the child, but it is no longer the
case since v1.5.0.3-290-g86ab490.

  Now all the boundary commits are at the bottom.

  While at it, when used with --max-count they are at the bottom too,
and I understand why, but is there a way to tell "show me the boundary
commits next to the child even if it means it takes more time"?

  Thank you in advance

  Santi
