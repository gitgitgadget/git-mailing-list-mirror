From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 11:13:41 -0400
Message-ID: <4F5E12A5.6030701@xiplink.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>  <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76wW-0003ra-5s
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab2CLPNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:13:44 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:37945 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab2CLPNn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:13:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id F104581B1;
	Mon, 12 Mar 2012 11:13:42 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp8.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4F03080B6;
	Mon, 12 Mar 2012 11:13:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F5AF1A8.4050604@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192885>

On 12-03-10 01:16 AM, Michael Haggerty wrote:
> 
> I propose that the default should be even stricter: like "current", it
> would push to an branch with the same name as the current local branch,
> *but only if that branch already exists on the remote*.  It would only
> be possible to create a new branch on the remote by calling "git push"
> with an explicit branch argument.  I believe that such a policy would do
> the right thing in the cases where the "right thing" is pretty
> unambiguous, and would require a user decision in other cases.

I haven't thought it through very deeply, but at first glance this seems like
reasonable default behaviour to me.

		M.
