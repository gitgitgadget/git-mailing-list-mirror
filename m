From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 15:15:54 -0400
Message-ID: <20130820151554.6afbcb7f@gandalf.local.home>
References: <5213873A.6010003@windriver.com>
	<xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
	<5213B95D.3040409@windriver.com>
	<xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrPN-0004zh-2G
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab3HTTP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:15:57 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7209 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab3HTTP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:15:56 -0400
X-Authority-Analysis: v=2.0 cv=KJ7Y/S5o c=1 sm=0 a=Sro2XwOs0tJUSHxCKfOySw==:17 a=Drc5e87SC40A:10 a=JcweFNKryUAA:10 a=5SG0PmZfjMsA:10 a=kj9zAlcOel0A:10 a=meVymXHHAAAA:8 a=KGjhK52YXX0A:10 a=psXsv1EI8KAA:10 a=ybZZDoGAAAAA:8 a=t7CeM3EgAAAA:8 a=FM-c_rLgVo3zbo-D5b8A:9 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=2e6ZYRoF4I4A:10 a=Sro2XwOs0tJUSHxCKfOySw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.255.60.225
Received: from [67.255.60.225] ([67.255.60.225:51288] helo=gandalf.local.home)
	by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id C0/ED-02415-B60C3125; Tue, 20 Aug 2013 19:15:55 +0000
In-Reply-To: <xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232634>

On Tue, 20 Aug 2013 12:07:18 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
> > OK, so given your feedback, how do you feel about a patch to the
> > documentation that indicates to use "-v" in combination with the
> > "--check" to get equivalent "patch --dry-run" behaviour?   If that
> > had existed, I'd have not gone rummaging around in the source, so
> > that should be good enough to help others avoid the same...
> 
> I do not think it is necessarily a good idea to assume that people
> who are learning "git apply" know how GNU patch works.

Linus told me that "git apply" was basically a replacement for patch.
Why would you think it would not be a good idea to assume that people
would not be familiar with how GNU patch works?

Is it because you expect "git apply" to eventually replace patch all
out, and want no dependencies on its knowledge?

-- Steve


> 
> But I do agree that the description of -v, --verbose has a lot of
> room for improvement.
> 
> 	Report progress to stderr. By default, only a message about the
> 	current patch being applied will be printed. This option will cause
> 	additional information to be reported.
> 
> It is totally unclear what "additional information" is reported at
> all.
> 
> Thanks.
