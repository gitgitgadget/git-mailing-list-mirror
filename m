From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Wed, 20 Oct 2010 10:01:59 -0400
Message-ID: <1287583319.16585.4.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <vpq8w1v5gce.fsf@bauges.imag.fr>
	 <BED961D6-5C2A-4535-B706-BFB9727CE398@gmail.com>
	 <vpqfww1ksh7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 20 16:04:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ZGq-0006Ch-GR
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 16:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0JTODz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 10:03:55 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:39212 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0JTODy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 10:03:54 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9KE25vr028112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Oct 2010 10:02:10 -0400
In-Reply-To: <vpqfww1ksh7.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9KE25vr028112
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288188131.38111@tmQwMALrA4LaKkPeZJc1/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159410>


On Wed, 2010-10-20 at 13:34 +0200, Matthieu Moy wrote:
> Thore Husfeldt <thore.husfeldt@gmail.com> writes:

> > Let me see if I can use the proposed terminology:
> >
> > 1. bob/master *tracks* master.
> > 2. bob/master is a remote-tracking branch
> 
> I do like the dash between remote and tracking.
> 
> This is roughly the current terminology, but as you pointed out, it's
> not used consistantly in the doc.

The only way in which "tracking" is not consistent is in that many
people seem to be insisting that one cannot apply the idiom of tracking
to ALL kinds of tracking that git does. Git tracks changes in CONTENT.
It matters not where that content is. It does not track files, branches,
nor repositories--those are mere containers of CONTENT that git tracks
the changes of.
Perhaps we need to make this more explicit in the documentation?

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
