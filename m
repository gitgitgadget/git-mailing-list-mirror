From: David Aguilar <davvid@gmail.com>
Subject: Re: Can't build git on Lion?
Date: Thu, 28 Jul 2011 23:38:13 -0700
Message-ID: <20110729063812.GA64045@gmail.com>
References: <CAF5DW8+efO0jcynyhg3GCZc5JByHwQzudqtrJXF87YazYjF2mw@mail.gmail.com>
 <loom.20110728T141556-724@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jack Nagel <Jack.Nagel.1@ndsu.edu>,
	Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 08:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmggp-00019v-Ek
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 08:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab1G2Ggt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 02:36:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60706 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab1G2Ggt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 02:36:49 -0400
Received: by gwaa12 with SMTP id a12so297714gwa.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vknzT0GHAF/uahQ4it3rOoVheYYjpGFT/wttY+LCm5w=;
        b=MiRUGM7LorcJpX+7h5CCFkPrhgiPQothe29IVA6M+J+r+BaYCqpZiIfWpdtw/pAhO6
         1lvIOHunCKSbutNu/eWoWAVD0cLMWFWaUve5oQjEuBigcD0lGPkGK43gpA1CvwgOl9le
         Xhc72weBAKFva/M6KQbx7wZzG3WS74NOjWtv8=
Received: by 10.68.1.103 with SMTP id 7mr1750946pbl.81.1311921408041;
        Thu, 28 Jul 2011 23:36:48 -0700 (PDT)
Received: from gmail.com ([216.151.15.131])
        by mx.google.com with ESMTPS id d3sm1823059pbh.21.2011.07.28.23.36.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 23:36:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20110728T141556-724@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178126>

On Thu, Jul 28, 2011 at 12:19:01PM +0000, Jack Nagel wrote:
> > There's no /System/Library/Perl/5.10.0 directory, but there is a 5.10
> > directory.  Symlinking that to 5.10.0 gives me :
> 
> I've seen this issue pop up serveral times in the last few days in various 
> places; the solution is to install (or re-install) XCode as the installation 
> does not persist correctly across upgrades. Versions prior to 4.1 are 
> incompatible with Lion; also, after you download it from the App Store, make 
> sure that you run the "XCode Installer" app that is placed in your 
> Applications folder.

The last time I saw this error it was because the Perl version
changed.  "make clean" fixed it for me.  YMMV.
-- 
					David
