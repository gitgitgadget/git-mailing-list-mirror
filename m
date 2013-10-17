From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Thu, 17 Oct 2013 21:11:21 +0100
Organization: OPDS
Message-ID: <3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com><xmqqeh7k51vg.fsf@gitster.dls.corp.google.com><29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley> <xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 17 22:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtue-0003h4-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 22:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762748Ab3JQULM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 16:11:12 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:22574 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762569Ab3JQULM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 16:11:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnYMAHJDYFJOl3+a/2dsb2JhbABbDoJ5iXG1GAQEAoEoF3RpAQGBHwEBFAEEAQEFCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYBEggCAQIDAYU4BwGCFiPAfI4ugSODJoEHA4kEhhKadIE6LH9AOw
X-IPAS-Result: AnYMAHJDYFJOl3+a/2dsb2JhbABbDoJ5iXG1GAQEAoEoF3RpAQGBHwEBFAEEAQEFCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYBEggCAQIDAYU4BwGCFiPAfI4ugSODJoEHA4kEhhKadIE6LH9AOw
X-IronPort-AV: E=Sophos;i="4.93,516,1378854000"; 
   d="scan'208";a="440017313"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip03ir2.opaltelecom.net with SMTP; 17 Oct 2013 21:11:10 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236316>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> ... and the detection process for 'toplevel' may not work
>> properly when in a separated work-tree environment.
>
> Without GIT_WORK_TREE exported to point at the top-level, there is
> nothing that lets us "detect" it, as the working tree does not have
> ".git" directory to tell us to stop, no?
>

"No", but not in that way.

My point (to Dale) was, as you state, that the "cd to top level" was 
(IIUC) the probable causes of the fault, and that a documentation update 
would probably be appropriate for the discussion on exporting 
GIT_WORK_TREE, and that it would specifically mention those git commands 
that needed to "cd to top level", and hence would not work in such an 
environment. (I wasn't sure where the appropriate "cd to top level" 
function was)

An explanation here on the list wouldn't solve the problems for others 
who are yet to make the same mistake, hence the implied suggestion.

Philip 
