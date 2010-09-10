From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] read-tree: abort if no trees are given
Date: Fri, 10 Sep 2010 13:29:19 +0200
Message-ID: <4C8A168F.1030502@viscovery.net>
References: <20100910120604.50aa1e94@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Sep 10 13:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou1nN-00045r-Ur
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 13:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab0IJL3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 07:29:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9807 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab0IJL3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 07:29:24 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ou1nE-00075v-Hj; Fri, 10 Sep 2010 13:29:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4802A1660F;
	Fri, 10 Sep 2010 13:29:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
In-Reply-To: <20100910120604.50aa1e94@jk.gs>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155925>

Am 9/10/2010 12:06, schrieb Jan Kr=C3=BCger:
> Currently, read-tree silently accepts an invocation without any
> tree-ishs given and simply clobbers the index in that case. This
> contradicts the usage synopsis and it's also probably not what anyone
> would want to happen. So, instead, abort with a fatal error.

See

http://thread.gmane.org/gmane.comp.version-control.git/135280/focus=3D1=
35407

and the discussion that ensued; perhaps intersting is

http://thread.gmane.org/gmane.comp.version-control.git/135280/focus=3D1=
35462

(where Junio suggest to make this a warning for now).

-- Hannes
