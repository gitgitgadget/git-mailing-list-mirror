From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/4] Add some string_list-related functions
Date: Sun,  9 Sep 2012 07:53:06 +0200
Message-ID: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAaTc-0003iy-NC
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2IIFxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:53:43 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:49230 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521Ab2IIFxn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 01:53:43 -0400
X-AuditID: 1207440d-b7f236d000000943-97-504c2ee640f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AC.D1.02371.6EE2C405; Sun,  9 Sep 2012 01:53:42 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q895raZ9028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 01:53:40 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqPtMzyfA4OR9TouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5YsLmDsWALZ8X/S5fYGxgv
	sXUxcnJICJhIHHg7gxXCFpO4cG89UJyLQ0jgMqPEjteTmCCcM0wSuyauYgSpYhPQlVjU08wE
	YosIqElMbDvEAmIzCzhIbP7cCFYjLGAt8WHRPaCpHBwsAqoSV+9WgYR5BZwldm1cB7VYUeLH
	9zXMExi5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQI8T3vDsb/62QO
	MQpwMCrx8DLf8Q4QYk0sK67MPcQoycGkJMprru0TIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	9yo7UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMErCAxxIcGi1PTU
	irTMnBKENBMHJ4jgAtnAA7TBGKSQt7ggMbc4Mx2i6BSjopQ4Ly9IQgAkkVGaBzcAFqWvGMWB
	/hHmVQOp4gFGOFz3K6DBTECDRZ55gAwuSURISTUwVjCcsvZo5svTN2s5vLJZb+XjlusHzwn5
	GMv0/l9Z0+oYkTz1V+/Rqnlq0w8aKbxnrvjF5ha4TJSpf9bcsw9UG/y9nzYui++alCX0NGFv
	mPPcdpEbGu19qT2yK9cWbonp2fLhimaOoP200q1V3hL2RxlVD7ww+PnNZJsH56E1Edcs7esY
	9J8osRRnJBpqMRcVJwIAz4KcKq0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205046>

This patch series adds a few functions to the string_list API.  They
will be used in two upcoming patch series.  Unfortunately, both of the
series (which are otherwise logically independent) need the same
function; therefore, I am submitting these string-list enhancements as
a separate series on which the other two can depend.

This patch series applies to current master.

Michael Haggerty (4):
  Add a new function, string_list_split_in_place()
  Add a new function, filter_string_list()
  Add a new function, string_list_remove_duplicates()
  Add a function string_list_longest_prefix()

 .gitignore                                  |  1 +
 Documentation/technical/api-string-list.txt | 32 ++++++++++
 Makefile                                    |  1 +
 string-list.c                               | 77 ++++++++++++++++++++++++
 string-list.h                               | 41 +++++++++++++
 t/t0063-string-list.sh                      | 93 +++++++++++++++++++++++++++++
 test-string-list.c                          | 47 +++++++++++++++
 7 files changed, 292 insertions(+)
 create mode 100755 t/t0063-string-list.sh
 create mode 100644 test-string-list.c

-- 
1.7.11.3
