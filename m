From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Tue, 18 May 2010 14:33:31 +0100
Message-ID: <1274189611.1294.10.camel@wpalmer.simply-domain>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <201005171632.48253.trast@student.ethz.ch>
	 <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
	 <201005171712.22763.trast@student.ethz.ch>
	 <20100517175939.GA3575@efreet.light.src>
	 <1274122619.4780.36.camel@dreddbeard>
	 <4BF246ED.3040706@drmicha.warpmail.net>  <4BF25F7C.10303@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue May 18 15:33:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEMvZ-0001oB-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 15:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab0ERNdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 09:33:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64144 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab0ERNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 09:33:39 -0400
Received: by fxm10 with SMTP id 10so1100411fxm.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=a3I+aj2SHmmWzi1su735lb3Gv7sW4MjrbcO2nlyhIJg=;
        b=R3WpBd7sxiDpFlTP6jWE77TDduXME45qEEY43Z+Dc8V7y7fWibRKP0knU/73VK6A+8
         rkGjtW2R/Bxuj1nG/uycILKVRZknntt3FGBx+PbB2GAfKhAS4qPgfl2pLvhl+N9u269/
         +ytqDEP9rXNyXgiLmdBvUrLv+QB3dLn2IMrAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=pb/sg38NHSf58j/OG16MyGF3iKQ0JTEmMaf6qljmd26nLj41gp6VWSOyJ0xfr+Fqmp
         zetk0AYqeQYaj4YUUzacTV6uW7TSABcazlQ7bwjXvL87u5ta9dvoVbvOG+qedGPwvQjT
         nTGQxu4Jw/cXD4vJXuFlv/F5cCAIuFfznf+eI=
Received: by 10.223.45.22 with SMTP id c22mr8115555faf.107.1274189618047;
        Tue, 18 May 2010 06:33:38 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id 15sm30963201fad.22.2010.05.18.06.33.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 06:33:37 -0700 (PDT)
In-Reply-To: <4BF25F7C.10303@syntevo.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147282>

On Tue, 2010-05-18 at 11:35 +0200, Thomas Singer wrote:
> ... and even worse, (s)he will most likely
> not be able to find a solution by searching google for this error message.
> 

Other software projects make this a non-issue by reporting an "error
code" or something along those lines, along with the message. The code
is easily indexed, so that the message can be located by support staff
and, nowadays, google. I assume any internationalization effort would
require a message code of some sort be generated internally (if only to
look up which internationalized message to display), so doing something
as simple as outputting the internally-used code (even if that is just a
hash of the English version of the message) could solve this problem.

Having error messages pasted into #git in 14 different languages could
be annoying, but if those are 14 people who otherwise would not be using
git at all, then I expect we're looking at the wrong problem, and
internationalisation /should/ be a priority.

But what do I know? I speak English :)
