From: Geert Bosch <boschg@mac.com>
Subject: Re: A failing attempt to use Git in a centralized environment
Date: Wed, 30 Apr 2014 13:15:30 -0400
Message-ID: <5BA0AC67-CDD6-4725-B75D-B98F957EB51E@mac.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:15:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZ2s-0007s5-QD
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbaD3SPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:15:46 -0400
Received: from st11p01mm-asmtp002.mac.com ([17.172.204.237]:55827 "EHLO
	st11p01mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965059AbaD3SPp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2014 14:15:45 -0400
X-Greylist: delayed 3607 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2014 14:15:45 EDT
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
 by st11p01mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0N4U00H23T9YI2B0@st11p01mm-asmtp002.mac.com> for
 git@vger.kernel.org; Wed, 30 Apr 2014 17:15:34 +0000 (GMT)
In-reply-to: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
X-Mailer: Apple Mail (2.1874)
X-MANTSH: 1TEIXWV4bG1oaGkdHB0lGUkdDRl5PWBoaHhEKTEMXGx0EGx0YBBIZBBscEBseGh8
	aEQpYTRdLEQptfhcaEQpMWRcbGhsbEQpZSRcRClleF2hjeREKQ04XSxsbGmJCH2lsGVJzGXhzB
	xl/Gx0bH3NtEQpYXBcZBBoEHQdNSx0SSEkcTAUbHQQbHRgEEhkEGxwQGx4aHxsRCl5ZF2FGXnh
	4EQpMRhdsa2sRCkNaFxgaHwQYGRgEGRIEGxsfEQpCXhcbEQpEWBcYEQpESRcbEQpCRRdob2dSb
	X5uRgEBQxEKQk4XaEZCQB9IeR1HH2QRCkJMF3p9X2VgGAVtZltyEQpCbBdiblN/Z0JgEx9ofRE
	KQkAXZnkTbnJ7Glx/Eh8RCnBoF2ZlYWcafmJ5RWNQEQpwaBdtXGx/SRJcHXlMHxEKcGgXehNQZ
	U5QclhBbUgRCnBsF2xIGkdeQn8cZWFSEQpwTBdhZGxyeHoFcEJcSBE=
X-CLX-Spam: false
X-CLX-Score: 1011
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.96,1.0.14,0.0.0000
 definitions=2014-04-30_04:2014-04-30,2014-04-30,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1402240000 definitions=main-1404300263
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247752>


On Apr 28, 2014, at 02:29, Marat Radchenko <marat@slonopotamus.org> wrote:

> In short:
> 1. Hack, hack, hack
> 2. Commit
> 3. Push, woops, reject (non-ff)
> 4. Pull
> 5. Push

Just do pull --rebase? This is essentially the same as what SVN
used to do in your setup.

  -Geert
