From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: Special characters in file name
Date: Fri, 02 Sep 2011 14:06:40 +0200
Message-ID: <4E60C6D0.7090609@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 14:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzSWi-00074Y-5S
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 14:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab1IBMHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Sep 2011 08:07:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57223 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1IBMHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 08:07:09 -0400
Received: from [192.168.1.101] (94-21-178-53.pool.digikabel.hu [94.21.178.53])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MTcI8-1QZ1fm3Xvc-00R2mo; Fri, 02 Sep 2011 14:07:07 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.20) Gecko/20110804 Thunderbird/3.1.12
X-Provags-ID: V02:K0:+oo5TY8+s3I/YoOqJrnkkuS+JpmKe2psQD5DHEUbdPM
 N19/cv0nT289XKtU5vLoPkxn04wR7XfG6m5cKLTiPyD4IRwkmx
 LRFrW/7gKutLUvKap3SA3d08oIuW9PJlm82/coRETnlPQmHyuE
 4Nt3aE0fOF1iWvxZoW5TDDu1XPwCE6KTiuqSS8Y7nMvAgcmXoH
 clApoOEHK4rFq1dkin44OGB7NUNPJ1KaGkrtStMkSCJN+kY6Sw
 PxYn0X9E84qyv23OQNuFXYn83KW+KJYJttaGHTA1YBTZkpIF9D
 1wWr4UYx6EnbAAdoBTE7Tp/+SV6bT/00XJPNGybmMufYKxQG38
 jQePNarMPN79l9T0HrS0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180607>

Dear List,

I have a file named "=E1rv=EDz.txt" in my repository. When modify that =
file=20
and execute git diff, the first line looks like this:
diff --git "a/\303\241rv\303\255z.txt" "b/\303\241rv\303\255z.txt"

Is there an option that (if specified) will get git to print "=E1rv=EDz=
=2Etxt"=20
instead of this escaped string?

Thanks in advance,
=C1kos Tajti
