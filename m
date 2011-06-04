From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: pre-commit hook to reject whitespace
Date: Fri, 03 Jun 2011 19:23:44 -0500
Message-ID: <4DE97B10.8080006@gmail.com>
References: <isbqsf$vh8$1@dough.gmane.org>	<isbsf8$6id$1@dough.gmane.org> <BANLkTi=Gh9CStVkgp5gBs7XzG-dCXB+oUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:24:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeen-0008Az-Dx
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 02:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab1FDAXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 20:23:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37338 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab1FDAXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 20:23:47 -0400
Received: by ywe9 with SMTP id 9so963179ywe.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 17:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nTt++3c6J/ixlcbWxwuKfgFb+kOdf+QvnjJpCuznQYs=;
        b=ZWHATSwVH2KoenxWaqyrCWsmxlofmDcYf7wakSi9WEIyVtL8jkkwOMYDQczaYXzLs6
         dp4Vv4VhaUKrG78/QGB27568yMEHORUyon+irAnWhA3ILzvh1C+LL+PLH2WCmmHcRdC2
         Zipgjaq2ASpyX0jy9so9QFBuA3uqzB0DHNcW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=da2EN1s3LlbuRJQeHHMqljtH+QeLPd3MkedJ1GZzusW1felUyd6BgvM/OWBSFTc1Ni
         QR+c9zWiXhpCgdYbbMKyScgU5/HoNF4zohLRjXMYrhyY7XlONRnA9yZmm8SOu9+iRjfL
         OpsA9/AuOTUbfdIevfk6nqEikoGw4s9DZKgIg=
Received: by 10.101.194.26 with SMTP id w26mr1833163anp.24.1307147026746;
        Fri, 03 Jun 2011 17:23:46 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id j5sm1522097ani.5.2011.06.03.17.23.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 17:23:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <BANLkTi=Gh9CStVkgp5gBs7XzG-dCXB+oUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175052>

On 6/3/2011 7:12 PM, John Szakmeister wrote:
> On Fri, Jun 3, 2011 at 7:58 PM, Neal Kreitzinger<nkreitzinger@gmail.com>  wrote:
>> On 6/3/2011 6:31 PM, Neal Kreitzinger wrote:
>>>
>>> The reference manuals state in the hooks documentation that the pre-commit
>>> hook sample will reject whitespace only changes.  However, the
>>> pre-commit.sample in the 1.7.1 and 1.7.5.4 downloads do not appear to do
>>> this (I'm new to linux scripts).  The appear to only reject non-ascii
>>> filenames.  Does someone have a pre-commit hook example I can use to
>>> reject
>>> whitespace-only changes?  Thanks!
>>>
>> As someone kindly pointed out, the documentation actually says:
>> "The default 'pre-commit' hook, when enabled, catches introduction of lines
>> with trailing whitespaces and aborts the commit when such a line is found."
>>
>> I'm not seeing this functionality in the pre-commit.sample for 1.7.1 or
>> 1.7.5.4.
>
> I've never tried that hook script myself, but it appears to be on the last line:
>     exec git diff-index --check --cached $against --
>
> In particular, the --check option says:
>      Warn if changes introduce trailing whitespace or an indent that
> uses a space before a tab. Exits with non-zero status if problems are
> found. Not compatible with --exit-code.
>
Ah ha!  Thanks!

v/r,
neal
