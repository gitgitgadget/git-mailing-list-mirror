From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: How to (re-)create .git/logs/refs
Date: Thu, 8 May 2008 14:28:35 +0200
Message-ID: <200805081428.35732.hs4233@mail.mn-solutions.de>
References: <200805081256.11465.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 14:32:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju5IV-0002X5-5z
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 14:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbYEHMbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 08:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYEHMbl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 08:31:41 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:4952 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYEHMbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 08:31:40 -0400
Received: from lin01.mn-solutions.de (pD95F84B8.dip0.t-ipconnect.de [217.95.132.184])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 4EB3D5E4016
	for <git@vger.kernel.org>; Thu,  8 May 2008 14:31:38 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id C79F91E004D; Thu,  8 May 2008 14:28:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 4FBDA1E0004
	for <git@vger.kernel.org>; Thu,  8 May 2008 14:28:44 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <200805081256.11465.hs4233@mail.mn-solutions.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81525>

>   warning: Log for '' only goes back to Thu, 8 May 2008
> 09:35:38 +0000. fatal: bad object @{2007-04-01}

Oops, this was from another test that I made today. My original
git repository shows of course a different date:

  warning: Log for '' only goes back to Wed, 23 Apr 2008 08:36:26 +0200.
  fatal: bad object @{2007-05-01}

Also, "git log @{2007-05-01}" | cat  gives me this error
message, "git checkout @{2007-05-01}" gives

  error: pathspec '@{2007-05-01}' did not match any file(s) known to git.
  Did you forget to 'git add'?

which is completely misleading.



Sorry for being unclear in my first mail.
