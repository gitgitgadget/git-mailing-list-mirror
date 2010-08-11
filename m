From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Where do I stick development documentation?
Date: Wed, 11 Aug 2010 22:49:14 +0000
Message-ID: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 12 00:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjK6q-0001JZ-UQ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 00:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab0HKWtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 18:49:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62604 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab0HKWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 18:49:15 -0400
Received: by fxm13 with SMTP id 13so494553fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=exD0Vqt8AVNn4HeRBKvrRsPPTyff/+2OTEx/Kirs2Vw=;
        b=YvqnWJvO308PeKka3IO0hpEZ03O9E6FXdiWcOiTCMejwhdqR82l41jWzYrllVEhr7T
         0PNqUQ7A8ThmN5e4MY36s2AVj1Grd6tczH7kfQw0j9my72MomOkvz1xY7B9d23WGhohj
         CfxciCeuxJklSq2vJWyjY3U9R/4GNVe6SjdO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=RN4GBOSEyrHiMONciFrKaSyT1ti2GE+44AsFlLMAdsILghSZ5n4Ihj3J374TtGbj5t
         fgTq7UrHiotQowbOX2vkGXvI59X3VtiF5TzmjGXVYN2dYUWkIqR/t5HApFseccqC2xlw
         UV7oItKK0UnPiypCNTxTzejzNkSZdpkYcVdY8=
Received: by 10.223.119.136 with SMTP id z8mr20815654faq.63.1281566954102; 
	Wed, 11 Aug 2010 15:49:14 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 15:49:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153306>

There's some documentation aimed at developing that I'd like to see /
write in Git at some point.

Developing:

   * How to work with Gettext

   * How to write portable code, i.e. constructs to avoid in C / shell
     script etc (these keep coming up).

Translators:

   * How to deal with gettext / submit po files / keep them up to date
     etc.

   * Core git concepts (that need to be translated), maybe I could
     adopt the gitglossary to this task, but it'd need to be a bit
     more structured, i.e. describe core data concepts first, then
     some other terms.

     Actually, on that point, do we have documentation that describes
     git's data model in one place? I.e. everything from blobs to
     trees, how raw commit objects etc. look. Something like "Git for
     computer scientists".

The problem is that I don't know where to put these. I like idea of
them being man pages, maybe gitdev-gettext.txt,
gitdev-code-portable.txt or something like that?

The only thing like that currently it
Documentation/{SubmittingPatches,CodingGuidelines} and t/README.
