From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 09:06:09 +0100
Message-ID: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 18 09:06:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtC91-0005bv-6z
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 09:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab3LRIGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 03:06:11 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51780 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3LRIGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 03:06:10 -0500
Received: by mail-wi0-f178.google.com with SMTP id bz8so218997wib.5
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=X9gkkCpXgbrWplei1nAOh6Ll96yUgP486y5pXlp5y9A=;
        b=gEtfYnf1jkx1BkE4gPB2Cl3iw0LtUm1dH4r83P0OThKwZ17ZwuvE2uixABhFTCvoI2
         PiWvdwTPXM+w7X7Qi1vE6nVfnPwmKWcsoPkb1iJSjpeQUiIgUL+ABHu1qfZ0HK0x2Rx5
         GtlHIVCFTgoXMjMEr4ZKgHvnUPpQgSB1KE5gk1E6zFUYlb7UVMZbOkbpLu/S/eI2kRkw
         GskoCyMLiwGsvX4TUzrnnZN1Znt7hyTq6xpPex8xjcKW3CnMZPt4vSxOemSX2xqYDiyT
         SgfMrE7gFHrE7/xqyp1wRem04B628BHca3Hoe62pbRC16VCRFugINTXMHXhULek249hR
         pkCA==
X-Received: by 10.181.13.83 with SMTP id ew19mr2233765wid.36.1387353969205;
 Wed, 18 Dec 2013 00:06:09 -0800 (PST)
Received: by 10.217.132.69 with HTTP; Wed, 18 Dec 2013 00:06:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239426>

This was discussed on the Git user list recently [1].

#in a repo with no files
> git add -A
fatal: pathspec '.' did not match any files

The same goes for git add . (and -u).

Whereas I think some warning feedback is useful, we are curious
whether this is an intentional change or not.

[1] https://groups.google.com/d/topic/git-users/Qs4YSPhTsqE/discussion
