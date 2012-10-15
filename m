From: Uri Moszkowicz <uri@4refs.com>
Subject: error: git-fast-import died of signal 11
Date: Mon, 15 Oct 2012 10:53:57 -0500
Message-ID: <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 17:54:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNmzt-0001oF-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 17:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab2JOPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 11:54:18 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:43133 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184Ab2JOPyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 11:54:18 -0400
Received: (qmail 14273 invoked by uid 399); 15 Oct 2012 11:54:17 -0400
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 15 Oct 2012 11:54:17 -0400
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so8038545iea.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 08:54:17 -0700 (PDT)
Received: by 10.50.15.132 with SMTP id x4mr8951424igc.58.1350316457171; Mon,
 15 Oct 2012 08:54:17 -0700 (PDT)
Received: by 10.64.15.7 with HTTP; Mon, 15 Oct 2012 08:53:57 -0700 (PDT)
In-Reply-To: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207758>

Hi,
I'm trying to convert a CVS repository to Git using cvs2git. I was able to
generate the dump file without problem but am unable to get Git to
fast-import it. The dump file is 328GB and I ran git fast-import on a
machine with 512GB of RAM.

fatal: Out of memory? mmap failed: Cannot allocate memory
fast-import: dumping crash report to fast_import_crash_18192
error: git-fast-import died of signal 11

How can I import the repository?

Thanks,
Uri
