From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Fri, 22 May 2009 18:02:09 -0700
Message-ID: <7vskiw4ooe.fsf@alter.siamese.dyndns.org>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
	<p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil>
	<p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat May 23 03:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7fcx-000736-6g
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 03:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbZEWBCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 21:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbZEWBCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 21:02:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56629 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbZEWBCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 21:02:08 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090523010210.LHM20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Fri, 22 May 2009 21:02:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id up291b0094aMwMQ04p29TD; Fri, 22 May 2009 21:02:09 -0400
X-Authority-Analysis: v=1.0 c=1 a=4ueMqUMRleoA:10 a=_0s4GiiSMUIA:10
 a=qivI3wbWerKyPwulet4A:9 a=NHRsY2BJSqCzl7T80OmZLYq-F9MA:4
X-CM-Score: 0.00
In-Reply-To: <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 22 May 2009 18\:47\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119755>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> This should still provide the same breadth of testing: a russian code set,
> a japanese code set, and unicode.  Wikipedia says that ISO8859-5 is not
> as commonly used as either CP1251 or KOI8-R, but it is available on these
> old platforms.  You'd think that if Solaris 7 has it _and_ IRIX has it,
> then everything else would too, but still feel free to drop this anyway.
> Neither of those platforms, or Solaris 10 (for me) can convert between
> any of the russian and japanese encodings, so t8005.[23] still fail, and I
> doubt there is any hope.

Thanks.

My earlier experience with Sun is that their iconv cannot convert between
different encodings of Japanese but can use UTF-8 as a pivot to convert,
e.g. SJIS -> UTF-8 -> ISO-2022.  Perhaps there is an workaround, but I
dunno.
