From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Fri, 19 Nov 2010 13:49:07 -0600
Message-ID: <20101119194907.GG26187@burratino>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
 <20101114215442.GC16413@burratino>
 <AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
 <20101114220932.GE16413@burratino>
 <AANLkTi=JR3vVnZ4Yz8o9MpZKiQ2_ASYxahbPNv8QACir@mail.gmail.com>
 <20101114234848.GB26104@burratino>
 <AANLkTimWyjrRD951AGeEayMoTNd-N2OXRd_wQ0RBFegN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 20:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJWyR-0003ch-Ia
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 20:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab0KSTuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 14:50:07 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43242 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab0KSTtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 14:49:55 -0500
Received: by qyk7 with SMTP id 7so45088qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 11:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nNCNmgPaysRGUuiUBHHhVWf3vU/kNPwPiUMBggHz9e8=;
        b=eypc5RtGa0jVNGX5TmK5vev2RvkMJjqnUlMcK2e9Z/lraUB4qptb9yIELyfZlo3qJD
         N39oCm6Tkk3poupixzxdtAm2Tr7Zq03Cmx46g78ri+nSvtZo8cw3gDztXSuwRQKzmcl6
         A/H309FTB50TPUejUoK+8iUM7/QFU2ENTXM3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I4kKNB8c8Ij3YWHvijXmtucdib9cQcyEg2XWFFFxsaNV9bBzT9Ju7N61Ak3aNR3xeb
         w8vg70Bf99gy2i+1OyMbhNoii7lmRIlPfhGxmJUg6ZHcwpQPfibaAuAQhumnonaiRc1l
         BdDKfUckD4GEkUR7MjPA0BtRbtQp371LTImS0=
Received: by 10.224.202.200 with SMTP id ff8mr2099713qab.211.1290196194347;
        Fri, 19 Nov 2010 11:49:54 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm1185812qco.30.2010.11.19.11.49.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 11:49:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimWyjrRD951AGeEayMoTNd-N2OXRd_wQ0RBFegN@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161779>

[resending to list; sorry for the noise]

Bert Wesarg wrote:

> Could we settle on a name space for such variables? GIT_EDITOR_* makes
> it obvious that it is for the editor started from git.

Sounds good to me.

If the choice of variables ends up looking especially good, maybe
we can pass it along to the Portland group and call it xdg-editor for
use by other apps, too. :)
