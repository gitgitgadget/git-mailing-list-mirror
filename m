From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv4 0/3] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Tue, 17 Apr 2012 15:30:21 -0400
Message-ID: <4F8DC4CD.9090106@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-1-git-send-email-marcnarc@xiplink.com> <7vbomqpef1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 21:29:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKE5y-0004G0-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 21:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087Ab2DQT3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 15:29:41 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:56101 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2DQT3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 15:29:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp14.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 378FF1D8279;
	Tue, 17 Apr 2012 15:29:40 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp14.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DAAD01D8084;
	Tue, 17 Apr 2012 15:29:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <7vbomqpef1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195795>

On 12-04-17 11:26 AM, Junio C Hamano wrote:
> marcnarc@xiplink.com writes:
> 
>> It turns out that ref->peer_ref is always NULL in update_local_ref().  So I
>> made its caller pass in the full remote ref as a new parameter.  I also added
>> a unit test.
>>
>> This series is a complete resend of all the patches discussed in these
>> threads, including Jens's submodule recursion fix.
> 
> Thanks, but I'd prefer to keep unrelated things as separate unless there
> is a compelling reason not to.
> 
> Also I do not think renaming of the existing parameter in the first patch
> is warranted, especially when the new parameter you are adding is more
> descriptive (i.e. "remote_ref" in the context of that function makes it
> clear enough that it is not just a string but is a pointer to a ref
> structure).
> 
> So let's do this.

I'm good with both your patches.  Thanks much for fixing my work!

		M.
