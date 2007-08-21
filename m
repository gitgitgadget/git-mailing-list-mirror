From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 19:01:55 +0200
Message-ID: <200708211901.55687.robin.rosenberg.lists@dewire.com>
References: <20070821124949.GH768@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:27:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXW7-0001HJ-Ii
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbXHUR1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbXHUR1Y
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:27:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4665 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbXHUR1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:27:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 459AA80267F;
	Tue, 21 Aug 2007 19:19:41 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07693-02; Tue, 21 Aug 2007 19:19:41 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 149A5800199;
	Tue, 21 Aug 2007 19:19:41 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070821124949.GH768@genesis.frugalware.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56309>

tisdag 21 augusti 2007 skrev Miklos Vajna:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  Documentation/git-show.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index a42e121..2409389 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -33,6 +33,10 @@ This manual page describes only the most frequently used options.
>  
>  OPTIONS
>  -------
> +
> +-p::
> +	For commits, show the change the commit introduces in a patch form.
> +
>  <object>::
>  	The name of the object to show.
>  	For a more complete list of ways to spell object names, see
How about this instead:

-- robin

Include diff options into git-show command manual

--
 Documentation/git-show.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index a42e121..d4708e0 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -41,6 +41,9 @@ OPTIONS
 include::pretty-options.txt[]
 
 
+include::diff-options.txt[]
+
+
 include::pretty-formats.txt[]
 
 
