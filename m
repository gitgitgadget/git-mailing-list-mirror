From: =?koi8-r?B?7dXLz9fOycvP1yDtycjBycw=?= <m.mukovnikov@gmail.com>
Subject: Bug report
Date: Fri, 5 Oct 2012 14:13:49 +0400
Message-ID: <61FEBCE8-8206-498C-B3D4-ECD6AF192EE0@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 12:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK4uz-0002K6-RN
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 12:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab2JEKN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 06:13:56 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49318 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab2JEKNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 06:13:55 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1202855lbo.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer;
        bh=N21Pz/U7kWWzSwmHChQ1SggDqzFlpg+zrPJ/nOUTtTs=;
        b=NLEQQKgkrT/nphgZ4gJwrHPLWILBKBXBqDM5FvzaXQ45QYl5ViZhTTbrEQa9EojyJr
         bE8EhuPsbJTkUzoVRG0h9ndzpv/4Df2NjcctNH7ylbNEekrUDslnAwuymKSVJDqAGSTP
         dCAKxmsFRB14y12KcPdSTAGW6kSULunlF7Y5hlolbjeghtDri+aub3t5xy7Y7PCK6EKu
         Cf2ccIb1u/LWex34IHvasGMXn55XYR/41Qo2Ep21JAy2/d6si+olg4ZITyXYUdL73NHQ
         mrlNV3FfT5wGDl5nPBHxQC7KbSu2n7wdMcf2Rm0oi6TuigHL/Ahj1UZsn7ggSeuK9ePa
         AH0Q==
Received: by 10.112.103.71 with SMTP id fu7mr3544165lbb.21.1349432033671;
        Fri, 05 Oct 2012 03:13:53 -0700 (PDT)
Received: from 192.168.215.200 ([213.232.243.233])
        by mx.google.com with ESMTPS id fj1sm3015728lbb.8.2012.10.05.03.13.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 03:13:52 -0700 (PDT)
X-Mailer: Apple Mail (2.1498)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207093>

There's a problem using git with files having cyrillic '=CA' in their n=
ame, git just can't track them.

uname: Darwin 12.2.0 Darwin Kernel Version 12.2.0: Sat Aug 25 00:48:52 =
PDT 2012; root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64
git version: 1.7.12.1 (from macports)

Steps to reproduce:
- git init
- touch test_=CA
- git status (should be "untracked files present")
- git add test_=CA
- git status

# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	"test_\320\270\314\206"
nothing added to commit but untracked files present (use "git add" to t=
rack)

Could this be helped somehow?