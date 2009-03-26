From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Thu, 26 Mar 2009 08:15:49 +0100
Message-ID: <49CB2BA5.1070100@viscovery.net>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Magnus_B=E4ck?= <baeck@swipnet.se>
X-From: git-owner@vger.kernel.org Thu Mar 26 08:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjqI-0006lX-Cv
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 08:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbZCZHP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 03:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbZCZHP5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 03:15:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32796 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZCZHP4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 03:15:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lmjob-0007yC-GZ; Thu, 26 Mar 2009 08:15:49 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 470BE4E4; Thu, 26 Mar 2009 08:15:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090324215416.GB27249@jeeves.jpl.local>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114743>

Magnus B=E4ck schrieb:
> From what I gather the problematic conversion takes place in the Win3=
2
> layer, in which case we might be able to call the ZwQueryDirectoryFil=
e()
> kernel routine directly via ntdll.dll to obtain the file times straig=
ht
> from the file system. Has anyone explored that path, and would it be
> acceptable to make such a change?

It depends.

The disadvantages are that this function is only available on Windows X=
P
and later and that it is not present in the header files of MinGW gcc.
It's on you to prove that there are advantages that clearly outweigh th=
ese
disadvantages.

-- Hannes
