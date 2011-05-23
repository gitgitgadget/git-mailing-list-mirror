From: Arnaud Lacurie <arnaud.lacurie@gmail.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Mon, 23 May 2011 10:31:14 +0200
Message-ID: <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com> <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 10:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOQY8-0001nh-Pw
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 10:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab1EWIbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 04:31:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42061 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab1EWIbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 04:31:34 -0400
Received: by vxi39 with SMTP id 39so3902088vxi.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=eGKMkXtM5sNc8/F9AfH6HRHa3C4yuFV2XxG5/yy350U=;
        b=MGew5bmJotYohRKpdbxzkfE2IeEpPA3KxWhaKhUWVQEBv+V6ZKNt4DowTn3CoWZCRk
         8gdmmyivIRIrsLwkq9DAqYpKdnuP0j0Km918VZnJ1dV5r7cxowQJ8PAijEpWpH965hzb
         FMEVFMNa+5KjS+Uh8mvTDq7+tQa1TeQeIiQZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O0c6Irn63uH66hCTlaV6LTd0XlNGy/B2BKZVTEKcLeFSAdwLzNKgiIOR3yLLWmC7PK
         3kHZ3lsOoxk8CVC0NxjDr71h2D3p4aKOKbgyE+MBfGt9zrKAws2CjRWv19CmY5g/ujPf
         /z6VuVbdUN+vdHSZJLJ86je7+ZzsMR4rqHlJE=
Received: by 10.52.69.65 with SMTP id c1mr3118887vdu.301.1306139494099; Mon,
 23 May 2011 01:31:34 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Mon, 23 May 2011 01:31:14 -0700 (PDT)
In-Reply-To: <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174232>

Thank you for your advice.

2011/5/22 Junio C Hamano <gitster@pobox.com>:

>
> =A0 =A0 =A0 =A0git clone --vcs=3Dmediawiki http://some.where.xz/wiki/
> =A0 =A0 =A0 =A0git pull
> =A0 =A0 =A0 =A0git push
>

Is vcs a standard argument (I can't see it anywhere) or do we have to
change something in order to implement it?

Additionally, is there an example of protocol which uses
remote-helpers? It seems that in the remote-helpers directory, there
isn't anything but a git directory. Is there some other protocols than
git that already use remote helpers?

Thank you very much.

--=20
Arnaud Lacurie
