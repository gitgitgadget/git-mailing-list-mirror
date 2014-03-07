From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Fri, 07 Mar 2014 08:39:27 +0100
Message-ID: <531977AF.4060907@alum.mit.edu>
References: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 08:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLpNX-0000Gx-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 08:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbaCGHjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 02:39:31 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55156 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbaCGHjb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 02:39:31 -0500
X-AuditID: 12074411-f79ab6d000002f0e-5f-531977b2db7e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 97.B9.12046.2B779135; Fri,  7 Mar 2014 02:39:30 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4FF5.dip0.t-ipconnect.de [79.221.79.245])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s277dSWK028014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 7 Mar 2014 02:39:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqLupXDLY4MMpCYuuK91MFt1T3jI6
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7oxfVzcwFixhq9jf9JqtgbGJtYuRk0NCwERi
	yfO9bBC2mMSFe+uBbC4OIYHLjBKPZ99lgXDOMUkc+7CUqYuRg4NXQFvi5upskAYWAVWJzpOL
	WEBsNgFdiUU9zUwgtqhAsMTqyw/A4rwCghInZz4Bs0UElCTedGxjBrGZBbQk7ly6ywhiCwu4
	SOyf+xHMFhIIkLj8/i9YPadAoMTpc4fZQdZKCIhL9DQGgZjMAuoS6+cJQUyRl9j+dg7zBEbB
	WUiWzUKomoWkagEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2MkNAV3ME4
	46TcIUYBDkYlHt6ORRLBQqyJZcWVuYcYJTmYlER5H+VLBgvxJeWnVGYkFmfEF5XmpBYfYpTg
	YFYS4a1PBsrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4T5QBNQoW
	paanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYje+GBi9ICkeoL13QNp5iwsSc4GiEK2n
	GHU5brf9+sQoxJKXn5cqJc57HKRIAKQoozQPbgUsUb1iFAf6WJh3HUgVDzDJwU16BbSECWiJ
	RSDYkpJEhJRUA6Pebvccv+/Zx5MXad1KFZgle3vVk9abzKq/V8j/vXu3ylKw8+Wpl6m1LuVF
	OlpbT3vOPfKteevG67tOfDm0W3La6l2ntv+oyfozZd3EzJROHpt3s6ZvWal980tk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243604>

On 03/07/2014 02:38 AM, Duy Nguyen wrote:
> Currently in order to avoid --[no]-xxx form we have to resort to
> declare full struct option. It'd be nice to have a set of OPT_* macros
> with PARSE_OPT_NONEG set. Find and update all "struct option []"
> declarations with the new macros (including ones that should never
> accept --no- form, but do anyway).

I added this to the list, with the following warning:

    This is more a milliproject than a microproject

because to me it feels considerably more involved than the other
microprojects.  To  complete it, the student will have to understand at
least part of the parse_options() API, which is more than a 15 minute
job by itself.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
