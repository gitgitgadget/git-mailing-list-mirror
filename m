From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Wed, 16 Feb 2011 17:21:37 -0700
Message-ID: <201102161721.37389.olsonse@umich.edu>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu> <4D5C2F33.8020309@web.de> <7v7hczirnz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 01:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pprmk-0000k6-Os
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 01:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab1BQAbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 19:31:50 -0500
Received: from 28dayslater.mr.itd.umich.edu ([141.211.12.118]:47676 "EHLO
	28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781Ab1BQAbs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 19:31:48 -0500
Received: FROM hackers.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.14.81])
	By 28dayslater.mr.itd.umich.edu ID 4D5C6A1A.B14F8.15397 ;
	16 Feb 2011 19:21:46 EST
Received: FROM localhost (cadash.gpcc.itd.umich.edu [141.211.2.218])
	By hackers.mr.itd.umich.edu ID 4D5C6A15.A3781.17591 ;
	Authuser olsonse;
	16 Feb 2011 19:21:41 EST
User-Agent: KMail/1.9.4
In-Reply-To: <7v7hczirnz.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167024>

I'll fix the POSIX issue and commit message and re-submit.  (I wasn't aware 
that for loops were from a bash-ism).

On Wednesday 16 February 2011 14:41, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > So this looks like a worthwhile fix. The commit message and POSIX issue
> > need to be addressed, tests would be a good thing to add too, but apart
> > from that it looks sane.
>
> Thanks for a translation ;-).  I agree everthing you said above.
