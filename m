From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 13/14] revert: Introduce --continue to continue the
	operation
Date: Wed, 06 Jul 2011 17:52:38 -0400
Message-ID: <1309989158.13231.7.camel@drew-northup.unet.maine.edu>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
	 <1309938868-2028-14-git-send-email-artagnon@gmail.com>
	 <7vliwbjebk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qea2U-0007DZ-17
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 23:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab1GFVxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 17:53:41 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:41281 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1GFVxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 17:53:40 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p66LqiJh013143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Jul 2011 17:52:44 -0400
In-Reply-To: <7vliwbjebk.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=6 Fuz1=6
	Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p66LqiJh013143
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1310594009.36635@VfiICoIJDoCG9gPO/SmlMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176733>


On Wed, 2011-07-06 at 14:21 -0700, Junio C Hamano wrote:
> > +static void verify_opt_mutually_compatible(const char *me, ...)
> > +{
> 
> Isn't "being compatible" by definition "mutual"?  

As a strict matter of language, no. And example we see far too often
@work is that MS Office 2010 is compatible with MS Office 2007, but the
same cannot be said the other way around. (Now if I can convince them
that not everyone in the world has MS Office...)
> 
> I.e. verify-option-compatibility perhaps?

+1 sensible, if that's the intention.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
