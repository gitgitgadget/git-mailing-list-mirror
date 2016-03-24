From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 17/33] refs: make lock generic
Date: Thu, 24 Mar 2016 20:45:01 +0100
Message-ID: <56F443BD.1030100@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-18-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 24 20:45:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBBw-0007eI-GK
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbcCXTpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:45:08 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43748 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870AbcCXTpG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 15:45:06 -0400
X-AuditID: 1207440e-c03ff70000000398-26-56f443c086cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9D.EF.00920.0C344F65; Thu, 24 Mar 2016 15:45:04 -0400 (EDT)
Received: from [192.168.69.130] (p548D66F7.dip0.t-ipconnect.de [84.141.102.247])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2OJj1rp012917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 24 Mar 2016 15:45:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1456793586-22082-18-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqHvA+UuYweuPchbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MDqweO2fdZfd41ruH0ePiJWWPBc/vs3t83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xdv5KpoJPTBUdu/8zNjCuYupi5OSQEDCRWHJ6OVsXIxeHkMBWRonlj9sYQRJCAheY
	JC6tSASxhQVMJa79+cwCYosIZEvM+XSOFaKhg1Fiwp9LrCAJZgE1ifZNU8BsNgFdiUU9zWAb
	eAW0JU6+nwUWZxFQlfh2aSXYIFGBEIlt676xQtQISpyc+QQszingJdH4ooUZYqaexI7rv6Dm
	y0tsfzuHeQIj/ywkLbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5q
	SukmRkgw8+1gbF8vc4hRgINRiYe3keNzmBBrYllxZe4hRkkOJiVR3iNWX8KE+JLyUyozEosz
	4otKc1KLDzFKcDArifBuUwfK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4
	OJQkeJdbAjUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IyvhgYlSApHqC9s+1A
	9hYXJOYCRSFaTzHqciz4cXstkxBLXn5eqpQ473wLoCIBkKKM0jy4FbDU9YpRHOhjYV5ea6Aq
	HmDag5v0CmgJE9CShT6fQJaUJCKkpBoY19zKvBA9n7VfRzL534VVoV/+8Wfftl/6O5x51apl
	AZfefeQ57SsYtEn399prP7nvFnEviFv+/XNF2uSSp269Oxbd+WY1IXCmlOW+MIXb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289788>

On 03/01/2016 01:52 AM, David Turner wrote:
> Instead of using a files-backend-specific struct ref_lock, the generic
> ref_transaction struct should provide a void pointer that backends can use
> for their own lock data.

Aside from the comments I've already mentioned, I've checked the patches
up to and including this one and they look fine to me.

Michael
