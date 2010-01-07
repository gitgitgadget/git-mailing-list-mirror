From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: origin/branchname and tracking branch pointing to different commits?
Date: Thu, 7 Jan 2010 18:12:59 +0100
Message-ID: <201001071813.01187.trast@student.ethz.ch>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:13:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvvO-0005TD-9g
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904Ab0AGRNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750Ab0AGRNY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:13:24 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:52726 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab0AGRNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:13:24 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 18:13:22 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 18:13:01 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.86; x86_64; ; )
In-Reply-To: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136364>

Eugene Sajine wrote:
> $git pull origin qa
[...]
> So, generally, speaking qa branch is fine and is in synch with the
> remote mainline, but the state of local origin/qa is not clear.

'git pull $remote $branch' does not update the $remote/$branch
remote-tracking branch; it stores in FETCH_HEAD and merges straight
from there.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
