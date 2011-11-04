From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Folder level Acces in git
Date: Fri, 04 Nov 2011 09:42:13 +0100
Message-ID: <4EB3A565.2040408@web.de>
References: <1320300655224-6958047.post@n2.nabble.com> <CAPZPVFY15AqCpWcRbv0tjXBz4G2kQTm+nMGpsYzCKe0niHV_dA@mail.gmail.com> <4EB36855.8000802@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>,
	redhat1981 <redhat1981@gmail.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 09:42:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMFM0-0001c5-Fy
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 09:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1KDImU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 04:42:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:58543 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1KDImT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 04:42:19 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id E20F01BA0F84A
	for <git@vger.kernel.org>; Fri,  4 Nov 2011 09:42:17 +0100 (CET)
Received: from [192.168.178.43] ([79.247.240.208]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MNt8d-1RJFTu07nX-007VGd; Fri, 04 Nov 2011 09:42:17
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EB36855.8000802@workspacewhiz.com>
X-Provags-ID: V02:K0:zJVCt0EwxDgF5wCL4QpHIHLgmaPFZjlL8X9J5djVtyd
 5speTYmsFRmbPWmrf7dO+6ANCe/kRPsdY9YGYXOI235Rbdc3dn
 SdMoDCiN7SnPH04rdDP3f2W82bnuifYtqio8JZsszReNid1gOB
 a2gnz/0Lk2VaFPNoWgtDx/i6Xp7ilzWQVW/8r64DznvBaY5y+G
 qMd/Mw7/CnwlzMv5izN7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184762>

Am 04.11.2011 05:21, schrieb Joshua Jensen:
> ----- Original Message -----
> From: Eugene Sajine
> Date: 11/3/2011 1:28 PM
>> Are you sure that the way your have organized the repository is
>> actually correct? If you need to manage the access on folder level why
>> don't you simply split up the project into several
>> repositories/projects which each team is going to work with
>> independently?
>>
>> This seems to me to be much simpler and cleaner solution then any
>> other alternative.
>>
> Submodules are _not_ simple at all.  Our organization of nearly 100 developers using Git pretty much let out a collective cheer when we finally removed the submodules.  Submodules are an absolute pain to develop within; there are a number of Git mailing list exchanges about that, but I'd be happy to go into great detail if anybody cares.

I do care and would appreciate if you could share your problems.

> Even submodules that are read-only are a pain as it takes two steps (git pull + git submodule update) to actually get them up to date.

Full Ack. I'm working on teaching git to update update the whole
work tree - including the submodules - after each checkout, merge,
pull, bisect, etc. (which also includes proper support for deletion
and re-creation of submodules).

What else made using submodules hard for you?
