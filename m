From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: squelch error output from cat
Date: Thu, 13 Jun 2013 16:39:42 +0200
Message-ID: <20130613143942.GK2091@goldbirke>
References: <1371131209-32479-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 16:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un8gn-0001F3-BT
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 16:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab3FMOjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 10:39:45 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:59530 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab3FMOjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 10:39:44 -0400
Received: from localhost6.localdomain6 (f051175000.adsl.alicedsl.de [78.51.175.0])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LlpHE-1UDnrz1cau-00ZMKF; Thu, 13 Jun 2013 16:39:43 +0200
Content-Disposition: inline
In-Reply-To: <1371131209-32479-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:o5kCNnIIKFMqMF68e/1f7H3pHQok+d4tSevTESTrQ2N
 URfJhYzRU5wGbIrJqIWD1SAES/gDD8KhcbmeqJQCNiHIUouoQd
 TTBBHOsWzK6W8BRlBmR0LxKDdxXoEo/7iPOsARDtXMRkkePRDH
 /V11kCHDs+ProizWbrruBzz9lIqcrOiibFdOJ/oRnBXnvi+0Bc
 cm+kKECF56g+5oJJF4f11/Lo3xMUCAM/+dSfuLkx+tvKdot5gc
 iPZewDcdKHahQKv0MfP3yCjYYmwJbvll/yCGY3y4LxQD2b6mN6
 BGod7aMVulFd6qb8ZcARNKsN1ZRKMyHgDzpQV0BZu0qxbKR0Fi
 vaDMxAGEy9kfW9WexbFE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227740>

Hi,

On Thu, Jun 13, 2013 at 07:16:49PM +0530, Ramkumar Ramachandra wrote:
> The files $g/rebase-{merge,apply}/{head-name,msgnum,end} are not
> guaranteed to exist.  When attempting to cat them, squelch the error
> output to get rid of messages like these:
>=20
>   cat: .git/rebase-merge/msgnum: No such file or directory
>   cat: .git/rebase-merge/end: No such file or directory
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Makes sense.

Just curious: when do those files don't exist?  When using an older
version of git with a newer prompt, obviously, but are there other
cases?

Thanks,
G=E1bor
