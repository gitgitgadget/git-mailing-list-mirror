From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Tabs in commit messages - de-tabify option in
 strbuf_stripspace()?
Date: Wed, 16 Mar 2016 10:27:45 -0400
Message-ID: <56E96D61.6060007@xiplink.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
 <xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
 <CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
 <CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:32:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agCV8-0001XL-Id
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 15:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935074AbcCPOcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 10:32:23 -0400
Received: from smtp114.iad3a.emailsrvr.com ([173.203.187.114]:41167 "EHLO
	smtp114.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933471AbcCPOcX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 10:32:23 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Mar 2016 10:32:23 EDT
Received: from smtp23.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp23.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 5B18228074A;
	Wed, 16 Mar 2016 10:27:00 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D44D92802EB;
	Wed, 16 Mar 2016 10:26:59 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Wed, 16 Mar 2016 10:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288976>

On 16-03-15 09:02 PM, Stefan Beller wrote:
> On Tue, Mar 15, 2016 at 6:00 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> Instead of converting to whitespaces in Git, we could make use of the
>> set_tabs capability for ttys and setup the terminal for having tabs align
>> to 12,+8,+8,+8...
> 
> Or rather read in the existing tabs configuration and shift it by a constant.

Could this also help with diff output, where the leading + or - mars the
indentation in a similar way?

That opens a bit of a deeper problem, because not all the files in a single
repo necessarily use the same tab size.

		M.
