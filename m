From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email: Add auto-cc to all body signatures
Date: Thu, 08 Dec 2011 12:51:26 -0800
Message-ID: <1323377486.1762.71.camel@joe2Laptop>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	 <1311903782.20837.42.camel@jtkirshe-mobl>
	 <1323313119.1762.58.camel@joe2Laptop>
	 <7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jeffrey.t.kirsher@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 21:51:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYkwI-0002N1-6M
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 21:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab1LHUv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 15:51:29 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:39671 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751639Ab1LHUv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 15:51:28 -0500
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.151])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 18508468; Thu, 08 Dec 2011 12:51:28 -0800
In-Reply-To: <7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.1- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186594>

On Thu, 2011-12-08 at 11:37 -0800, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > Many types of signatures are used by various projects.
> > The most common type is formatted:
> > 	"[some_signature_type]-by: First Last <email@domain.tld>"
> > e.g:
> > 	"Reported-by: First Last <email@domain.tld>" (no quotes are used)
> This is just a phrasing issue, but I am a bit reluctant about the name
> "signature".

I've called all these markings signatures.
Maybe email-address-tags or another name could be used.
I'm not bothered one way or another by any chosen name.

> Does your change do the right thing on such an address-less entry?  The
> answer to this question must start with the definition of "the right thing
> to do is X", of course.

All addresses go through "extract_valid_address".
Invalid addresses are not used.
