From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Remove the hard coded length limit on variable names
 in config files
Date: Mon, 01 Oct 2012 05:16:56 +0200
Message-ID: <50690B28.5030408@alum.mit.edu>
References: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org> <1348913979-27431-1-git-send-email-bdwalton@gmail.com> <5067C51F.6020908@alum.mit.edu> <CAP30j15wKa7wbLyaLo8omHcAh5u7O=Yt8Tjy4bD3V_0nT1zJPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 05:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIWVd-00079F-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 05:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2JADRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 23:17:18 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:64610 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751902Ab2JADRA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 23:17:00 -0400
X-AuditID: 1207440e-b7f036d0000008b5-68-50690b2b80a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CE.13.02229.B2B09605; Sun, 30 Sep 2012 23:16:59 -0400 (EDT)
Received: from [192.168.69.140] (p57A25472.dip.t-dialin.net [87.162.84.114])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q913GvSF032489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 30 Sep 2012 23:16:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <CAP30j15wKa7wbLyaLo8omHcAh5u7O=Yt8Tjy4bD3V_0nT1zJPQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqKvNnRlgcPasssWH2c0sFl1Xupks
	GnqvMDswe+ycdZfd4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNet6YVfGSrOHxiImsD4y7W
	LkZODgkBE4meaZfZIGwxiQv31gPZXBxCApcZJc5tOswM4Zxhkng9fzJYB6+AtkT3/vtMIDaL
	gKrEwnU3GUFsNgFdiUU9zWBxUYEQiRmXJzND1AtKnJz5hAXEFhFQlrh76A87iM0soCWxrqUX
	bLOwQLTE0tYjLBDLLjJKzFq/BmwZp0CgxLV566AadCTe9T1ghrDlJba/ncM8gVFgFpIds5CU
	zUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSPDy7WBsXy9ziFGA
	g1GJh3fR5YwAIdbEsuLK3EOMkhxMSqK8LeyZAUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeDln
	AJXzpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4ZbiAhgoWpaanVqRl
	5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL1nOYHaeYsLEnOBohCtpxh1Odbe
	XfCAUYglLz8vVUqc1xxkhwBIUUZpHtwKWKp6xSgO9LEwLz9IFQ8wzcFNegW0hAloSdWqNJAl
	JYkIKakGRoFjL92N8xgfbZjAwK6yY6P0l1+5ZiL/LvQdfLB+U/m6O992it2PyxJ4tG/211uP
	c0TSX+tudGTZsXNWHufDpeFsn568OfhQrjdqfTfD7DW2H3hDfS2MJZ9lCr6bpf// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206709>

On 09/30/2012 08:20 PM, Ben Walton wrote:
>> The patch doesn't apply to the current master; it appears to have been
>> built against master 883a2a3504 (2012-02-23) or older.  It will have to
>> be rebased to the current master.
> 
> Junio had asked that it be based on maint so that's what I (thought
> I?) did.  I'm happy to redo it against master if that's better though.

That explains it.  Sorry, I hadn't seen that conversation.  (In the
future, if a patch applies against something other than master, please
add a note in the cover letter or in the patch comment after the "--".)

It is OK with me to leave the patch against maint, if that is what Junio
wanted.  It would help, though, if you rebase it to the latest maint
(the conflict seems easy to fix).

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
