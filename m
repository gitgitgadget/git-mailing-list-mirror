From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Jan 2013, #07; Thu, 17)
Date: Fri, 18 Jan 2013 16:08:57 +0100
Message-ID: <50F96589.4010408@alum.mit.edu>
References: <7vsj5zs5y2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwDZM-0005U1-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 16:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052Ab3ARPJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 10:09:03 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:54727 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab3ARPJC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 10:09:02 -0500
X-AuditID: 12074413-b7f786d0000008bb-29-50f9658d95b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.21.02235.D8569F05; Fri, 18 Jan 2013 10:09:01 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0IF8xDO004912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Jan 2013 10:09:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vsj5zs5y2.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqNub+jPA4MgrXouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7Y1FrB0vBAp6K003dbA2Mk7m6GDk5JARMJI4t
	WcAEYYtJXLi3nq2LkYtDSOAyo8TjFY2sEM5xJolTM9uAqjg4eAW0Jba/lQFpYBFQlZjacB2s
	mU1AV2JRTzOYLSoQJtH7+hwjiM0rIChxcuYTFhBbREBNYmLbIRaQMcwC4hL9/8DCwgL2EtuP
	djKD2EICphKPmz+zgticAmYSq6bsZwOxmQV0JN71PWCGsOWBLpjDPIFRYBaSDbOQlM1CUraA
	kXkVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkiQCu9g3HVS7hCjAAejEg8v
	t/qPACHWxLLiytxDjJIcTEqivEVJPwOE+JLyUyozEosz4otKc1KLDzFKcDArifA+kQLK8aYk
	VlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeINSgBoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQXEaXwyMVJAUD9BeFZB23uKCxFygKETrKUZjjhk/2p8zcmz/
	DSSFWPLy81KlxHk5QEoFQEozSvPgFsHS0ytGcaC/hXlvJANV8QBTG9y8V0CrmIBWiVz8DrKq
	JBEhJdXAODN/QtvKK7cWXfjtZnSsT/176eQy63Y12dJ69d6T/5e+ij1vuGGD1J69gg9yD2Uv
	SD7LIcj1NOctk6njx4e5EyQZH3zdsDxKekGB9oaczJWnU2QEPRwfzZz1fCXXy2+e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213914>

On 01/18/2013 01:14 AM, Junio C Hamano wrote:
> [...]
> * mh/imap-send-shrinkage (2013-01-15) 14 commits
>  - imap-send.c: simplify logic in lf_to_crlf()
>  - imap-send.c: fold struct store into struct imap_store
>  - imap-send.c: remove unused field imap_store::uidvalidity
>  - imap-send.c: use struct imap_store instead of struct store
>  - imap-send.c: remove unused field imap_store::trashnc
>  - imap-send.c: remove namespace fields from struct imap
>  - imap-send.c: remove struct imap argument to parse_imap_list_l()
>  - imap-send.c: inline parse_imap_list() in parse_list()
>  - imap-send.c: remove some unused fields from struct store
>  - imap-send.c: remove struct message
>  - imap-send.c: remove struct store_conf
>  - iamp-send.c: remove unused struct imap_store_conf
>  - imap-send.c: remove struct msg_data
>  - imap-send.c: remove msg_data::flags, which was always zero
> 
>  Remove a lot of unused code from "git imap-send".
> 
>  With a further comment fixup in patch #6, this seems ready for
>  'next'.
>  Expecting a reroll.

I'm confused.  It seems like you are referring to the comment
improvement suggested by Jonathan Nieder [1] that you have already
incorporated [2] into mh/imap-send-shrinkage.  If you think there is
something that needs rerolling, please explain.

Thanks,
Michael

[1] http://permalink.gmane.org/gmane.comp.version-control.git/213672
[2] http://permalink.gmane.org/gmane.comp.version-control.git/213681

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
