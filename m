From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: exporting a .git file ?
Date: Mon, 27 Aug 2012 17:40:17 +0200
Message-ID: <503B94E1.5010803@alum.mit.edu>
References: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com> <CAPBPrnu1FNbWP+k6Nq5NudBFYZu9njjbcL+oL7m-z5sajuXpBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Aaron Gray <aaronngray.lists@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 17:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T61QV-0007fT-3y
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 17:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab2H0PkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 11:40:21 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61262 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653Ab2H0PkV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 11:40:21 -0400
X-AuditID: 12074412-b7f216d0000008e3-0f-503b94e43c04
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 77.4F.02275.4E49B305; Mon, 27 Aug 2012 11:40:20 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7RFeIwo004742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Aug 2012 11:40:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <CAPBPrnu1FNbWP+k6Nq5NudBFYZu9njjbcL+oL7m-z5sajuXpBg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqPtkinWAwdZHPBZXn91ltTj2+DOT
	RdeVbiYHZo+ds+6ye3zeJBfAFMVtk5RYUhacmZ6nb5fAnfHv/xzWgjNsFcsmmTcwrmbtYuTk
	kBAwkeg78JoRwhaTuHBvPVsXIxeHkMBlRon2bftZIZzjTBLNZ9rBOngFtCUOvv7BDGKzCKhK
	9GzpYAOx2QR0JRb1NDOB2KICIRJrvk1hhKgXlDg58wkLiC0ioCnRM3EB2BxmgRiJf0c3gs0R
	FlCReHLxKjvEsqmMEieWbQIr4hQIlDi/YyJQMwdQg7rE+nlCEL3yEtvfzmGewCgwC8mKWQhV
	s5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokRErBCOxjXn5Q7xCjA
	wajEwxt00ypAiDWxrLgy9xCjJAeTkiiv2CTrACG+pPyUyozE4oz4otKc1OJDjBIczEoivN/3
	WwYI8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8M6ZDDRUsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSn8cXASAVJ8QDtVQamBSHe4oLEXKAoROspRl2O
	z09P3mUUYsnLz0uVEuf9BrJDAKQoozQPbgUsPb1iFAf6WJj3N0gVDzC1wU16BbSECWjJfkWw
	JSWJCCmpBsZ1C6byFs2Z65ziUsG5+HtMXUzIus1W3Y37Zm9u9lfJc31ns2ep/u6ey38Xvp7I
	YCzXtcV9z+fd/2QbpIxPN069NWPjh78vVl5tXt0cv9Rqxv5Nbvn7HG1Pf/vXOuGn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204350>

On 08/27/2012 04:45 PM, Dan Johnson wrote:
> On Mon, Aug 27, 2012 at 10:32 AM, Aaron Gray <aaronngray.lists@gmail.com> wrote:
>> Hi,
>>
>> Is there anyway to get my git repository as a single file ?
> 
> You're probably looking for the git bundle command (see git bundle
> --help), but it's possible you might just want to use tar.

Please note that a "git bundle" will contain the contents of the
repository (commits, log messages, etc) but not the local configuration
like .git/config, .git/info/*, nor some other information like the
reflogs (history of old values of references).  This is probably what
you want.

A "tar" of the .git directory, by contrast, would include this local
information unless you exclude it explicitly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
