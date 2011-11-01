From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Recovery after interrupted repack
Date: Tue, 01 Nov 2011 10:49:17 -0400
Message-ID: <1320158957.14775.7.camel@drew-northup.unet.maine.edu>
References: <8339egazbf.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Nov 01 15:50:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLFfa-0007WG-0k
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 15:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152Ab1KAOuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 10:50:19 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:50627 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab1KAOuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 10:50:19 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id pA1EnL7l000321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Nov 2011 10:49:26 -0400
In-Reply-To: <8339egazbf.fsf@kalahari.s2.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: pA1EnL7l000321
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1320763774.09337@1YN38bOdHPaZPQY+oi2qwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184568>

On Wed, 2011-10-26 at 12:15 +0300, Hannu Koivisto wrote:
> Hi,
> 
> I interrupted git repack -a -f -d and now most commands say "fatal:
> bad object HEAD".  Additionally an attempt to run git repack again
> says a bunch of "error: refs/heads/foo does not point to a valid
> object!" messages.
> 
> git fsck prints a huge list of "missing blob <sha-1>" lines.
> 
> I'm using a Cygwin build of git 1.7.5.1 (I also have a build of the
> latest master available).

Was the result any different after running git fsck on it? If all else
fails you can probably still use the contents of the reflog to fix
things, but I'm not the best reference on such matters.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
