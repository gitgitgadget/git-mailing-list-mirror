From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 13:43:02 -0500
Message-ID: <20101015184302.GA22990@burratino>
References: <loom.20101012T114900-532@post.gmane.org>
 <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
 <loom.20101014T095743-275@post.gmane.org>
 <i9a6kn$d7o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 20:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6pIh-0002Ay-A3
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 20:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476Ab0JOSqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 14:46:39 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:59254 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab0JOSqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 14:46:38 -0400
X-Greylist: delayed 169947 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Oct 2010 14:46:37 EDT
Received: by wye20 with SMTP id 20so69472wye.11
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rrtt7pGUp53b0ZlJKwmx7iCuZoYgc9ea/VambVdd/zI=;
        b=UIDAr8hABuVzrg9dYvluVL2qKGf2Q2ux1GtHmpmrZaCbnOzyJ7dhkm99qcUsHmACPb
         iattDkdMGU08HL+WShukDpZAtPVshdBWVSLbnO0CBxmqK32NQ7+qABNTFhaZUo3VqpBv
         LCuUIo11qVxSS60mrZkFRHOdXGU31MJR9rDsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MoXm+yIc7MRsReAmcm+8FRkYy9GLfhQXlXraIXzuxjzaSvF63BYSS6dWspB4bo6tB7
         KcBH0eNUsQiwSv4b2BfxZZR0NImmqDeGUyPMjAEMIL4QBJ8tGTqmMOReRDiTaLF9+J5E
         dHY1nRzY3tYfxeGoG/bYpvpS8PBGuJmqJcVXs=
Received: by 10.227.146.139 with SMTP id h11mr1298730wbv.197.1287168394232;
        Fri, 15 Oct 2010 11:46:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a17sm8718256wbe.0.2010.10.15.11.46.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 11:46:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i9a6kn$d7o$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159128>

Hi Neal,

Neal Kreitzinger wrote:

> However, there is an option in git-commit to copy files directly from the 
> working-tree to the object-store by totally bypassing the index

What option is this?  I thought "git commit --include" added content
to the index.
