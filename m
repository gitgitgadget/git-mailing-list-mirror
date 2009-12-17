From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Git on QNX
Date: Wed, 16 Dec 2009 17:03:16 -0800
Message-ID: <905315640912161703u3920178cm93851ddc8480ac8@mail.gmail.com>
References: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com> 
	<7v6387zzfi.fsf@alter.siamese.dyndns.org> <905315640912151413g10ee5befh58fbd171237e7659@mail.gmail.com> 
	<loom.20091216T233122-388@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, Sean Boudreau <seanb@qnx.com>,
	mkraai@beckman.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 02:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL4mc-0005Iq-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 02:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763536AbZLQBDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 20:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763484AbZLQBDi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 20:03:38 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:36348 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763269AbZLQBDh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 20:03:37 -0500
Received: by pzk1 with SMTP id 1so1110329pzk.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 17:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=bXgBhpSYtXLBcURpEbS26v+k1tNt3mJPk6qztCqX+Vs=;
        b=jcmT4gydx/s8BvI9KWCDmNCRJb9AJkyJrR4V2j4mNLauMS5DS11Y9NLmEjR1zoQeLl
         xNfjZ9A6QOZCeX4EZEPWtyx+8rUUNVpy2H7IBi8O92Ek9xcuj5rKckJTGUVsA77OGn75
         hdfGxbBeeYSyVxurelq1uO8G3XqO3AjAzCRos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=KD+KDZlO8EeTI/ltC8uAyp47CfWAFyVX/A8LSdygEq/s7TXp3yEdwzYNAr2P2/OkAH
         at/GE7H2hbZfSJMgS7CCpoudmoCpRGwNn8zlRbtugIG2LiOAMPYGQC0Uvn0m8HMP7z3O
         sjJY9Z6FS2q2tdnf8YUNS8sUSxf4fUxEt/al4=
Received: by 10.142.118.3 with SMTP id q3mr1227539wfc.9.1261011816511; Wed, 16 
	Dec 2009 17:03:36 -0800 (PST)
In-Reply-To: <loom.20091216T233122-388@post.gmane.org>
X-Google-Sender-Auth: f9516a659acc9f86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135352>

On Wed, Dec 16, 2009 at 2:38 PM, Sean Boudreau <seanb@qnx.com> wrote:
> What version of qnx is this on. =A0<strings.h> is
> now brought in by <string.h> and the lock() /
> unlock() prototypes have been removed from <unistd.h>
> AS OF 6.4.1 (the current release).

Ahh, that's nice.  At a client's request, I have been working on QNX 6.=
3.2.

I just installed 6.4.1 in another VM, and it's a bit different.  The
common way to handle binary packages (iconv and perl) seems to have
changed to pkg_add so the PATHs I had set might not make sense
anymore.

Also the weird failing test at t0000.42 seems to be fixed.  Funny.

As I might be the only person to run git on 6.3.2 instead of a more
modern QNX, it might make sense for me to just submit the minimum
patches needed for QNX 6.4.1 and then carry the strings.h,
getpagesize, and lock() changes for 6.3.2 on my own.

> There's a package for git-4.3.20 here that also has a work around
> for the SA_RESTART issue.

I think that might be a different program that also used to be named
"git".  I think it has now been renamed gnuit.

Thanks,
Tarmigan
