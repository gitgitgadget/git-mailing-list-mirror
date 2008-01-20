From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Removed Auto-generated TODOs, they don't specify something to do.
Date: Sun, 20 Jan 2008 22:07:27 +0100
Message-ID: <200801202207.28128.robin.rosenberg.lists@dewire.com>
References: <1200860941-6922-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGhQc-0007qB-0D
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 22:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYATVJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 16:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbYATVJd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 16:09:33 -0500
Received: from [83.140.172.130] ([83.140.172.130]:3812 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755555AbYATVJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 16:09:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 21985802866;
	Sun, 20 Jan 2008 22:09:28 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqQ0cvQdj3z9; Sun, 20 Jan 2008 22:09:27 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 0C2A2802667;
	Sun, 20 Jan 2008 22:09:26 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <1200860941-6922-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71191>

s=C3=B6ndagen den 20 januari 2008 skrev Roger C. Soares:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} catch (IOException e) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0//=
 TODO Auto-generated catch block
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0e.printStackTrace();


Unfortunately it is not that easy. Most of the TODO's are left there=20
intentionally. They signal work to do, i.e. proper error handling. At m=
inimum=20
we should use Eclipse's error logging. For JGit we could encapsulate it=
 a=20
little as we don't have direct access to the Eclipse runtime there.

BTW JGit is currently mostly GPL'ed. I want to have your permission to=20
relicense anything you contribute there under the EPL (Eclipse Public=20
License), just in case we go down that road and make it an Eclipse proj=
ect.

You put a finger on a sore point. We'll see if I can find a way to repl=
ace
those TODO's with something sensible.

Also, please Cc: directly for egit patches. Shawn, want Cc: to?

-- robin
