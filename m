From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 0/5] Fix bug in large transactions
Date: Thu, 22 Jan 2015 13:05:01 +0100
Message-ID: <54C0E76D.5070104@alum.mit.edu>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Stefan Beller <sbeller@google.com>, peff@peff.net,
	git@vger.kernel.org, gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 13:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEGcV-0006gy-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbbAVMMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:12:16 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45504 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbAVMMO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 07:12:14 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2015 07:12:14 EST
X-AuditID: 12074414-f797f6d000004084-13-54c0e770e6d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.17.16516.077E0C45; Thu, 22 Jan 2015 07:05:04 -0500 (EST)
Received: from [192.168.69.130] (p5DDB02C5.dip0.t-ipconnect.de [93.219.2.197])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t0MC510I009970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 22 Jan 2015 07:05:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1421893929-7447-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqFvw/ECIwZSp8hZdV7qZLBp6rzBb
	vNruY/GjpYfZYvPmdhYHVo9n21g9Fmwq9XjWu4fR4+IlZY/Pm+QCWKO4bZISS8qCM9Pz9O0S
	uDP6P/xjKfjHWNG7WLGB8ThjFyMnh4SAicSV5vtsELaYxIV764FsLg4hgcuMEis726Gcc0wS
	O799YQap4hXQllh57C87iM0ioCrRv+MSE4jNJqArsainGcwWFQiSuNKyGapeUOLkzCcsILaI
	QIXExc13wLYJC1hIfFrzhhXEFhJwlLg7/QvYTE4BJ4ndh/6A2cwCehI7rv9ihbDlJba/ncM8
	gZF/FpKxs5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSBCL
	7GA8clLuEKMAB6MSD29G8YEQIdbEsuLK3EOMkhxMSqK8e+8BhfiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nwbrsPlONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuAVfAbU
	KFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KyPhiYEyCpHiA9paAtPMWFyTmAkUh
	Wk8x6nIsaN8/k0mIJS8/L1VKnNcDpEgApCijNA9uBSxlvWIUB/pYmLcFpIoHmO7gJr0CWsIE
	tKRgO9iSkkSElFQDYyZj5cO2poy/b3nOPTyy4+V3nhurUpKstwVye6+NdjE78k0+eVn57u0T
	NC/O7z45T0ZsBes0v20lMxZmndxRljehuuz9b9mE6/9MvaS6u8rCJuneT/98rf7W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262821>

On 01/22/2015 03:32 AM, Stefan Beller wrote:
> version2:

Summary: patches 1-4 look good to me. I sent a separate comment about
patch 5, which seems to do more system calls than necessary.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
