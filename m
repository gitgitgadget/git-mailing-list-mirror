From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 12/31] Add another RemoteRefUpdate constructor,
	useful for 2-stage push
Date: Tue, 19 Aug 2008 09:45:18 -0700
Message-ID: <20080819164518.GG20947@spearce.org>
References: <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVULh-00018v-Kq
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 18:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYHSQpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYHSQpU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 12:45:20 -0400
Received: from george.spearce.org ([209.20.77.23]:46151 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYHSQpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 12:45:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9B0AB38375; Tue, 19 Aug 2008 16:45:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92881>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> New constructor base on existing RemoteRefUpdate instance, providing
> deep copy of object, but allowing change of expectedOldObjectId.
 
> @@ -133,6 +133,8 @@ public class RemoteRefUpdate {
>  
>  	private String message;
>  
> +	private final Repository db;
> +

I think we should document that this is the *local* (source)
repository and not the remote (dest) repository.

-- 
Shawn.
