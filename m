From: John Tapsell <johnflux@gmail.com>
Subject: git merge --abort
Date: Thu, 19 Feb 2009 10:05:57 +0000
Message-ID: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5oW-0008Ad-V6
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZBSKGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbZBSKF7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:05:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:37098 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZBSKF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:05:59 -0500
Received: by gxk22 with SMTP id 22so826864gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=UK4OyUqNenYJ8n1gI1lg8zF7u3VxQmViOs9YQHQe1sM=;
        b=A7H0WhSBLfUiGtCzH4Mm5dMDTOoWctfIzVx77LQ3UpifF8223GSJ0Ebrv8ozOF/D6N
         Y/k0xEByexaIvIpfkBXtwO4klJI1kixx1Y0qsT4OA2dsct+ImLRNVtqM83xYo73MHN/T
         j4K7+vz/dsYeZP7dxAQBziKrbHd3QO6TZff3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fAQhy2XLuMbDUkOFbuXO9OA7q2RFjUnLviV1oh87gR+bDolbHSNK4wxoUACfWyymil
         R33KmxXhXs+UCb0iwq6RhFanb7Cb6jYaVpUroT2CAlHfRaEM2ewaHj9VahRQ3wJUIWVq
         GfAKGF7RlB8o/C4RrurxCdLx8ppzkQ0ySttpw=
Received: by 10.151.99.3 with SMTP id b3mr4912ybm.226.1235037957444; Thu, 19 
	Feb 2009 02:05:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110660>

Hi,

 I hope you don't mind me generating lots of noise here..

  It's not obvious how to abort a merge between two trees.  Would
aliasing  "git merge --abort"  to "git reset --hard"  be sensible?  Is
there a better way to abort a merge?  Especially if you have
uncommitted changes.

  If that idea isn't liked, instead maybe we can add a note to 'git
merge --help' on how to abort.

John
