From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Strange permission problem - advice needed
Date: Wed, 28 Apr 2010 14:30:34 +0200
Message-ID: <4BD82A6A.7080502@viscovery.net>
References: <4BD8185B.5060706@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Hobson <ian@ianhobson.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 28 14:30:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O76Pd-0004tc-1d
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 14:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab0D1Maj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 08:30:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26114 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840Ab0D1Mai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 08:30:38 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O76PT-0004pz-1o; Wed, 28 Apr 2010 14:30:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A7A4C1660F;
	Wed, 28 Apr 2010 14:30:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BD8185B.5060706@ianhobson.co.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145991>

Am 4/28/2010 13:13, schrieb Ian Hobson:
> I'm using git on windows (XP) ...

> $ git gc
> Counting objects: 398, done.
> Compressing objects: 100% (205/205), done.
> Writing objects: 100% (398/398), done.
> Total 398 (delta 191), reused 398 (delta 191)
> rm: cannot unlink `pack-6f07bacdef764f32f12af14877b307d2cb36a1e4.pack':
> Permission denied
> rm: cannot unlink `pack-6f07bacdef764f32f12af14877b307d2cb36a1e4.idx':
> Permission denied
> rm: cannot unlink `pack-cba55771937a4549af73c09c17b10cfceb1320df.pack':
> Permission denied
> rm: cannot unlink `pack-cba55771937a4549af73c09c17b10cfceb1320df.idx':
> Permission denied
> Removing duplicate objects: 100% (256/256), done.

Chances are that you have a hung git process that has the files open. Kill
it and retry.

-- Hannes
