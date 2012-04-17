From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 12:51:02 -0500
Message-ID: <nnglilunt6h.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCYc-00068E-FA
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab2DQRvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 13:51:09 -0400
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:33470 "EHLO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2DQRvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 13:51:08 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob112.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT42timsou5W976nDAF+qzErviM5JxSbh@postini.com; Tue, 17 Apr 2012 10:51:08 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 17 Apr
 2012 12:51:05 -0500
In-Reply-To: <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 17 Apr 2012 10:29:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195776>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Another problem is branches. Branches are per submodule but you want
> them for all submodules.

Branches have a similar problem in git-subtree.  It is one of the things
I would like to improve in git-subtree going forward.  I don't see any
fundamental reason that some git-slave-like operations can't be included
in git-subtree, though with a slightly different model.

                                -Dave
