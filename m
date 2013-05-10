From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 08:07:40 +0200
Message-ID: <518C8EAC.6000106@viscovery.net>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 08:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UagVM-0000mx-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 08:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab3EJGIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 02:08:22 -0400
Received: from so.liwest.at ([212.33.55.13]:51217 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3EJGIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 02:08:21 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UagV2-0005Ry-Oz; Fri, 10 May 2013 08:08:12 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5B4ED1660F;
	Fri, 10 May 2013 08:08:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223816>

Am 5/8/2013 18:16, schrieb Matt McClure:
> That begs a follow-up question. It sounds as though Git will typically 
> delete unreachable objects. My team often shares links like 
> https://git.example.com/foo.git/log/d59051721bb0a3758f7c6ea0452bac122a377645?hp=0055e0959cd13780494fe33832bae9bcf91e4a90
>
> . If I later rebase the branch containing those commits and d590517
> becomes unreachable, do I risk that link breaking when Git deletes 
> d590517?

Yes.

When we explain 'rebase', we usually say "you make the life hard for
people who build on (published) history that you later rebase". But you
inconvenience not only people who build their own history on top of your
outdated history, but also those who operate with (web) links into that
history.

> What's a good strategy for avoiding breaking those links?

Do not rebase published history.

-- Hannes
