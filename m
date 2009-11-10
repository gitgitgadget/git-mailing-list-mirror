From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git replace woes: dirty stat with clean workdir
Date: Wed, 11 Nov 2009 00:33:46 +0100
Message-ID: <200911110033.46546.chriscool@tuxfamily.org>
References: <4AF992F8.8010309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 00:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N80Bd-0003Hn-D0
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 00:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758697AbZKJXbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 18:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758689AbZKJXbe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 18:31:34 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:46043 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758686AbZKJXbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 18:31:33 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 51486818098;
	Wed, 11 Nov 2009 00:31:32 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 69B14818075;
	Wed, 11 Nov 2009 00:31:30 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4AF992F8.8010309@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132603>

Hi,

On mardi 10 novembre 2009, Michael J Gruber wrote:
> Hi there,
>
> when cooking up a "warning example" for git replace (don't draw
> premature conclusions when there are replaced objects) I came across the
> following problem: git status seems to compare the work dir with the
> tree of HEAD, not the replacing tree. Even deleting the index does not
> help.

Yeah, you are right. I must say that I never tested replacing trees before.

> [ The example also shows that we need a way to specify
> --no-replace-objects for gitk. Would easier if gitk really where git
> something. ]

Yeah, I think --no-replace-objects might not work well for shell scripts or 
even commands that call other commands using run_command(). Perhaps we need 
an environment variable GIT_NO_REPLACE_OBJECTS to be set by commands that 
are passed --no-replace-objects and checked by all the commands. I will 
have a look at that.

Thanks,
Christian.
