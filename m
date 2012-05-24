From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
  generating message ids
Date: Thu, 24 May 2012 22:49:55 +0200
Message-ID: <4FBE9EF3.9020902@alum.mit.edu>
References: <4FBE2335.2090903@jpk.com> <20120524171640.GB3161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXf5m-0004th-OL
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab2EXU5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:57:01 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:59151 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752345Ab2EXU5A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 16:57:00 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 16:57:00 EDT
X-AuditID: 1207440c-b7fc26d0000008c0-69-4fbe9ef5b94b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.8B.02240.5FE9EBF4; Thu, 24 May 2012 16:49:57 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0D6A9.dip.t-dialin.net [79.192.214.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4OKntvH003934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 16:49:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120524171640.GB3161@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqPt13j5/g6svlS26rnQzWTT0XmG2
	+NHSw+zA7PGsdw+jx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfsa33DVHCWp+LhkfvMDYy9
	XF2MnBwSAiYSP462sULYYhIX7q1n62Lk4hASuMwo8b95FZRzlkli5oo3TCBVvALaEq9WPGMD
	sVkEVCW+ftoM1s0moCuxqKcZqIaDQ1QgTGL1Aw2IckGJkzOfsIDYIgKyEt8Pb2QEsZkFoiTO
	v/wPFhcWSJPYcec2M4gtJBAiseXmcTCbU8BK4tTWTiaIejOJrq1dUL3yEtvfzmGewCgwC8mK
	WUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJHR5djB+Wydz
	iFGAg1GJh5c5ep+/EGtiWXFl7iFGSQ4mJVFer9lAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	gpFAOd6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBK8YMEaFBItS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRGl8MjFWQFA/QXh6Qdt7igsRcoChE6ylGXY4r
	vydeZxRiycvPS5US580GKRIAKcoozYNbAUtUrxjFgT4W5r07F6iKB5jk4Ca9AlrCBLRky+O9
	IEtKEhFSUg2MwhN09H+mH1rjNEn82aapjZ1fqo3n8WjzR5tdCDP1tr5bdedueFzf1jLZxSvK
	LFyzEv69cmT6fKk34tPlRcFP4o/tvlpQnHJDeUPJ9DeOWYVRQgevvtod62E690m9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198428>

On 05/24/2012 07:16 PM, Jeff King wrote:
> On Thu, May 24, 2012 at 02:01:57PM +0200, Michael Haggerty wrote:
>
>> On my setup, the above commit causes 12 tests in t4014 to fail.  For
>> example, test 25:
>>
>>> -Message-Id:<0>
>>> +Message-Id:<1135adfeed86678c55e1aad7c568046ee8215660.1337860646.git.mhagger@michael.(none)>
>
> Thanks for the report. I know exactly what the issue is, as it came up
> in the discussion of the original series. 43ae9f47ab stopped using
> git_committer_info (which looks at $GIT_COMMITTER_EMAIL) for the end of
> the message-id and started using the default-generated email directly.
>
> Nobody should care, because either:
>
>    1. The defaults set up a reasonable hostname for your machine.
>
>    2. They do not, but you adjust it by setting user.email. Otherwise,
>       your author ident would have this bogus email in it.

I'm trying hard not to get sucked into this topic (I just want the test 
suite to work again!) but I infer that the reason for the failure in my 
setup is that I have a global user.name but no global user.email 
configured.  I want git to remind me to configure user.email at the 
repository level so that I can set my work email address for proprietary 
projects and my personal email for open-source projects.

Ignorant idea: since this test is executed in a test repo, would it help 
to set a dummy user.name and user.email at the test repository level 
using "git config", perhaps as part of the standard test repo setup?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
