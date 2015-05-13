From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: "HEAD -> branch" decoration doesn't work with "--decorate=full"
Date: Wed, 13 May 2015 15:11:49 +0200
Message-ID: <55534D95.60609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 15:12:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsWSK-0002oo-6S
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 15:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934227AbbEMNMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 09:12:08 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63616 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933335AbbEMNMG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2015 09:12:06 -0400
X-AuditID: 12074413-f79f26d0000030e7-cf-55534d9775db
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C2.07.12519.79D43555; Wed, 13 May 2015 09:11:51 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DB8.dip0.t-ipconnect.de [93.219.29.184])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4DDBnnf000716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 13 May 2015 09:11:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqDvdNzjU4Nl2NYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE74+73yWwFa1gqVp2bwtLAeIK5i5GTQ0LAROL+
	v5VQtpjEhXvr2boYuTiEBC4zSqy/1MMKkhASOM8k8eySfRcjBwevgKZEX1soSJhFQFVi4uml
	jCA2m4CuxKKeZiYQW1QgSKL12lSwOK+AoMTJmU9YQGwRATWJiW2HWEDGMAPVP3yTCBIWFvCQ
	mHrhCNgmZgF1iT/zLjFD2PISzVtnM09g5JuFZNIsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRrrpebWaKXmlK6iREScsI7GHedlDvEKMDBqMTDq7AhKFSINbGsuDL3EKMkB5OS
	KK+ZfXCoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHechegHG9KYmVValE+TEqag0VJnFdtibqf
	kEB6YklqdmpqQWoRTFaGg0NJgjfYB6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQj
	HhR18cXAuANJ8QDttQFp5y0uSMwFikK0nmLU5bgz5f8iJiGWvPy8VClx3miQIgGQoozSPLgV
	sATzilEc6GNh3ssgVTzA5AQ36RXQEiagJY5xASBLShIRUlINjNHHnNgel7WtDPprLc/W5cDB
	d/vIbqEC9Y0Lnz7LcH4YxtckXFHC1FSlczLtqdTjnYtuJu7Q+zz5ceCeBo5MT+Urv1IUPuv2
	zdq3v0Ql8NeamxusQ7PmCxc8Zr+dNvnlJa2sALZznOreS1UWrmHo2BW3omfB1R+y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268980>

Hi,

The new-style "HEAD -> branch" style decoration doesn't work when
"--decorate=full" is used:

> $ bin-wrappers/git show --oneline --decorate
> c518059 (HEAD -> master, gitster/master) Merge branch 'maint'
> 
> $ bin-wrappers/git show --oneline --decorate=full
> c518059 (HEAD, refs/remotes/gitster/master, refs/heads/master) Merge branch 'maint'

I would have expected the second invocation to show "HEAD ->
refs/heads/master".

Was that an oversight or a conscious decision?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
