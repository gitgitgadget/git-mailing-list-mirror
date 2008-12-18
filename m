From: "Geoffrey Lee" <geoffreyj.lee@gmail.com>
Subject: Re: Announcement: Git Extensions stable (windows shell extensions)
Date: Wed, 17 Dec 2008 16:53:17 -0800
Message-ID: <83d7aaa40812171653tcfa69eex23a22985fc23d3c5@mail.gmail.com>
References: <1229540813648-1669264.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 01:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD79x-0001Xt-7L
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 01:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYLRAxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 19:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYLRAxT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 19:53:19 -0500
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60928 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbYLRAxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 19:53:18 -0500
Received: by gxk9 with SMTP id 9so236946gxk.16
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 16:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3fsZ6TzDY64jCnqX31/nCwv2K6J9UZXnNsvMLPsZAB8=;
        b=Xb5GK5Ez/MuLL5b8TND58orJAibjWfWCQHo2YurxkKQY7IkHGnlsPB0ba2Ai7zFSgi
         AJ1sDfNS/aEYoVquRex1BN/pcCbDXTODMTF8GXXL501OPGTYyyyYMe/moehYc5KiXJmd
         TFWZUK4lNO8JpPAIwtXptwoWD+uwroOKlOWa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kLPdoW9jGkDE5CNWCHq+HQW9oqU+Hci8GhmI/LjxnKMbLOamIqGUUcEWmJb2gFw85f
         62FUnEmPMMkBNWExgbYkrvDpcslSOUUsllm+fdD8KCMWMbIQX+sUqUyABA/cZOipUaUu
         fvWwdJOec5YCN9luyZ3jQbBG2NGUO9BWOl5E8=
Received: by 10.151.99.3 with SMTP id b3mr2351042ybm.215.1229561597113;
        Wed, 17 Dec 2008 16:53:17 -0800 (PST)
Received: by 10.151.122.12 with HTTP; Wed, 17 Dec 2008 16:53:17 -0800 (PST)
In-Reply-To: <1229540813648-1669264.post@n2.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103416>

On Wed, Dec 17, 2008 at 11:06 AM, Henk <henk_westhuis@hotmail.com> wrote:
>
> This is a shameless announcement of my latest personal project; Git
> Extensions. Git Extensions is a Tortoise-like windows shell extension for
> git. Yesterday I finished version 0.9, the first stable release. I included
> about all git commands I know about, so I think it is pretty complete but
> I'm open to suggestions.

I'm curious... How are you dealing with Windows' low limit on icon
overlay handlers? TortoiseSVN already hits the system limit, hence
their development of TortoiseOverlay to provide a common icon overlay
handler for all the Tortoise* projects. Have you gotten GitExtensions
to work side-by-side with TortoiseSVN? You might want to take a look
at this document, username "guest" and no password:

http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/src/TortoiseOverlays/Documentation.txt

-Geoffrey Lee
