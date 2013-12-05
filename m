From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Thu, 5 Dec 2013 14:27:19 -0500
Message-ID: <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
 <52A0D199.1010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoeaP-0005tL-6B
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab3LET1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:27:41 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:52608 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab3LET1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:27:40 -0500
Received: by mail-vc0-f177.google.com with SMTP id hv10so13271152vcb.22
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ELVsMsQgfmFmihL6Yw/aSnfGEZjA3mXgh+nbyn7fQtc=;
        b=jmVbUJvi4ITO/5vG5IVFMT4eXtp7RGtpLry67kYzeC+2DMzglv6PxNt7h5mKZUbfoc
         hGDggKoVejBaofHTtZbyoCHFyvjVedwzxYD8nymAvfjezRMLxdsP5c+oWz4woBjK63Od
         WQ/WUIccNVesZ3BdHg7zpTpzdvvZXccNyaHjS4YEjomgbmEuiETEyvVPaoZ4oTDmPKGv
         Jpl+W1a9HMPjpfsHRr5O1OCho3FCB6gND55Ad2Q4squx9xmbSQMUfn4SR47J/e31wDUF
         tbAky8+4p97IZG4vRa6Gg4ihD95YU41SwcwCHogLnyG9c53PBzO/uPLYnG+ADIq6UDi5
         LgFQ==
X-Received: by 10.52.113.170 with SMTP id iz10mr2346090vdb.56.1386271659813;
 Thu, 05 Dec 2013 11:27:39 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 5 Dec 2013 11:27:19 -0800 (PST)
In-Reply-To: <52A0D199.1010403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238900>

On Thu, Dec 5, 2013 at 2:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Without knowing more I can't think of a reason why submodules should
> not suit your use case (but you'd have to script branching and tagging
> yourself until these commands learn to recurse into submodules too).

The submodules feature is way too fiddly and has abundant gotchas.

I am diving into subtrees, and finding it a lot more workable.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
