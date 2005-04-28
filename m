From: Kris Shannon <kris.shannon.kernel@gmail.com>
Subject: RT[0/3]: Some related random thoughts
Date: Thu, 28 Apr 2005 22:59:44 +1000
Message-ID: <5d4799ae0504280559109cd00e@mail.gmail.com>
Reply-To: Kris Shannon <kris.shannon.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 28 14:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR8Ze-0007fh-7L
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 14:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVD1NB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVD1NBR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:01:17 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:1064 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262104AbVD1M7o convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 08:59:44 -0400
Received: by zproxy.gmail.com with SMTP id 13so459623nzp
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 05:59:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BDDV9hLPy0ber/OMKbj6IH/r6q8dOh52EBNO2pk9u+PCPW+pPBoYFVC3x+okPw1Q2QdCvWxhQKD1R5rZS0BcI1CCKROEQnYYTDR0c22Y9Qkp2wHVEJkxNyA5nbX3cLkkMA6YSqVhDuCbrjDy7Uw8hn0z7CFjXAwGXwnhA152D6E=
Received: by 10.36.12.9 with SMTP id 9mr95107nzl;
        Thu, 28 Apr 2005 05:59:44 -0700 (PDT)
Received: by 10.36.4.16 with HTTP; Thu, 28 Apr 2005 05:59:44 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've had a number of thoughts about the "supposed" missing SCM features of git.

1) Alternate Encodings (including on-disk delta compression)
    If the default objects filename doesn't exist, we can try for
other alternative
    encodings e.g. 00/a29c403e751c2a2a61eb24fa2249c8956d1c80.xdelta which
    can specify the object content as a delta or other ingenious idea...

2) Rename/Code-movement Tracking (file and/or function)
    Additional object type tag(s) "rename" which references a changeset
    and lists the movement metadata

3) SHA1 backwards reference cache
    Allows quickly finding all commits which reference a given tree root,
    all/the "rename" for a given commit, all xdeltas which use this blob.

There a quite a few important issues with all 3 of these ideas so I
thought I would
elaborate each in separate emails... (coming soon :)

-- 
Kris Shannon <kris.shannon.kernel@gmail.com>
