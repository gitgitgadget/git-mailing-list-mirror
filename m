From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Minor grammar fix in the 'Not a git repository' message
Date: Tue, 17 Feb 2009 00:27:20 +0100
Message-ID: <E8469C6E-A238-4DD0-B287-09E8ABCE4801@wincent.com>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de> <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCtZ-0001b1-TX
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 00:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZBPX1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 18:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZBPX1a
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 18:27:30 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:52051 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZBPX1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 18:27:30 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1GNRLCf008328
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 16 Feb 2009 18:27:23 -0500
In-Reply-To: <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110263>

El 16/2/2009, a las 23:58, Johannes Schindelin escribi=F3:

> It might cause less head-scratching to say 'nor any of the parent
> directories' than 'or ...' after saying that this is not a git
> repository.
>
> -			die("Not a git repository (or any of the parent directories): =20
> %s", DEFAULT_GIT_DIR_ENVIRONMENT);
> +			die("Not a git repository (nor any of the parent directories): =20
> %s", DEFAULT_GIT_DIR_ENVIRONMENT);

Or could just avoid the whole "or/nor" construct entirely by just =20
saying?

   "Not inside a git repository"
