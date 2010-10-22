From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
	UTF-8...?
Date: Fri, 22 Oct 2010 13:27:06 -0400
Message-ID: <1287768426.31218.75.camel@drew-northup.unet.maine.edu>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	 <20101022161851.GH9224@burratino>
	 <1287766916.31218.71.camel@drew-northup.unet.maine.edu>
	 <20101022171248.GA11794@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9LPv-0000ar-St
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab0JVR2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:28:33 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:59923 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060Ab0JVR2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:28:33 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MHRB5m019686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 13:27:11 -0400
In-Reply-To: <20101022171248.GA11794@burratino>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MHRB5m019686
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288373238.60158@oPfMfBi9vj62bC6+/9ksaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159715>


On Fri, 2010-10-22 at 12:12 -0500, Jonathan Nieder wrote:
> Hi again,
> 
> Drew Northup wrote:
> 
> > That still doesn't fix the crlf issue, for starters. Also, I would like
> > to be able to email patches for files that are in UTF-16 and properly
> > re-import them. Unless I'm missing something really big there's not much
> > that a display filter is going to do for me there.
> 
> Right, I think you're missing something big.  textconv is a display
> filter.  clean/smudge convert between internal and external
> representation (and your clean/smudge scripts could take care of CRLF
> themselves if desired).
> 
> That said, I wouldn't be surprised if clean/smudge filters don't do
> everything you want.  If you do go that way, please keep the list
> posted so the mechanism can be improved.

Well I shall plumb the documentation again.... just in case. I'm not
holding my breath that it will do what I (and frankly a fair number of
other people) want. We just want version control that treats text like
text. FULL STOP. Why isn't UTF-16 text???????

> And longer term, maybe people will want something tailor-made after
> all?  I just imagine it would be more productive to try out the
> generic mechanisms first.

Please forgive me for being offended that UTF-16 text is not "generic"
enough.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
