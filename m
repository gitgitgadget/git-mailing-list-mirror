From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Tue, 23 Jul 2013 01:13:01 +0200
Message-ID: <51EDBC7D.7060200@web.de>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 01:13:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1PHy-0006To-6w
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 01:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab3GVXNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 19:13:05 -0400
Received: from mout.web.de ([212.227.17.11]:57434 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649Ab3GVXNE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 19:13:04 -0400
Received: from [10.0.0.73] ([107.0.115.51]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LsyOA-1U03Fc2IB8-012YoL for <git@vger.kernel.org>; Tue,
 23 Jul 2013 01:13:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:kEsfo/s75IczYfeudkgaIq/dz3jNfUuOv5v+5wG7ufgodd48mKD
 k9GSiW3EfSKLIV/xqdRv31PBAKc/p0pWvbFj2mrzdRmPGaO26f+3QQjVrErJwFEfOvNR6qV
 6R6RtGFI5Bj71p6+JZHHvLsJmRZWW+VYcTbNotw0ZM2RLPNqUA5ib7FYGZPL5ZEekCEkUnQ
 iA9oIMRUmFa4u2E1k1a9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231010>

 
> ml/cygwin-updates:
>      cygwin: stop forcing core.filemode=false

I like that: cygwin behaves more like Unix/Linux.

Just a side-comment: When working on NTFS, cygwin
will set core.filemode=true, and as a result of that,
the "cheating lstat" code is not used any more.

So it is not run under the test suite (typically NTFS),
and therefore "untested by default".

> * rj/cygwin-clarify-use-of-cheating-lstat (2013-07-18) 1 commit
>  - cygwin: Remove the Win32 l/stat() implementation
 
>  I am personally in favor of this simpler solution.  Comments?
Me too, thanks to all contributors
