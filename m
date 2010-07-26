From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 00:08:49 -0500
Message-ID: <20100726050849.GA16858@burratino>
References: <4C4D152A.7050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>
To: julio.lajara@alum.rpi.edu
X-From: git-owner@vger.kernel.org Mon Jul 26 07:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdFwv-000190-HX
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 07:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab0GZFJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 01:09:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34675 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab0GZFJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 01:09:56 -0400
Received: by iwn7 with SMTP id 7so2505294iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BwiCvxfMsnM4FZz9zJlj7w5Joz6WfaxKGguDiqNejD4=;
        b=ocoudQ+Lc1DY2N8kEC66gd2CvedH92DSGOjWfeAOx89vN8edhJHFjGVU/hXJbA57d3
         fhHRrOVi+qwYlfeNE519S/eGRtarTa/batIy3PkBKT4mC6YaRcTGXE8qamK/hsP2YJdq
         60hemlSuxcwXIlBjzQvEinmfzYqxei60RACMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rryzVfAYvX1Ld6sMnb8Et4VhYosvvrcwZ/Yz9G/RilnAqb1OikapKUSyKB9rUH3dO4
         KzIE+N/mg2YUdHZZjHgE7FR8nPCv/zd0rzatj0ekHfVG2vs/ff8rZTxPmje8+ttkZvp8
         ODMl4+hD/StP24uhgAlGlqYxUtBIZ2D+VWZZA=
Received: by 10.231.146.134 with SMTP id h6mr7916007ibv.170.1280120995718;
        Sun, 25 Jul 2010 22:09:55 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm3272751ibi.12.2010.07.25.22.09.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 22:09:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C4D152A.7050505@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151806>

Hi Julio,

Julio Lajara wrote:

> Hi all, I recently had git/gitweb (1.7.0.4) setup on my Ubuntu 10.04
> box and decided to add ppa:git-core/ppa to get up to 1.7.2. After I
> did so, my previously working gitweb stopped functioning

Indeed, the rules for installation have changed with v1.7.2, so
the packaging may need to be adjusted[1] to match (see
gitweb/INSTALL).  Please report this to the Ubuntu git team.

(I am not sure what the proper way to do that is.
https://bugs.launchpad.net/ubuntu/+source/git/+filebug will at
least reach the right people.)

Hope that helps,
Jonathan

[1] e.g. http://repo.or.cz/w/debian-git/jrn.git/commit/ff41c31c5
