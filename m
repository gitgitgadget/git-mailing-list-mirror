From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: Query on git commit amend
Date: Wed, 7 Dec 2011 09:50:24 +0530
Message-ID: <4EDEE988.2070902@st.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com> <7vobvlfowk.fsf@alter.siamese.dyndns.org> <87wra9und4.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Vijay Lakshminarayanan <laksvij@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 05:20:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY8zp-0005WJ-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 05:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab1LGEUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 23:20:36 -0500
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:34767 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753289Ab1LGEUf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 23:20:35 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob112.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTt7pj6L0jCqVgTMIxgox+/IQ+6yVob+E@postini.com; Wed, 07 Dec 2011 04:20:35 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 91B6D84;
	Wed,  7 Dec 2011 04:12:01 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6FADEC95;
	Wed,  7 Dec 2011 04:20:27 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Wed, 7 Dec 2011
 12:20:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <87wra9und4.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186419>


Thanks guys. This whole session was new to me.

On 12/7/2011 7:58 AM, Vijay Lakshminarayanan wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> > Vijay Lakshminarayanan <laksvij@gmail.com> writes:
>> >
>>> >> I've found 
>>> >>
>>> >> $ GIT_EDITOR=cat git commit --amend
>>> >>
>>> >> useful.
>> >
>> > Are you sure it is a cat?
> Yes.

This didn't worked for me. Got following error:

cat: unrecognized option `--amend'
Try `cat --help' for more information.
error: There was a problem with the editor 'cat git commit --amend'.
Please supply the message using either -m or -F option.
Could not commit staged changes.

>> > I almost always use
>> >
>> >     $ EDITOR=: git commit --amend

Even this didn't worked for me:

error: pathspec '.git/COMMIT_EDITMSG' did not match any file(s) known to git.
error: There was a problem with the editor 'git commit --amend'.
Please supply the message using either -m or -F option.
Could not commit staged changes.

Only "true" worked for me.

Probably, i have an older version of git (version 1.7.2.2)

One more thing. I couldn't get completely how this worked. Maybe any pointers to
earlier discussions.

The way i am testing it is:
- Stop after a commit in middle of rebase using "edit" or "e" option
- set EDITOR or GIT_EDITOR
- change files
- git add changed_files
- git rebase --continue

-- 
viresh
