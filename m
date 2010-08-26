From: Jay Soffian <jaysoffian@gmail.com>
Subject: objectname:short bug?
Date: Thu, 26 Aug 2010 17:16:04 -0400
Message-ID: <AANLkTikhcAC6Nf=jWQN40ascodaCte6v6e1JPfv-=To-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 26 23:16:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OojoR-0003TB-2h
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 23:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab0HZVQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 17:16:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53527 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab0HZVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 17:16:37 -0400
Received: by iwn5 with SMTP id 5so1876145iwn.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=O87bTk7tew7yOLc/5pFBIL22V2gXRrwO7P7FzPVx2ak=;
        b=Ap+lh4Xv/LxVHHxIde+rBJU+01GNTwlIIzhTaBaPmduabcmK+o0F91skljrMPe3TTh
         BjCudXSh/Jhf3WSHMCJ4VyeKnNCdfDLonpMPmawB7PZddryxAPiYuVHG6Tz7woqpc6dX
         QPcNZuyL1eSVgXJ2xKtWMmtHnKZgWJeiQ/YFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=PrSUBQhQOMIT1XO41nDWwDtCOE/yH6piG4S/IPxC6pcIh9X4dP9EyxJ+dKW8hzyQ8/
         ciXhmoEr/LahptXEpO8sr9Hd5oO4fE2DMbfllJriGq0P9zPmC7daU0tBPKba5Y6Yd3wN
         5zkFqoQSyP/vxItFdTdOvaUDSztZmnOaE0DWk=
Received: by 10.231.30.134 with SMTP id u6mr12847688ibc.121.1282857394136;
 Thu, 26 Aug 2010 14:16:34 -0700 (PDT)
Received: by 10.231.161.199 with HTTP; Thu, 26 Aug 2010 14:16:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154562>

$ ./git version
git version 1.7.1.88.g67687

$ ./git for-each-ref --format='%(objectname) %(refname:short)'
refs/tags | head -5
d5aef6e4d58cfe1549adef5b436f3ace984e8c86 gitgui-0.10.0
33682a5e98adfd8ba4ce0e21363c443bd273eb77 gitgui-0.10.1
ca9b793bda20c7d011c96895e9407fac2df9648b gitgui-0.10.2
8c178f72b54f387b84388d093a920ae45b8659dd gitgui-0.11.0
15c7170c8c1f6d4f8b8aa539987a92c45d06be9e gitgui-0.12.0

$ ./git for-each-ref --format='%(objectname:short) %(refname:short)'
refs/tags | head -5
8b1e557 gitgui-0.10.0
8b1e557 gitgui-0.10.1
8b1e557 gitgui-0.10.2
8b1e557 gitgui-0.11.0
8b1e557 gitgui-0.12.0

Just checked tip-of-master (b5442ca) and the issue still appears.

j.
