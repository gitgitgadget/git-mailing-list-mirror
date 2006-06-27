From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [TRYTHIS] cvsimport: fix initial import
Date: Tue, 27 Jun 2006 22:52:48 +1200
Message-ID: <46a038f90606270352w32e3888dk1557eefbe1043d92@mail.gmail.com>
References: <44A102F0.9090604@op5.se>
	 <Pine.LNX.4.63.0606271234350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 12:52:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvBBd-000227-64
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367AbWF0Kwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWF0Kwu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:52:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:36158 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933367AbWF0Kwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 06:52:49 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2515403ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 03:52:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Za1oiQq694vnjg11z+opIEyE8hOIVoOJH3Kbsr9uOnZETCIlvQqHb+qvZA5B+eLen1xool/HnK7Jh/UaCtBK+4fpT2A9qrc87mThH1ZEsGvyJ8AGrVfWAR1hPpnUVOur0/8dxyr2Du+Ys3Z4AErIX61yy5GB3r58RdilbO0R+mM=
Received: by 10.78.151.3 with SMTP id y3mr2453556hud;
        Tue, 27 Jun 2006 03:52:48 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 27 Jun 2006 03:52:48 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271234350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22728>

Hi Johannes,

this patch doesn't quite make sense to me. The git-read-tree should be
in the else block of the unless you have right there (and it's
actually there, but it may be breaking in some cases? Perhaps should
happen a bit earlier?).

How do you expect to run git-read-tree or die _before_ git-init-db?

cheers,


martin
