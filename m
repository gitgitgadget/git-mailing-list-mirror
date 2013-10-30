From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/23] t5510: prepare test refs more straightforwardly
Date: Wed, 30 Oct 2013 18:41:38 +0100
Message-ID: <527144D2.1090702@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu> <1383111192-23780-3-git-send-email-mhagger@alum.mit.edu> <CALkWK0=tcEbdvFaaV1YFBTXWAHaHYcJ1YNLpj0Sj5sGK_inapQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:41:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZm7-0007V7-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab3J3Rln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:41:43 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62412 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865Ab3J3Rln (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 13:41:43 -0400
X-AuditID: 12074412-b7fc96d0000023d5-e9-527144d64f33
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BB.6A.09173.6D441725; Wed, 30 Oct 2013 13:41:42 -0400 (EDT)
Received: from [192.168.69.9] (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9UHfcPE012131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 13:41:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CALkWK0=tcEbdvFaaV1YFBTXWAHaHYcJ1YNLpj0Sj5sGK_inapQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsUixO6iqHvNpTDIYMlsaYtVMx+zW0zvWs1i
	0XWlm8miofcKs8W8u7uYLFbdWsZssXLGDUaLp52VFvNevGCz+NHSw+zA5XFp3Usmj0N/prB7
	PDvRzuaxc9Zddo9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE748StFcwFfdwVO3b+YG9g7OfsYuTkkBAwkfjy6DE7hC0mceHeerYuRi4OIYHLjBJ7j05n
	hXDOMkl83LGDDaSKV0BbYnnrXbAOFgFVicXdD1hBbDYBXYlFPc1MILaoQIjEwlXH2SHqBSVO
	znzC0sXIwSECVPNslTdImFmgj1ni2V89EFtYwFdi2/GZzBC7DjFK/Nw5BWwmp0CgxKoTZ9lA
	epkF1CXWzxOC6JWX2P52DvMERoFZSDbMQqiahaRqASPzKka5xJzSXN3cxMyc4tRk3eLkxLy8
	1CJdM73czBK91JTSTYyQGBLawbj+pNwhRgEORiUeXgbdwiAh1sSy4srcQ4ySHExKorzszkAh
	vqT8lMqMxOKM+KLSnNRioIM5mJVEeL0dgXK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNT
	UwtSi2CyMhwcShK8/SBDBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFxGl8MjFSQ
	FA/Q3mKQdt7igsRcoChE6ylGXY55Xz58YxRiycvPS5US550MUiQAUpRRmge3ApYwXzGKA30s
	zLsOpIoHmGzhJr0CWsIEtGQPSx7IkpJEhJRUA2OKX++5TerRtmKnru/culg4mu/0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237047>

On 10/30/2013 11:57 AM, Ramkumar Ramachandra wrote:
> Michael Haggerty wrote:
>> "git fetch" was being used with contrived refspecs to create tags and
>> remote-tracking branches in test repositories in preparation for the
>> actual tests.  This is obscure and also makes one wonder whether this
>> is indeed just preparation or whether some side-effect of "git fetch"
>> is being tested.
> 
> As the test titles indicate, we are exercising the 'fetch --prune'
> functionality. However, I don't see the 'git fetch <remote>
> <src>:<dst>' form exercised anywhere else in the file.

I see a couple of examples:

$ grep 'git fetch.*:' t/t5510*.sh
	git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
	git fetch --prune --tags origin
refs/heads/foo/*:refs/remotes/origin/foo/* &&
	git fetch .. :track &&
	test_must_fail git fetch .. anno:five
	git fetch .. six:six
	test_must_fail git fetch "$D/bundle1" master:master
	git fetch ../bundle2 master:master &&
	 git fetch "rsync:$(pwd)/../.git" master:refs/heads/master &&
	test_must_fail git fetch . side:master
	git fetch --update-head-ok . side:master

The tests in question didn't really check the results of the fetch
anyway.  I don't think they were intended to test fetch but only to set
up the initial conditions for the real test.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
