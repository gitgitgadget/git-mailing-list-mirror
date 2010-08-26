From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Does anyone use git-notes?
Date: Thu, 26 Aug 2010 14:09:03 +0100
Message-ID: <1282828143.6120.3.camel@wpalmer.simply-domain>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
	 <4C762137.1090801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 26 15:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OocCt-0006Rw-UD
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 15:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab0HZNJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 09:09:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64318 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0HZNJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 09:09:10 -0400
Received: by wwb28 with SMTP id 28so1633620wwb.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=YIH9uU68LCibk7otCsgavv2yFnt5cGHPotBtORuB8wY=;
        b=pr9cuyx60wrekMs1VFxxBRWAJ0RHhGU567qgN9QiiRXzCkpaPtQJ5vo/ApKdZRuOW6
         TBqhTmzwIF4xZ71wCswAXfUMpToWkl8zlQQURqa+BBbaVdIfV2Bw/RRvFcFyf/xoNoZj
         XBT6PpV5NUSsFjSllZSAASpSR9b1ULRWbiEqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=aFSapd7qyt8dHpvq9wm3Q4DuN6tT5qzLo0Ls479o0X0M8s9czFq0y3TWX8zq8GoegE
         6g0sT3QiVUPoI0u1TyO5v4tS1XafuWX+MvOfO42qhQ6qQLy+9riv4sDczq5zjipHC9M4
         me2JDFBTQf8orLcHSamhJtWr1l44e4TLflxtk=
Received: by 10.227.131.68 with SMTP id w4mr8501954wbs.225.1282828148707;
        Thu, 26 Aug 2010 06:09:08 -0700 (PDT)
Received: from [192.168.2.128] ([193.164.118.24])
        by mx.google.com with ESMTPS id b23sm2234273wbb.16.2010.08.26.06.09.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 06:09:07 -0700 (PDT)
In-Reply-To: <4C762137.1090801@drmicha.warpmail.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154539>

On Thu, 2010-08-26 at 10:09 +0200, Michael J Gruber wrote:
> I use it to store the patch comments (the part that goes after the
> "---", before the diff) along with my commits so that I have them in my
> git.git tree, not only in my mbox. This makes it also easier to redo a
> patch and keep the comment when regenerating the patch e-mail with
> format-patch. (I don't have a good solution for the cover letter yet.)
> 
> Michael

Not to stray off-topic, but I use tags for the cover letter eg:
refs/tags/patches/short-description/v[N]

I hadn't thought of using git-notes for the per-patch comments, here I
was with the opposite problem (A straighforward way to keep track of
cover-letters, but no good way to keep track of the per-patch comments)
