From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/24] Yet another pre-refs-backend series
Date: Sat, 9 Apr 2016 12:19:50 -0400
Message-ID: <57092BA6.1060808@alum.mit.edu>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 18:30:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aovlq-0008NG-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 18:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbcDIQ06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 12:26:58 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50742 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753908AbcDIQ05 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 12:26:57 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Apr 2016 12:26:57 EDT
X-AuditID: 1207440e-f07ff700000008c5-0c-57092ba707ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C3.70.02245.7AB29075; Sat,  9 Apr 2016 12:19:51 -0400 (EDT)
Received: from [192.168.0.107] (ool-4352a4a3.dyn.optonline.net [67.82.164.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u39GJokD012234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 9 Apr 2016 12:19:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLtcmzPcYNopNYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BlHH11lL/gvWDFt60v2BsYtfF2MnBwSAiYS
	O65eZOxi5OIQEtjKKHH60lc2COcck8S2h0uZQKqEBewkzq/4zgZiiwg4SFzedZQZxBYS8JA4
	vmoDK4jNJqArsainGayeV0BbYsq9hWBxFgEViRenL7CD2KICIRLb1n1jhagRlDg58wkLiM0p
	4Cnxuq0HbCazgJ7Ejuu/WCFseYntb+cwT2Dkm4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClO
	TdYtTk7My0st0jXWy80s0UtNKd3ECAk9vh2M7etlDjEKcDAq8fBmhHGEC7EmlhVX5h5ilORg
	UhLltXoJFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCe1iNM1yINyWxsiq1KB8mJc3BoiTOq7ZE
	3U9IID2xJDU7NbUgtQgmK8PBoSTB26oF1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFha
	khEPir34YmD0gaR4gPbyaIPsLS5IzAWKQrSeYlSUEueNBJkrAJLIKM2DGwtLKK8YxYG+FOa1
	AaniASYjuO5XQIOZgAZf4GcDGVySiJCSamCUEpswp4LV6rPML6brRudW8rTySChKtbj2Hp8q
	sorj7oWWm07pqVO1YoJz5HZ0TWmVPnaL/62zhcDl3xvO39W/XW3hxrLVeevxl4sj3r3gWMR0
	pye6acZ8yUDlTzf11P9ysO5v/ZPp+tHU+ai9sIr1zJVmdnzz1sdP+bbzseGpnYef 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291100>

On 04/07/2016 03:02 PM, David Turner wrote:
> We now have quite a large number of patches before we even get into
> the meat of the pluggable refs backend series.  So it's worth breaking
> those out and getting them in before we get into the main series
> (which Michael Haggerty swants to redesign a bit anyway).
> 
> This set of patches should be applied on top of
> jk/check-repository-format.
> 
> Michael Haggerty has reviewed those of my patches which are in here
> except maybe:
>   refs: on symref reflog expire, lock symref not referrent
> This was the one from later in the series that was straightforward to
> move to before the vtable; the other two were going to be harder to
> move and can wait until after the vtable.

This last patch deserves a little bit of discussion. Currently, when the
reflog of a symref is expired, the pointed-to ref is locked rather than
the symref. This patch changes the code to lock the symref instead.

This is clearly the right thing to do, and I consider this change a bug
fix. However, it introduces an incompatibility. An old version of `git
reflog expire` and a new version wouldn't agree on the locking protocol,
and could potentially try to overwrite the same reflog at the same time.

I think this risk is acceptable nevertheless, because expiring reflogs
is an uncommon operation and unlikely to be done from two processes at
the same time; moreover, the integrity of reflogs is not a matter of
life or death.

A far more likely conflict would be between a reflog expiration and a
symref update (e.g., `git checkout otherbranch`). This use case is
currently *broken* because `git checkout` locks HEAD. It would be fixed
by this patch.

If somebody is really upset about the risk of a race between an old and
new version of `git reflog expire`, the way to increase the safety would
be to lock *both* the symref and the referent while changing the
symref's reflog. I think that would be overkill.

This whole series is

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

David mentioned that I want to redesign the vtable patches somewhat.
Anybody who is curious can look at the work in progress branch on my
GitHub fork [1], branch wip/ref-storage.

Michael

[1] https://github.com/mhagger/git
