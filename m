From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Tue, 26 Jan 2010 10:17:03 +0100
Message-ID: <fabb9a1e1001260117n2d88e793n85cc1cb9aa5b09c4@mail.gmail.com>
References: <878wbln0oa.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZhY9-0008GV-6j
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 10:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab0AZJRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 04:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712Ab0AZJRY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 04:17:24 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:56507 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0AZJRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 04:17:23 -0500
Received: by pzk27 with SMTP id 27so571523pzk.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UTTP912dh2nxSwRoCNOhW75JIzOn3KT+3LSDY4guAvk=;
        b=QJTTHbl7FU9YKWQ7SbQqrNGpBqhIe37q18nu7bnJCiFLVWm1R1bMjPb3+GRSQ5phDk
         QDHkyl8xwwiW85sFP3llifuEHXmzzQS1icidsCWrm4P4op1ZwxWnqPwZRHCCzkbyr0v5
         HpbVSUeB3gCZYCr8L6EXLCgVeJ/rndbpJ+2eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nxJ2p7sdnYKrgAOGZSsULk27X1hJtnwkDsFVZieh5RASkf16Ov5V5ZTCG8IxWQjZXX
         s1jSCIFIZRxeDVp58YtRihaNPZDgh6dZX1GUF65fugSVPduRU79FvC/nh7Lj6F24UYOD
         nbxuZofi9X7H5b2ZVhVyITK+u9YI4/tkufjfA=
Received: by 10.142.121.9 with SMTP id t9mr1810743wfc.144.1264497443096; Tue, 
	26 Jan 2010 01:17:23 -0800 (PST)
In-Reply-To: <878wbln0oa.fsf@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138026>

Heya,

On Tue, Jan 26, 2010 at 01:05, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> There is a screenshot of this running on Windows 7 at
> http://www.patthoyts.tk/screenshots/git-gui-win32.png

Wow, that looks a lot better than what we have currently.

> =A026 files changed, 697 insertions(+), 453 deletions(-)

But that's a huge change, is there no way to make it smaller (spliti t
up in multiple patches), so that it's easier to review?

--=20
Cheers,

Sverre Rabbelier
