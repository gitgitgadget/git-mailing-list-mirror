From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: [PATCH] Give error when no remote is configured
Date: Wed, 11 Mar 2009 07:19:15 +0100
Organization: Sugar Labs Foundation - http://sugarlabs.org/
Message-ID: <49B757E3.8000807@codewiz.org>
References: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Giovanni Bajo <rasky@develer.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 07:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhHqL-00052g-B2
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 07:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbZCKGTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 02:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZCKGTT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 02:19:19 -0400
Received: from trinity.develer.com ([89.97.188.34]:54104 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbZCKGTT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 02:19:19 -0400
Received: (qmail 1142 invoked from network); 11 Mar 2009 06:19:16 -0000
Received: from static-217-133-10-139.clienti.tiscali.it (HELO ?10.4.4.169?) (bernie@217.133.10.139)
  by trinity.develer.com with ESMTPA; 11 Mar 2009 06:19:16 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112887>

Daniel Barkalow wrote:
> When there's no explicitly-named remote, we use the remote specified
> for the current branch, which in turn defaults to "origin". But it
> this case should require the remote to actually be configured, and not
> fall back to the path "origin".
> [...]

Thanks, works like a charm!

-- 
   // Bernie Innocenti - http://www.codewiz.org/
 \X/  Sugar Labs       - http://www.sugarlabs.org/
