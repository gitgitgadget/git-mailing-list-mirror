From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Memory of past repositories in git remote?
Date: Wed, 25 Mar 2009 13:05:21 +0100
Message-ID: <adf1fd3d0903250505o38e0ac54jcf07f4425eee0a6@mail.gmail.com>
References: <784F93DB-2D7C-4F48-88E8-BF56F01CD1E2@dinechin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Christophe de Dinechin <christophe@dinechin.org>
To: Christophe de Dinechin <christophe.de.dinechin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 13:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRsl-0006ZM-JG
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 13:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbZCYMF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 08:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349AbZCYMFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 08:05:25 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35859 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338AbZCYMFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 08:05:25 -0400
Received: by fxm2 with SMTP id 2so2718757fxm.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 05:05:22 -0700 (PDT)
Received: by 10.103.221.5 with SMTP id y5mr4151417muq.66.1237982721877; Wed, 
	25 Mar 2009 05:05:21 -0700 (PDT)
In-Reply-To: <784F93DB-2D7C-4F48-88E8-BF56F01CD1E2@dinechin.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114594>

2009/3/25 Christophe de Dinechin <christophe.de.dinechin@gmail.com>:
> Here are the details. I created a git repository in /home/ddd/vmm, impored
> some Subversion history, and started working with that. I created a few
> branches, e.g. one called "perrier". Then, I realized that there was a
> better way to track Subversion changes, and so I moved the old repository as
> /home/ddd/vmm.git, and created a new one that I populated with "git svn
> clone svn+ssh://path/to/repot -T trunk -b branches -t users". That new
> repository has no branch named "perrier" in it.

Git tries different url: $url/.git, $url.git and $url (I'm not sure
about the order).

So having $url and $url.git is asking for problems. I don't know if it
is documented somewhere.

HTH,
Santi
