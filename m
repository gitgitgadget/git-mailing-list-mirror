From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: a few remaining issues...
Date: Fri, 5 Jan 2007 12:27:55 +0100
Message-ID: <81b0412b0701050327u6bf2a716s1fb38fb62e2ebb9d@mail.gmail.com>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 12:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2nEv-0005rk-34
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 12:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbXAEL15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 06:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbXAEL15
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 06:27:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:56152 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161065AbXAEL14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 06:27:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5677422uga
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 03:27:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ijW86y9O2c3zUNLYiyo2B0AI/vch7/dq84Q++HcSpXVnKFUCpNbku6eKruyeHlEpjNLsL9V+AP8Ibo9yos5sQXhr+fXGD362mgw84q7FCEyJScQ/QUjkh+65UykdvOoWLHassRkYVb27GtB7pGgse20C2+vAdz6i7XDkOr4wtGM=
Received: by 10.78.170.17 with SMTP id s17mr4333223hue.1167996475513;
        Fri, 05 Jan 2007 03:27:55 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 5 Jan 2007 03:27:55 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35998>

On 1/5/07, Junio C Hamano <junkio@cox.net> wrote:
> This is not meant to be an exhaustive list, and I probably will
> change my mind after I sleep on them, but before I go to bed,
> here are a handful of glitches I think are worth fixing.

Maybe we should at least mention another cygwin quirk:
cygwin (or is it its bash?) treats .exe files and +x-files without
extension somehow stupid: it prefers the file without extension
to the .exe. For example, after installation of git-merge-recursive
you have the old python script and git-merge-recursive.exe in
the same directory. Guess which one is used... Right, the old
python script. Same for count-objects and other recently
rewritten scripts.
