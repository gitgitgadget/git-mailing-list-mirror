From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Signed git-tag doesn't find default key
Date: Fri, 20 Oct 2006 21:52:08 -0300
Message-ID: <200610210052.k9L0q88T005342@laptop13.inf.utfsm.cl>
References: <andyparkins@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:52:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb56C-0002MW-0s
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992762AbWJUAwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992763AbWJUAwZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:52:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12433 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S2992762AbWJUAwY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:52:24 -0400
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net [200.83.245.232])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9L0qARS016090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Oct 2006 21:52:10 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9L0q88T005342;
	Fri, 20 Oct 2006 21:52:08 -0300
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: Message from Andy Parkins <andyparkins@gmail.com> 
   of "Fri, 20 Oct 2006 20:21:58 BST." <200610202021.58157.andyparkins@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 20 Oct 2006 21:52:10 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29568>

Andy Parkins <andyparkins@gmail.com> wrote:

[...]

> I'm going to advocate my change of only searching on the email address
> for finding the key - there shouldn't be two keys with the same email
> address anyway, so there shouldn't be a danger of ambiguity of key.

There very well might be... say you have a key for signing git stuff,
another one for emailing, another one for signing RPMs you create, ... I
believe that is the idea of the GPG comment field, precisely.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
