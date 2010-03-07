From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: How do you add an external directory to repository?
Date: Sun, 7 Mar 2010 21:23:02 +0100
Message-ID: <20100307202302.GB19693@iveqy.com>
References: <1267992229319-4691734.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: slipstream180 <ivan.barrios@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 21:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoN3l-0005X2-4z
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 21:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab0CGU0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 15:26:39 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:42311 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0CGU0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 15:26:38 -0500
Received: by ey-out-2122.google.com with SMTP id 25so761729eya.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=BQlZ3CzVgIZj4KpAfMmeUuGLU6TwUI9K2PWWrTVko+U=;
        b=oAqeGaR5l0ffevUV91pRu7MqEkLcmAJ2roxYpMWGtUXT8+zz7NjSrUYNxgg5vcUFLw
         yA8OGkyyQHFDPkYcv+Hi4Rz0ae5kM22Hlt2BqvLHGdCBOZKakrgN47Fv4I5D0Vu62Azl
         RhgSjwIfXdeDGWxTII6vEemxKUwwXY52MQ/es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wh4Ufrty1NCpWUgQbQUaaCoipej7Hsx5kZkeUj8JDrTQGWoUsLEsSRAa/i9xms2Er3
         HZpuuhFB7H6/3qhN4r68/816QV6ZDPj55jaObnmIW7aBnQLKPOxHF6npugRoRNMtmscz
         0gAlSNOWVzewXM9mCnKRO3dzPSG+v6ouvNEpY=
Received: by 10.213.1.130 with SMTP id 2mr2285685ebf.85.1267993595535;
        Sun, 07 Mar 2010 12:26:35 -0800 (PST)
Received: from paksenarrion.localdomain (h-93-102.A189.priv.bahnhof.se [94.254.93.102])
        by mx.google.com with ESMTPS id 15sm1932159ewy.8.2010.03.07.12.26.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 12:26:34 -0800 (PST)
Received: from iveqy by paksenarrion.localdomain with local (Exim 4.69)
	(envelope-from <iveqy@iveqy.com>)
	id 1NoN0A-0005HA-7o; Sun, 07 Mar 2010 21:23:02 +0100
Content-Disposition: inline
In-Reply-To: <1267992229319-4691734.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141727>

On Sun, Mar 07, 2010 at 12:03:49PM -0800, slipstream180 wrote:
> 
> I want to add an external directory to an existing repository.
I'm unsure if that can be done, I don't think so.

I do, however, believe that the superproject functionality can suite
your needs. Then you will have two git repositories, one wich is
handling the other.

It sounds really more complicated than it is.

http://en.wikibooks.org/wiki/Git/Submodules_and_Superprojects

regards
iveqy
