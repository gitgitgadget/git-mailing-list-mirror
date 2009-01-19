From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 13:00:10 -0500
Message-ID: <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
	 <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
	 <20090119172939.GA14053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 19 19:02:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOyRP-000626-Fl
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 19:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbZASSAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 13:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZASSAO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 13:00:14 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:29111 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbZASSAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 13:00:12 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1298223yxm.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6WYi4IAeHUMk6avbMxrr+30X/Lp4uMAFfxLpu/lwEzQ=;
        b=voWO1Wgo7O8ZXjDO+SbyZrJIHX+G3jaEctKqW8qwgjb9l9hMdPLAqmsmfMGwNrZYow
         /YTpdhPO+hssarTeWRQdWcuE/xPVily/+bxb/GQisoRJwzopp39qBrDZJaSUTeE9FG79
         fHjXAoOxTfG7Pyhdb6XacO133VK20S9wyhS5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZJ8PdPTa2P1GX+dtNFO+Vgm3VT8gm70MTe4ALdMlUAlb3AOs5DusaZSnNSHJj+PJNO
         EP6dtJuNgyHJRd+bgLyuftukUWzdwRMA0sOjkO+mQLZ0Ez5GFhY7XB+wyxnY2VlJU1M9
         gd96cWLn0ct0vSnrlsFoVJ4uaUnL9oSPNDzrQ=
Received: by 10.100.163.15 with SMTP id l15mr4102377ane.128.1232388010953;
        Mon, 19 Jan 2009 10:00:10 -0800 (PST)
Received: by 10.100.8.5 with HTTP; Mon, 19 Jan 2009 10:00:10 -0800 (PST)
In-Reply-To: <20090119172939.GA14053@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106377>

On Mon, Jan 19, 2009 at 12:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> ...  If we had
> an inotify sort of daemon to keep the data current so the prompt
> doesn't have to stat every source file on every display it would
> be reasonable, but we don't have such a thing yet for Git.

Note that inotify is not recursive and is a hog if you ask it to
monitor lots of dents.

I am not convinced that an inotify-enabled git is a good idea for
anything but small/mid-sized project. And such don't need it either.

In other words, the kernel's cache will outperform any userland
attempting to keep track of the fs via inotify.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
