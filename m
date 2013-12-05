From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Thu, 05 Dec 2013 20:54:29 +0100
Message-ID: <52A0D9F5.3030101@web.de>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com> <52A0D199.1010403@web.de> <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:54:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vof0N-0007Wr-JH
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab3LETyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:54:32 -0500
Received: from mout.web.de ([212.227.15.14]:62237 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513Ab3LETyb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:54:31 -0500
Received: from [192.168.178.41] ([84.132.154.249]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M8Qpi-1Vbmyt3eYE-00vukt for <git@vger.kernel.org>;
 Thu, 05 Dec 2013 20:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:yTCaZEdolGr8Ncf2FPGQi0uT4h8vlnOQFGAYzvI0oxNF3sNI0r3
 y1K2MiELdX8yzJsF18maq2EcKBHxrNyT9BRWigthZCPcKn42G7IxwgZ//XG6RvSYI9CZZTC
 wM4lOIZdy0py1+4hmFv1qt+Cjqod/XWGOJGlXjuWCisYvOuCoargFU6ydmvYWRAMm5BnPt7
 5fY0uXvzvuuLa3IbcrLRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238903>

Am 05.12.2013 20:27, schrieb Martin Langhoff:
> On Thu, Dec 5, 2013 at 2:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Without knowing more I can't think of a reason why submodules should
>> not suit your use case (but you'd have to script branching and tagging
>> yourself until these commands learn to recurse into submodules too).
> 
> The submodules feature is way too fiddly and has abundant gotchas.

Care to explain what bothers you the most? Being one of the people
improving submodules I'm really interested in hearing more about that.

> I am diving into subtrees, and finding it a lot more workable.

Yep, for exporting parts of your repo as separate repos one way
subtree might be just what you want.
