From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 22:05:27 +0200
Message-ID: <5171A387.808@kdbg.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com> <1366348458-7706-2-git-send-email-felipe.contreras@gmail.com> <7vfvym30t8.fsf@alter.siamese.dyndns.org> <CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com> <7v8v4e1fyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 22:05:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHYt-0005Bl-5E
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 22:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab3DSUFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 16:05:31 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:13369 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753980Ab3DSUFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 16:05:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8CED8CDF82;
	Fri, 19 Apr 2013 22:05:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1BE9319F5A8;
	Fri, 19 Apr 2013 22:05:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v8v4e1fyz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221817>

Am 19.04.2013 21:24, schrieb Junio C Hamano:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> On Fri, Apr 19, 2013 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>> The code finds the changes of a commit, runs 'git blame' for each chunk
>>>> to see which other commits are relevant, and then reports the author and
>>>> signers.
> 
> But I think it can be useful outside the context of send-email as
> well, and having one independent tool that does one single job well
> is a better design.  Perhaps it is better to name it less specific
> to send-email's cc-cmd option.  "git people"?  "git whom"?  "git
> reviewers"?  I dunno, but along those lines.

Would it make sense to integrate this in git shortlog, which already
does something similar?

-- Hannes
