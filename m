From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Alphabetize git config --list
Date: Tue, 29 May 2012 07:21:47 +0200
Message-ID: <4FC45CEB.4070808@alum.mit.edu>
References: <CAFus=5=cp62hpLM_Odog--Q0vER8kkT5Doqo28i-yZQyfvv4gQ@mail.gmail.com> <20120528212309.GA4220@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Zach <zach@letmesearchthat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 29 07:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZEzZ-0004TQ-P7
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 07:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab2E2F3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 01:29:07 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:42596 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751319Ab2E2F2x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 01:28:53 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 May 2012 01:28:53 EDT
X-AuditID: 1207440e-b7f256d0000008c1-29-4fc45cef81b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 46.EB.02241.FEC54CF4; Tue, 29 May 2012 01:21:51 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0CD71.dip.t-dialin.net [79.192.205.113])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4T5Lnmh003815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 May 2012 01:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120528212309.GA4220@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqPs+5oi/wd8WbouuK91MFj9aepgt
	Hh17weLA7HG9v5XZ41nvHkaPz5vkApijuG2SEkvKgjPT8/TtErgz1kw5xV5wk7Vi+v4GlgbG
	XSxdjJwcEgImEl9vtjNB2GISF+6tZ+ti5OIQErjMKPHhwnko5yyTxMStVxhBqngFtCUW3Ghk
	B7FZBFQl7n2dARZnE9CVWNTTDDSJg0NUIExi9QMNiHJBiZMzn4AtExGQlfh+eCNYObOAhcTB
	WV/A4sICWhIPlqxiBbGFBOokFlzZDxbnFLCSuD9hGztEvZlE19YuqF55ie1v5zBPYBSYhWTF
	LCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokRErx8Oxjb18sc
	YhTgYFTi4WVeeNhfiDWxrLgy9xCjJAeTkiivXfQRfyG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vO/7gcp5UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8OcAoFRIsSk1P
	rUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHt9QNp5iwsSc4GiEK2nGHU5
	rvyeeJ1RiCUvPy9VSpzXFqRIAKQoozQPbgUsVb1iFAf6WJg3CKSKB5jm4Ca9AlrCBLRk2s2D
	IEtKEhFSUg2Mdby3k2+fXvJgO8NX3ewXnnv039lz/z+b90/L7ZBr659voY+cJyuufiH6MeN7
	fyHPhhNHyl5tFuNaVHWz+49U4peFNp3zAh3U1mss3OcmG2h6fM76p4F/2Pc+2PP/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198731>

On 05/28/2012 11:23 PM, Jeff King wrote:
> On Mon, May 28, 2012 at 01:58:28PM -0700, Zach wrote:
>
>> I was wondering if it would be possible to alphabetically order git
>> config --list by default.
>>
>> Essentially this
>> $ git config --list | sort
>
> No, it's not a good idea; the order of keys is important. For example,
> [...]

Is the order of *keys* important, or only the order of *values* for a 
given key?  I believe that one could sort the output by key as long as 
the values for each key are kept in their original order (i.e., sort 
stably by key).  This would indeed make it easier to read the output.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
