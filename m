From: "Elijah Newren" <newren@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 10:32:33 -0600
Message-ID: <51419b2c0809110932r4e8c833fx740ccb0c8e46f0af@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com>
	 <eafc0afe0809102305u6de85ef3ib2c08004dea8d6f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Changsheng Jiang" <jiangzuoyan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdp6z-0007LK-LJ
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYIKQce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYIKQce
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 12:32:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:31671 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbYIKQce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 12:32:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so409049rvb.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qdR/+kNB3fJjK65VJH/jJpjmSGGyy2I0XKdNJIe6H5o=;
        b=QuZPlQi56wCmVgFHEgfRlif/WNYm5j1Vn4lE/6/2Pb6uabtQE7X6YsoFSbL1sQydd0
         hu5rwfViSUHEuXEs4dKg3YqJpsSfckz3ghtWaypYB/YXbGKX7vx8IGTSuaiDXoyBRo9x
         36HLBSex3oeawV2Ne3NWy2kD4/kVSn+TKk5f8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=slZ8UlhXTZsUDRWGfaKrS3Pfeg7zI4TJrSWCWeXGCquPjAiA7+TEsCZcdnP0yq9jG2
         7Ntl2wJ78HSP9Zhk/38B420dcNsV8qRbsVAsFw5kp74xNyoDiWTZyODsKZ0mxRGaL31x
         lazs4LrDnwITm64f2TTt+0nXomQu8Fsd98wYs=
Received: by 10.141.164.13 with SMTP id r13mr1923561rvo.53.1221150753075;
        Thu, 11 Sep 2008 09:32:33 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Thu, 11 Sep 2008 09:32:33 -0700 (PDT)
In-Reply-To: <eafc0afe0809102305u6de85ef3ib2c08004dea8d6f9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95619>

On Thu, Sep 11, 2008 at 12:05 AM, Changsheng Jiang
<jiangzuoyan@gmail.com> wrote:
> I don't know what version of you git, my git with version 1.5.4.5
> doesn't delete the file file42 after git-reset.

He stated the same with his version.  The point wasn't the behavior of
git reset, but of git reset --hard.

> BTW, if you added the file42 to .gitignore, why git-status still
> reported "new file" file42"?

>From the gitignore(5) manpage:

"Note that all the gitignore files really concern only files that are
not already tracked by git; in order to ignore uncommitted changes in
already tracked files, please refer to..."

Once you run git add, the file is tracked (unless you do something to
explicitly stop tracking it).


Hope that helps,
Elijah
