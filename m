From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: git format-patch doesn't exclude merged hunks
Date: Wed, 16 May 2012 16:42:27 +0100
Message-ID: <4FB3CAE3.6040608@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 17:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUgWI-0003fw-IB
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 17:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab2EPPwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 11:52:05 -0400
Received: from mail2.vodafone.ie ([213.233.128.44]:9432 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2EPPwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 11:52:04 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 May 2012 11:52:04 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAE/Js09tTlGZ/2dsb2JhbAANN4V8sVUPAW4NAgUWCwILAwIBAgFYCAEBiBWoMZJ2BIEmjB+CDoEVA5wRjRM
Received: from unknown (HELO [192.168.1.79]) ([109.78.81.153])
  by mail2.vodafone.ie with ESMTP; 16 May 2012 16:42:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197885>

So I was using `git format-patch` to generate patches for
consumption by patch (as part of an RPM build),
and one of the patches was failing as part of it was
already applied.

It seems like format-patch should exclude bits it's
merge previously, at least as an option.

=46or reference the two commits in question are:
https://github.com/openstack/nova/commit/7028d66
https://github.com/openstack/nova/commit/26dc6b7
Notice how both make the same change to Authors.

cheers,
P=C3=A1draig.
