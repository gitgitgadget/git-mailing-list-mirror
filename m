From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] git-remote-mediawiki: allow page names with a ':'
Date: Mon, 23 Jul 2012 09:42:59 +0200
Message-ID: <vpqy5mancsc.fsf@bauges.imag.fr>
References: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342533960-22123-3-git-send-email-Matthieu.Moy@imag.fr>
	<CAPBPrnvoqh4-6vnhhd67tdBZRSqY-ixkzPxTfJDcchmQYxZghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:43:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StDIQ-0004cR-PX
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab2GWHnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:43:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55322 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926Ab2GWHnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:43:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6N7enur021856
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 09:40:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1StDIC-0002zf-Ak; Mon, 23 Jul 2012 09:43:00 +0200
In-Reply-To: <CAPBPrnvoqh4-6vnhhd67tdBZRSqY-ixkzPxTfJDcchmQYxZghQ@mail.gmail.com>
	(Dan Johnson's message of "Fri, 20 Jul 2012 17:11:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Jul 2012 09:40:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6N7enur021856
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343634051.95222@BHanMncoEaRWoe/gS2mnpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201923>

Dan Johnson <computerdruid@gmail.com> writes:

> On Tue, Jul 17, 2012 at 10:06 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> Traditionnally, pages named Foo:Bar are page 'Bar' in namespace 'Foo'.
>> However, it is also possible to call a page Foo:Bar if 'Foo' is not a
>> namespace. In this case, the actual name of the page is 'Foo:Bar', in the
>> main namespace. Since we can't tell with only the filename, query the
>> wiki for a namespace 'Foo' in these cases, but deal with the case where
>> no such namespace is found.
>
> Might not be worth fixing, and it's just a typo in the commit message, but:
> s/Traditionnally/Traditionally/
> ?

Thanks, but the topic is in next already, so it's too late to fix the
commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
