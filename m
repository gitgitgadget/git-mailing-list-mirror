From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sun, 11 Aug 2013 07:16:30 +0200
Message-ID: <52071E2E.2020001@alum.mit.edu>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com> <20130810232026.GF25779@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kristian Freed <kristian.freed@gmail.com>,
	git <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 07:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8O19-0008BR-9K
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 07:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115Ab3HKFQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 01:16:35 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58521 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048Ab3HKFQf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Aug 2013 01:16:35 -0400
X-AuditID: 12074414-b7f626d0000001f1-a4-52071e3269b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C4.99.00497.23E17025; Sun, 11 Aug 2013 01:16:34 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD456A.dip0.t-ipconnect.de [79.221.69.106])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7B5GV35023974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 11 Aug 2013 01:16:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130810232026.GF25779@paksenarrion.iveqy.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqGskxx5kcHI6r0XXlW4mi3+tB9gs
	Jj+6z+bA7LFz1l12jwXzzzF6fN4kF8AcxW2TlFhSFpyZnqdvl8Cdsf3KdLaC56wVr3qOMTUw
	HmLpYuTkkBAwkWj89IwVwhaTuHBvPVsXIxeHkMBlRok3r/czgySEBM4zSdzoCwaxeQW0JeYv
	uwjWzCKgKtFwfz1YDZuArsSinmamLkYODlGBMIkrv1UhygUlTs58AlYuIqAhsfzWZzCbWcBD
	YtKMdnYQW1ggTqLt5VcWiL0NjBLTLy8EO4hTwEZiddcTZogGHYl3fQ+gbHmJ7W/nME9gFJiF
	ZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESvCI7GI+c
	lDvEKMDBqMTD27COLUiINbGsuDL3EKMkB5OSKG+uFHuQEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRHe9kqgct6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd44GaChgkWp
	6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBIjS8GxipIigdobzpIO29xQWIuUBSi9RSj
	Lse7pnmfGIVY8vLzUqXEeXeAFAmAFGWU5sGtgKWqV4ziQB8L8y4FqeIBpjm4Sa+AljABLZl+
	mAVkSUkiQkqqgdFE4tZ23flPL1zRFZp4Vzu5ZbnIl5du4haJ19N6uZ/MDGxtzp16YSrD4//7
	xdbLCpmtv8qpwDPP+96/e2nm6/f0FErWJRuYun2/vX0vmxbXw+y3V+48jgxo7LWY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232121>

On 08/11/2013 01:20 AM, Fredrik Gustafsson wrote:
> [...]
> It would be very hard to do a tool such as you describe, the reason is
> that there's no sane way to order your tags. Git today show tags
> alphabetically, all versions does not have a alphabtic order. [...]
> It would be quite easy to make a script that create such branch for you,
> if you only can sort the tags somehow.

GNU sort has a nice option that can sort this way:

  -V, --version-sort
     Sort by version name and number.  It behaves like a standard sort,
     except that each sequence of decimal digits is treated numerically
     as an index/version number.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
