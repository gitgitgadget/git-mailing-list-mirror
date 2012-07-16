From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] refs: disallow ref components starting with hyphen
Date: Mon, 16 Jul 2012 15:18:24 +0200
Message-ID: <500414A0.9080802@alum.mit.edu>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com> <1342440781-18816-2-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 15:25:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqlIt-0004qc-Ul
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 15:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2GPNZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 09:25:31 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:52626 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab2GPNZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 09:25:29 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 09:25:29 EDT
X-AuditID: 12074412-b7f216d0000008e3-5c-500414a3a74b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.E5.02275.3A414005; Mon, 16 Jul 2012 09:18:27 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6GDIPlS022376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jul 2012 09:18:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <1342440781-18816-2-git-send-email-mschub@elegosoft.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1F0swhJg0HVAw6LrSjeTxdPOSgcm
	j0N/prB7fN4kF8AUxW2TlFhSFpyZnqdvl8CdcW75fOaC4ywV19tvMTYw3mPuYuTkkBAwkZjZ
	t4AFwhaTuHBvPVsXIxeHkMBlRonTv16yQDjHmSQO7bzKDlLFK6At8f/2PDCbRUBVYln7dzCb
	TUBXYlFPM1MXIweHqECYxPSdUOWCEidnPgFbIALUOnE1yAIODmYBcYn+f2BhYQFviZt7JoDZ
	QgK1Ejdu72AFsTkFXCVuf1rBAlFuLfFtdxFImFlAXmL72znMExgFZiFZMAuhahaSqgWMzKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQgJUaAfj+pNyhxgFOBiVeHhP+TIH
	CLEmlhVX5h5ilORgUhLlzeNlCRDiS8pPqcxILM6ILyrNSS0+xCjBwawkwtvZCVTOm5JYWZVa
	lA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTBe18YaKhgUWp6akVaZk4JQpqJgxNk
	OJeUSHFqXkpqUWJpSUY8KEbji4FRCpLiAdr7C6Sdt7ggMRcoCtF6ilGX48mXW7cYhVjy8vNS
	pcR5r4EUCYAUZZTmwa2ApaNXjOJAHwvzrgWp4gGmMrhJr4CWMAEtsSxhAllSkoiQkmpg1E/t
	Xukpvr92bl4CQ4nct1mLU9cey0x2jWSJ+/yH5fWy1SFbfA97xeyRmOwkIfrLe0aUjV79pUu/
	RO6tWvtXYLHAko+fGidXuHl+3/mZTz1vW6/afu6vwlm37j2xk3K+uFsiJvMtBzeD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201517>

On 07/16/2012 02:13 PM, Michael Schubert wrote:
> Currently, we allow refname components to start with a hyphen. There's
> no good reason to do so and it troubles the parseopt infrastructure.
> Explicitly refuse refname components starting with a hyphen inside
> check_refname_component().

Your change to refs.c looks correct.  However, you should also update 
the documentation of the refname rules at the top of refs.c and also in

     Documentation/git-check-ref-format.txt

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
