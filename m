From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Question about submodules and absolute paths
Date: Wed, 23 May 2012 07:36:14 +0200
Message-ID: <4FBC774E.5000500@viscovery.net>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com> <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com> <7vk4043wc5.fsf@alter.siamese.dyndns.org> <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 07:36:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX4FG-00087e-AR
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 07:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab2EWFgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 01:36:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10151 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751559Ab2EWFgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 01:36:20 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SX4F4-0004Ce-Rb; Wed, 23 May 2012 07:36:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 75C4D1660F;
	Wed, 23 May 2012 07:36:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198272>

Am 5/22/2012 21:18, schrieb Alexey Pelykh:
> Not on two machines, on single machine but with two OSes
> Windows + Linux + shared 'work' partition :) So both Windows and Linux
> use same repo clone that is stored on a 'work' partition. But due to
> those absolute paths, it gives '/cygdrive/d/work' on windows and
> '/media/work' on linux. Thus I have to keep 2 copies of each
> repository that uses submodules (and that is very inconvenient :( )

I think you cannot share the index file between OSes. Even though its file
format should be portable, the contents (stat information) is not
portable. After you boot into a different OS, you need at least a 'git
status' call to populate the index with the stat data from the new OS.

-- Hannes
