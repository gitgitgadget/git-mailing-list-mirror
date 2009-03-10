From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Add "compare with Git Index" action.
Date: Wed, 11 Mar 2009 00:22:53 +0100
Message-ID: <200903110022.53854.robin.rosenberg.lists@dewire.com>
References: <49B63ADC.4080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhBJP-0006Bf-9u
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 00:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbZCJXXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 19:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZCJXXG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 19:23:06 -0400
Received: from mail.dewire.com ([83.140.172.130]:20445 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbZCJXXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 19:23:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 06D6C15E0E14;
	Wed, 11 Mar 2009 00:22:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzVYfiKzkmjX; Wed, 11 Mar 2009 00:22:56 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 280AE15E0DF5;
	Wed, 11 Mar 2009 00:22:56 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49B63ADC.4080009@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112857>

tisdag 10 mars 2009 11:03:08 skrev Yann Simon <yann.simon.fr@gmail.com>:
> In the Compare With... menu, the "Git Index" action opens
> a diff editor that compares the workspace version of a file and its
> index version.
> 
> The local file can be modified and saved.
> 
> The staged version can be modified and saved. This updates the index.
> For this, add methods into GitIndex to allow to specify a content
> different from the file.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
> Changed comapred to previous version:
> - fix saving the index version.

Saving works, but the diff regions aren't updated on save. When there is a diff
this would give us the partial staging similar to git gui, if only (not your fault) the
commit dialog would allow us to make a distinction between changes in the
workdir and the index.

-- robin
