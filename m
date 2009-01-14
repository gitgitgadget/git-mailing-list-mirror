From: "Corey Stup" <coreystup@gmail.com>
Subject: Compiler requirements for git?
Date: Wed, 14 Jan 2009 13:32:56 -0500
Message-ID: <128172e70901141032p6e830a85i344d72e1b3bb3a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 19:34:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNAZO-0003Dd-Bk
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbZANSc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZANSc7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:32:59 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:61727 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbZANSc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:32:58 -0500
Received: by bwz14 with SMTP id 14so2217848bwz.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 10:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ieL+6uu7KEaKMT8QwvEa7bl98p8VmL7Vhf/60bBiLdg=;
        b=EK2X2CdERO2baDb19sajSd3cG0109mIFREWjoBGmpr3Nls/Rcy8iChLWaZkkOS+5MB
         JKWt9+WwGO0q2uqoRhT864QcKqdRGMkFtatMxHwoRCYDzUHWFtaTSJcFSLD3ELgnGBn/
         XuQKk6o754mo9KVcp+vpiIQQw6hMFdBP53Hx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=HBkd+QiEk81C1Yv/YLtQCY92GU8OeMUaQ46Usatn6G1xEessM4O3RF0NmYbKmIsn3x
         01xuBkGevSvy9CGSpa4/4FfA8e3eG+kSP/2eHeR3+4E7B4pijr4puP88pqShBlPDfRI0
         EWZKlJPVNQj7mCzY1KNb5AxD9ZjZaPm0j2KEI=
Received: by 10.223.106.71 with SMTP id w7mr556670fao.22.1231957977031;
        Wed, 14 Jan 2009 10:32:57 -0800 (PST)
Received: by 10.223.107.207 with HTTP; Wed, 14 Jan 2009 10:32:56 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105677>

Newbie to the group.
I couldn't find a reference to say what the requirements are to
compile git.  Certainly it works with GCC, but GCC allows for all
sorts of non standard syntax.

When trying to compile with a C89 compliant compiler, I'm coming
across a couple issues:
- "inline" use
- trailing comma on the last member of enums

Are these oversights or does git require GCC or a C99 compiler?
Thanks!
