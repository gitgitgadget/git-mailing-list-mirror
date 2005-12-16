From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 14:13:16 +1300
Message-ID: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Dec 16 02:15:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En4A7-0003aC-B6
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 02:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVLPBNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 20:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLPBNT
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 20:13:19 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:7655 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751233AbVLPBNR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 20:13:17 -0500
Received: by wproxy.gmail.com with SMTP id 57so490371wri
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 17:13:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z3swn2OMyiF+YiQRZSqq2vfFXM97q0mi4bHdl/fstJyUW8TGdYoUo9eLsxG2UlWKAGJHYmESTv6sT+6D8/3Tm/9Cm+Hq3VBYEYVHOW4S9deMXPmcmjYmYpemoerRwSGuvFwXEKIJgSd2kjtxdmEQWhwFyUwKXCjRVlVMnskCR2s=
Received: by 10.54.79.8 with SMTP id c8mr3002783wrb;
        Thu, 15 Dec 2005 17:13:16 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Thu, 15 Dec 2005 17:13:16 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13724>

I know, I know, use pickaxe :-)

Any suggestions as to how to implement a not-too-slow annotate that
looks reasonable enough so as to fool real cvs clients? Let's assume
I'll have the "per-file-version numbers" to translate commit SHA1s
into cvs-ish version numbers in a magic hat, right next to the fluffy
bunnies.

Suggestions of GIT machinery that would shortcut the trip from

     git-rev-list HEAD $path

to a annotate-ish output. Did I dream it or is qgit showing something
annotate-ish in its screenshots?

Note! Just told a white lie: I won't be actually using git-rev-list.
Instead, I'll have a rev list that will gloss over branched
development, picking only one "path" of the history every time
(initially using the algorithm formerly known as rand() ) , and
showing merge commits as one.

cheers,


martin
