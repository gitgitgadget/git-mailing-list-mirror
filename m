From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Rename RevTag.getName() to RevTag.getTagName()
Date: Wed, 12 Aug 2009 22:37:36 +0200
Message-ID: <200908122237.37148.robin.rosenberg.lists@dewire.com>
References: <1250105956-17795-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKZw-00035H-Ib
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbZHLUhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbZHLUhi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:37:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:27361 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbZHLUhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:37:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 56BF01434E84;
	Wed, 12 Aug 2009 22:37:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxcUhGy8r0jD; Wed, 12 Aug 2009 22:37:37 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id CFE861434E81;
	Wed, 12 Aug 2009 22:37:37 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1250105956-17795-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125743>

onsdag 12 augusti 2009 21:39:16 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> The method getName() conflicts semantically with the method name()
> we have inherited from our base class, ObjectId.  It is a rather
> unfortunate turn of events that for performance reasons we wind up
> subclassing what should be a property of this class, but since we
> do that we need to pay attention to the methods declared on our
> base class.
> 
> We want to use getName() to be a mirror of name() on AnyObjectId,
> as it has a more JavaBeans style feel to the accessing of that
> particular value.  So, rename getTagName() so it doesn't wind up
> conflicting with the SHA-1 hex formatted string.

> @@ -204,7 +204,7 @@ public final RevObject getObject() {
>  	 * @return name of the tag, according to the tag header.
>  	 */
>  	public final String getName() {
> -		return name;
> +		return tagName;
>  	}
>  
>  	final void disposeBody() {

You forgot the rename of the method here, and all uses of it.

-- robin
