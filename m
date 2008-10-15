From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: BUG: git rev-list segfaults
Date: Wed, 15 Oct 2008 16:32:32 -0400
Message-ID: <32541b130810151332k68669bf0t44481973e1c2889@mail.gmail.com>
References: <Pine.LNX.4.64.0810152034040.7572@rosenkohl.springl.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephan Springl" <springl-git@bfw-online.de>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqD44-00014L-I4
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbYJOUce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbYJOUce
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:32:34 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:19471 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbYJOUcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 16:32:33 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1338148rnd.17
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xEuWgOHYi2Y2D6ZmbWVcNru4nxA10G2DRBgxkRUJiT4=;
        b=Wul4uwepqbxEepED4fuAsM2AFnlUsVNaBARPHjgbnw522eTYrBeKMVFPaSXZJ6xQmX
         qNysl/SsbAvC5X0lVpIKncINjyAA8dgWlFdDaQyzh+fxOf+LqH/mpRhSeI9UZZPd4sbL
         8HWjHXlIJhhkD453z7ibyGwAmTvbA3facdb8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rMDg/iROzmNBgSqNH/1ENdJUn5dwxilqr6TNf7W0ng/aHVZyatIoQqSQh4lz7yPV2g
         6yuxRoznavYFLsq8dZpBhaYWsmtXbCBxqB7YEt2e6A//wa9OAzMuC79gy2/AukqAs1wY
         iPtwSrDHP7sMse+hO2Os0r2zaUGFGizKYiuU8=
Received: by 10.150.177.20 with SMTP id z20mr1874401ybe.98.1224102752438;
        Wed, 15 Oct 2008 13:32:32 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 15 Oct 2008 13:32:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0810152034040.7572@rosenkohl.springl.homeip.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98323>

On Wed, Oct 15, 2008 at 3:00 PM, Stephan Springl
<springl-git@bfw-online.de> wrote:
> git rev-list segfaults when crossing a merge commit when given --bisect-vars
> and --first-parent.  This is on branches master, next, and pu from
> git://git.kernel.org/pub/scm/git/git.git right now.

See this thread:
http://kerneltrap.org/mailarchive/git/2008/8/23/3050004

Unfortunately I worked around the crash in the scripts I was working
on, and I have since been sidetracked, so I haven't been able to test
Junio's fix.  It's still on my ever-growing to-do list.  If you try it
and it works for you, please let him know.

Thanks,

Avery
