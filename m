From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: --mixed option is deprecated with paths
Date: Sat, 14 Aug 2010 15:23:04 +0000
Message-ID: <AANLkTik_NuG3YKMknwh4fAK09kTH0tK1f08MzsexUMcV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 17:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkIZz-0003Dh-Qr
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 17:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0HNPXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 11:23:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50405 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab0HNPXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 11:23:06 -0400
Received: by gwj17 with SMTP id 17so430492gwj.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=AZqAJr0cVW9Gsz7rMC6nL3YCJwpmmOrbShTS8Ni/Dxg=;
        b=GSbxvjRxE4gZwJwILDs5ybI8S5gxa0CbM5RRqqR1L93bGeu2YighsobREOPJMmG6Dq
         EJ3hZnbYODYpJI4+TqSGOAL8Zy6Oi6R9ZakEkS4ZSQjCgMMWFBheeclUK+sqGlW9/+Zd
         95WxkJqJCVISGoIwAQQTeJYyrJRHccYX65gqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pgSLVASN5bUCsH+Nwid3WGRxk5tL8Xf5ypCJow+jU8YYSC7jzIWiF0XE1elCG7WWjn
         WPPuXU8Eot5NNADKN9f+7NOuC20Le9PeCVyrZRs+SR/trrQEYTLkvtURdx1TkJTeCvCN
         RRudl6QLKfrS1qykJnJgQZh8L1MNaSo6A2bt8=
Received: by 10.231.80.213 with SMTP id u21mr2789143ibk.173.1281799384872;
 Sat, 14 Aug 2010 08:23:04 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 08:23:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153563>

    $ git reset --mixed t/Makefile
    warning: --mixed option is deprecated with paths.
    Unstaged changes after reset:
    M       t/Makefile

So what should I use instead? 0e5a7faa which introduced it doesn't say.
