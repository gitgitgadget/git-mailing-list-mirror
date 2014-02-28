From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 03:01:53 -0600
Message-ID: <857g8f1ugu.fsf@stephe-leake.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:02:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJLF-0006NY-By
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaB1JCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:02:34 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:32233 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751691AbaB1JC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 04:02:28 -0500
Received: from [75.87.81.6] ([75.87.81.6:53537] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id BA/FE-02678-38050135; Fri, 28 Feb 2014 09:02:27 +0000
In-Reply-To: <20140226202601.GK7855@google.com> (Jonathan Nieder's message of
	"Wed, 26 Feb 2014 12:26:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242909>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Andrew Wong wrote:
>
>> The first two patches are just about rewording a message, and adding messages
>> to tell users to use "git merge --abort" to abort a merge.
>
> Sounds like a good idea.  I look forward to reading the patches.
>
>> We could stop here and hope that the users would read the messages, but I think
>> git could be a bit more user-friendly. The last patch might be a bit more
>> controversial. It changes the default behavior of "git reset" to default to
>> "git reset --merge" during a merge conflict. I imagine that's what the user
>> would want most of the time, and not "git reset --mixed".
>
> I don't think that's a good idea.  I'm not sure what new users would
> expect; 

As a newbie, I would like to know how to abort the merge, so I like this
message. 

> in any case, making the command context-dependent just makes
> the learning process harder imho.  

I like commands that "do the right thing". So no, this would not be
confusing. 

> And for experienced users, this would be a bad regression.

Backward incompatibility is a real concern.

It might be best if "git reset" (with _no_ option) be made to error out,
so all users have to specify what they want.

The transition process Junio proposed sounds good to me.

-- 
-- Stephe
