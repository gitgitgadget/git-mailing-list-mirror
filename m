From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 21:40:05 -0400
Message-ID: <9e4733910708221840nb28476g3e6789f432e334ac@mail.gmail.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	 <Pine.LNX.4.64.0708221713540.20400@racer.site>
	 <86mywjcwv7.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0708222033040.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 03:40:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO1gW-0007rU-VG
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 03:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXHWBkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 21:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbXHWBkJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 21:40:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:19733 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXHWBkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 21:40:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so398936wah
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 18:40:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gVqvwiHJaqCsmfn3GKcNjEQ15/xusGg7wsXQynOxSjc+W7oKMYlN887iaKJbk4g2N/lgtBcZN97EFrq2odC6em93WE05ywkHFWOJNlLycdV83y+YKvRhnXLgZ/9bxVT5R7sgBSMtM6bWzFiFKANg3WhUtskuv8SKHAvwEI6ixPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCyHNrVvXJIX5pEoyKoEQOfyrQ7E5sw4nonRcRIQL95iZfSFnQwFSAGlGSrnzRN3OhD5eXE3chPIK+rma1zojKvZMI4x+WE4hzfUreeVf0czddcYWWO8G6Nv7dzzttJRXZoApMO5gydpoCVmbwVl/znh1NFyzeIQZBgMYeoJg/o=
Received: by 10.114.177.1 with SMTP id z1mr1529257wae.1187833206200;
        Wed, 22 Aug 2007 18:40:06 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Wed, 22 Aug 2007 18:40:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708222033040.16727@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56446>

On 8/22/07, Nicolas Pitre <nico@cam.org> wrote:
> Indeed. And this is the very same reason why Git should _also_ acquire a
> script interpreter of its own if we want to continue bragging about
> Git's easy scriptability.

Last project I was working on that needed a scripting language picked lua.
http://www.lua.org/about.html

I had never heard of it before but after working with it for a while I
found it to be a very nice package with minimal resource requirements.

-- 
Jon Smirl
jonsmirl@gmail.com
