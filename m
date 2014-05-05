From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 12:52:28 +0200
Message-ID: <53676D6C.4010009@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>	<87ppjt6xjv.fsf@igel.home> <87lhugu7iw.fsf@fencepost.gnu.org>	<87vbtk60lh.fsf@igel.home> <87d2fstuzw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>, Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhxX-0005Yp-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaEEKwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 06:52:35 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55792 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343AbaEEKwe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2014 06:52:34 -0400
X-AuditID: 1207440e-f79c76d000003e2c-e7-53676d71a96f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.AC.15916.17D67635; Mon,  5 May 2014 06:52:33 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB24B0.dip0.t-ipconnect.de [93.219.36.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s45AqSvd020928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 May 2014 06:52:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <87d2fstuzw.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqFuYmx5ssGeXgcXsG9vYLLqudDNZ
	PJl7l9mibeYPJov+pR1sDqwey2/+ZfJom2bm8fBVF7vHocMdjB6fN8kFsEZx2yQllpQFZ6bn
	6dslcGfsmCxdsJK34vnbK8wNjLe5uhg5OSQETCSeT+1jhrDFJC7cW8/WxcjFISRwmVFi8p51
	jBDOOSaJ1Ycvs4JU8QpoS6xdegqoioODRUBV4tO5YpAwm4CuxKKeZiaQsKhAkMSfs4oQ1YIS
	J2c+YQGxRQTcJSbMaGQDsZkFCiU697WC7RUWsJbY2fwCalUjs8SJb5vBVnEK6Evs3HoQbKaE
	gLhET2MQRK+OxLu+B8wQtrzE9rdzmCcwCs5Csm4WkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3W
	LU5OzMtLLdI11svNLNFLTSndxAgJe74djO3rZQ4xCnAwKvHwJjKnBwuxJpYVV+YeYpTkYFIS
	5d0SDRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwpudCJTjTUmsrEotyodJSXOwKInzqi1R9xMS
	SE8sSc1OTS1ILYLJynBwKEnwnsgGahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	RW98MTB+QVI8QHvbQdp5iwsSc4GiEK2nGHU5LjSsaGESYsnLz0uVEuftBykSACnKKM2DWwFL
	cq8YxYE+Fua9ClLFA0yQcJNeAS1hAlrCZQy2pCQRISXVwGhdkaxuFSBwyNyNuYaT/0r9y/a6
	/80V7BI+neFpeos04viX9cdzC6bV5r6fZLHM+Vr1KY2uJfs3ZUt4Xj3Jx3HEK/W9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248132>

On 05/05/2014 11:50 AM, David Kastrup wrote:
> The case we are talking about is basically passing a pointer to some
> actual bonafide toplevel unsigned char [20] object to a routine that
> expects a pointer to a struct _only_ containing one such
> unsigned char [20] element.
> 
> This is the situation we have to deal with if a caller has not been
> converted to using such a struct, but the called function does.

If the rewrite is done by first changing data structures and then
changing functions in caller -> callee order then (1) the deltas can be
pretty small, and (2) such illegal casting should be unnecessary.

> More seriously, this is the situation we have to deal with when our SHA1
> is actually embedded in some header or whatever else that is actually
> available only inside of a larger byte buffer.
> 
> In that case, the standard does not permit us converting the address
> where that SHA1 is into a pointer to struct.  It may well be that this
> will fall under the "let's ignore the standard and write for "sensible"
> compilers/architectures" dictum, but if it doesn't, it might be
> necessary to first copy the data to a struct before passing it to
> routines expecting a pointer to struct.

This sounds dangerous even for a "sensible" compiler.  For example, I
can imagine that a sensible compiler might make the assumption that a
sha1 field that it knows was obtained from oid->sha1 is word-aligned,
and generate optimized code based on that assumption, even though it
otherwise wouldn't have had trouble working with unaligned (unsigned
char *) pointers.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
