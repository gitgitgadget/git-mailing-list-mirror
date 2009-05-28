From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Thu, 28 May 2009 17:12:40 +0100
Message-ID: <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com>
References: <20090527210410.GA14742@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dave Olszewski <cxreg@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu May 28 18:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9iDv-0000DN-0e
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 18:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbZE1QMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 12:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbZE1QMk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 12:12:40 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:61148 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbZE1QMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 12:12:39 -0400
Received: by gxk10 with SMTP id 10so9257352gxk.13
        for <git@vger.kernel.org>; Thu, 28 May 2009 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nulKnNaA0xKx39fP3FCDDCr4KFVYnFYDMw8Ds9UiaMs=;
        b=ON/Hvct9GoYZK6rUQtdagQNAi0gYvOVOlDlYd5yiIe8Upxym4JfdQ4My38VQFJe6Md
         tEtvmo+JNbQ+D/B2kyRrbYxQ4K3X30MKY/5W4Ub6ivVvQwdlNqsWcPE5NriQBvcUAi6Z
         XKytXb3wmtzYONmNDxOv8A6XOLnHLX7wfspO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RamuppiQJX/NmXMqrzRP5f2GN/ZSFuIy4qy0QQFT5T0WEzY+dmAP9XgTUWi6IyMtx6
         RA7CrDaKiM/iQLEtDHnoQ6Ls0JeR7Eler92L9g8oDg1pPaiXAbB7dZR9/H7Cg+LBbrQe
         kdQkfTgGB83MnJVul3fiQF5yIJ6pOY5CIaqlU=
Received: by 10.150.134.2 with SMTP id h2mr3074161ybd.9.1243527160922; Thu, 28 
	May 2009 09:12:40 -0700 (PDT)
In-Reply-To: <20090527210410.GA14742@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120195>

> + =C2=A0 =C2=A0 =C2=A0 if (read_cache_unmerged() || file_exists(git_p=
ath("MERGE_HEAD")))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("You are i=
n the middle of a conflicted merge.");

Could the error message also give possible solutions?   "Commit the
current merge first with 'git commit', or discard the current merge
attempt with 'git reset --hard'" or something.  Or at least a pointer
to where to read for more info.

John
