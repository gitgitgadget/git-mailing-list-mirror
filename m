From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 17:02:56 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
 <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696243703-1201552854-1179496976=:14736"
Cc: Paolo Teti <paolo.teti@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 18 16:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp32w-0004sb-5C
	for gcvg-git@gmane.org; Fri, 18 May 2007 16:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbXERODA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 10:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbXERODA
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 10:03:00 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59552 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbXEROC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 10:02:59 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Fri, 18 May 2007 17:02:57 +0300
  id 0007BD2D.464DB211.00001B7A
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id 72B2DEBAE4; Fri, 18 May 2007 17:02:57 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id 66A99EAE3F;
	Fri, 18 May 2007 17:02:57 +0300 (EEST)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
In-Reply-To: <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47610>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1201552854-1179496976=:14736
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

David Kastrup <dak@gnu.org> wrote:

> Only if size_t is a larger type than int (could be on x86-64 and alpha
> architectures).  Other than that, this comparison would work.  Which
> does not mean that this does not warrant fixing, but it is not
> necessarily the cause of this problem.

...sizeof(size_t) == sizeof(int) should hold...

Anyway, if this has any relevance: I'm using non-utf system, and (as you 
see) my surname has ä... The system was recently upgraded to git 1.5+ 
which started to complain also about a missing i18n.commitencoding, 
figured out that when I set it to utf8 (empty => defaults to it) and have 
signed-off line (with native non-utf ä), I get that error...

...and please, do not drop me from cc since I'm not subscribed...

-- 
 i.
---696243703-1201552854-1179496976=:14736--
