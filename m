From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCHv3 1/2] Documentation: clarify fnmatch behavior in
	gitignore
Date: Wed, 06 Apr 2011 08:48:17 -0400
Message-ID: <1302094097.25009.6.camel@drew-northup.unet.maine.edu>
References: <1302041878-24426-1-git-send-email-eblake@redhat.com>
	 <7vfwpwl43h.fsf@alter.siamese.dyndns.org>  <4D9B9B15.8040600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org, jrnieder@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:50:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7SCE-0006G5-3C
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 14:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab1DFMup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 08:50:45 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:52206 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab1DFMuo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 08:50:44 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p36CmLJj002243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Apr 2011 08:48:26 -0400
In-Reply-To: <4D9B9B15.8040600@redhat.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=5
	Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p36CmLJj002243
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1302698914.97201@pW01niYCFXwPk8IcoyBAeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170969>


On Tue, 2011-04-05 at 16:43 -0600, Eric Blake wrote:
> On 04/05/2011 04:34 PM, Junio C Hamano wrote:
> >>   - Otherwise, git treats the pattern as a shell glob suitable
> >> -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> >> -   wildcards in the pattern will not match a / in the pathname.
> >> -   For example, "Documentation/{asterisk}.html" matches
> >> +   for consumption by fnmatch(3) with the FNM_PATHNAME but not
> >> +   FNM_PERIOD flags: wildcards in the pattern will match leading
> >> +   . but not / in pathnames.  For example,
> > 
> > Does this format correctly with asciidoc?
> 
> No idea - I'm not an asciidoc whiz.  How would I tell (or can someone
> else offer some advice)?

For my ongoing project of rearranging some of the Gitweb documentation I
just went ahead and made a script based on the Documentation/Makefile
and run that against my in-progress work. (In that case I'll get around
to munging the local Makefile later if I decide I'm really that pleased
with what I've [re-]written.) This way I can incrementally become an
Asciidoc genius if I really need to and remain a mortal otherwise.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
