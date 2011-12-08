From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: Query on git commit amend
Date: Thu, 8 Dec 2011 10:56:05 +0530
Message-ID: <4EE04A6D.5020503@st.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Vijay Lakshminarayanan <laksvij@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>,
	Vipin KUMAR <vipin.kumar@st.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 06:26:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYWUy-0004ne-KB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 06:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768Ab1LHF0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 00:26:18 -0500
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:35726 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836Ab1LHF0R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 00:26:17 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob118.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTuBKc0K6/NO02Bp0KnLfmSM1rH8GULk3@postini.com; Thu, 08 Dec 2011 05:26:17 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 140EEE2;
	Thu,  8 Dec 2011 05:17:41 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D87F5F21;
	Thu,  8 Dec 2011 05:26:07 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Thu, 8 Dec 2011
 13:26:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <87fwgxwvn9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186533>

On 12/6/2011 9:16 PM, Vijay Lakshminarayanan wrote:
> I've found 
> 
> $ GIT_EDITOR=cat git commit --amend
> 
> useful.
> 
> The benefit of this technique is that it even works for git-rebase -i.
> 
> In my typical git usage, I do a lot of git-commit --fixup's.  After
> reaching a level of stability, I change the history with:
> 
> GIT_EDITOR=cat git rebase -i --autosquash
> 
> and my history is adjusted without requiring manual intervention.

Hi Junio,

After going through autosquash option for rebase, i was wondering
if there is a way to create a new commit easily for autosquash.

For autosquash to work, we need to keep the same commit log/title,
prefixed with squash! or Fixup! etc. What about adding another option
in commit amend which adds squash! or Fixup! automatically. So, manual
intervention at all. :)

I don't know if it already exist.

-- 
viresh
