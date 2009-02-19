From: Caleb Cushing <xenoterracide@gmail.com>
Subject: merge smart enough to adapt to renames?
Date: Thu, 19 Feb 2009 01:12:58 -0500
Message-ID: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 07:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La2B4-0000Dl-2E
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 07:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbZBSGNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 01:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZBSGNA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 01:13:00 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:52171 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZBSGNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 01:13:00 -0500
Received: by qyk4 with SMTP id 4so475826qyk.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fJYNEly7K/CkqjlLCOTI0/W0Dueq34u3FAnXP3CMWBg=;
        b=p7LPbXWflwwsOrh3Uq8ofQDr0hHsEc0VeyeBQCNtqTGX/2zb/pUEWtqoq4OKsg6Wee
         8umbaP4Q6Aw7Jr6UGpD5kKaVv2/ekqoaVjg7aDf11P2knxlER2Rc9QpHoHXCcJtkjwdW
         rWh+bfx1w7d4csY0OJ+iL8PXb3Zl8WxKDS+fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FMDpI8l7TwqEn7edAgAAlSPbW2jEMnVR6xI3uN4U2Lb/qmYv+xv390QSkSmYSpZgEs
         eRkdRP9A9vOtOEzm1Kte3SAuBV631Y1RhGuce1OigtXf0wn6LsqbA8dr0jKvLvihnWpl
         ytVkmsl8yr+scTHp/hzIIUdm9nd4h84HsoAJY=
Received: by 10.229.85.1 with SMTP id m1mr3659688qcl.56.1235023978906; Wed, 18 
	Feb 2009 22:12:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110631>

branch gentoo.org has a file profiles/package.mask

the software that uses this supports having this be a directory as well.

I'm thinking of mv-ing this file in branch regen2.org to
profiles/package.mask/gentoo.org

since I can't change the location in gentoo.org (for mostly
non-technical reasons) when I run git merge gentoo.org from regen2.org
will git be smart enough to try to merge an updated
profiles/package.mask into profiles/package.mask/gentoo.org in the
future?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
