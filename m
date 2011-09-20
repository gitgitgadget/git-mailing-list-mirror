From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Worktree vs. working copy
Date: Tue, 20 Sep 2011 12:39:54 +0200
Message-ID: <4E786D7A.8020503@alum.mit.edu>
References: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Sep 20 12:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5xkN-0003t3-BF
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab1ITKkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 06:40:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59284 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1ITKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 06:40:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8KAdsMO022982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Sep 2011 12:39:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181751>

On 09/20/2011 09:50 AM, Carlos Mart=C3=ADn Nieto wrote:
> I've noticed that in some places in git.git, the term 'working copy' =
is
> used. Mostly it's in git-cvsserver which I guess it's fine, but the
> git-config man page talks about the 'working copy' in three places.
>=20
>     $ git grep 'worktree' | wc -l
>     412
>     $ git grep 'working copy' | grep -v ^git-cvsserver |  wc -l
>     32

Please note that the string "worktree" mostly appears in code
(presumably as variable names) and in the names of options.  In text,
"working tree" is far more common than either:

$ git grep -i 'worktree' -- '*.txt' | wc -l
50
$ git grep -i 'working copy' -- '*.txt' | wc -l
6
$ git grep -i 'working tree' -- '*.txt' | wc -l
330

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
