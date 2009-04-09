From: James Pickens <jepicken@gmail.com>
Subject: Re: legend on top-right pane in 'git gui'
Date: Wed, 8 Apr 2009 21:11:42 -0700
Message-ID: <885649360904082111q31f1d90br8ee62eb4afba2611@mail.gmail.com>
References: <slrngt4h04.q0l.sitaramc@sitaramc.homelinux.net>
	 <slrngtqr13.566.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 06:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrlf7-00077A-F4
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 06:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZDIELo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 00:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZDIELo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 00:11:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:46178 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbZDIELn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 00:11:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so431254rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nvD8iEf6zuawo01HDRgTV330rvyVJGg/dtvV32ooWPU=;
        b=Lhpo8bcWMfqD5nboxBcpnxqKrsXrjnXAtuFnEGFVizBPjk0IHRVAHprxLai5tHEKrr
         scV+pBp7eizdbwYyu/HBsHWqTI9uIAU7kjmhC78KE7yYnna3c5sLtx0sInvITboxKTrs
         z5VmumQoMGX8orFbvJt3vXQiXy+eypup/227I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mo6JyQbdWk0qCQd+fwWE3WQvlybbnuKD8oyuHrYutlSu8yg2qGIgyOE/p1MkaGFj66
         Rn07jjnIKHhGODls7zQpmGNthJ5iHlmlM/8ndInqNboM+aeVprB8+SOJ23YVfmgCI+tJ
         XHdI4n4rsR758CCPOGnLu/82+GuEr099oMSQw=
Received: by 10.114.146.4 with SMTP id t4mr1166832wad.143.1239250302914; Wed, 
	08 Apr 2009 21:11:42 -0700 (PDT)
In-Reply-To: <slrngtqr13.566.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116140>

On Wed, Apr 8, 2009, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Can someone at least tell me "Sita, you're wrong/this is a
> stupid question/this is perfectly correct behaviour/whatever"?  :-)
>
> I won't even ask why, I promise :-)

Well, I for one think your proposed new message - "untracked, not
staged (partial)" - is nonsense.  A file can't be both untracked
and partially staged.

Also I don't agree that the message needs to be different
depending on where you click; actually I think such behavior
would be more confusing to users than the current behavior.

James
