From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: avoid atoi, when possible; int overflow -> heap corruption
Date: Mon, 22 May 2006 09:54:52 -0400
Message-ID: <118833cc0605220654r51ce7764udab70c1ee89d9c3d@mail.gmail.com>
References: <87mzdcjqey.fsf@rho.meyering.net>
	 <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
	 <871wumim28.fsf_-_@rho.meyering.net>
	 <118833cc0605220616t75a182b1oa404d5efe8a1f5d9@mail.gmail.com>
	 <20060522133746.GA12302@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon May 22 15:55:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiAs8-00016T-4K
	for gcvg-git@gmane.org; Mon, 22 May 2006 15:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEVNyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 09:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWEVNyy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 09:54:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:11195 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750835AbWEVNyy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 09:54:54 -0400
Received: by nf-out-0910.google.com with SMTP id c31so430623nfb
        for <git@vger.kernel.org>; Mon, 22 May 2006 06:54:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jKkFDy/avGUWgtSqjieqN0oiUpSwl4AMu5ALDHECrKsvmfKBQe2y+RWx4l6jJd9KOKNvW5yMwxY6qTmqktgJTOePl9MHHzKd46wMm/9b8ZFvQ8la3BbaPGHnfdwKHt6LfBQmh3lfLfw7fcT79QzVHDZzYwKicVd0zygbcOscfqQ=
Received: by 10.48.210.14 with SMTP id i14mr3801880nfg;
        Mon, 22 May 2006 06:54:52 -0700 (PDT)
Received: by 10.49.12.11 with HTTP; Mon, 22 May 2006 06:54:52 -0700 (PDT)
To: "Morten Welinder" <mwelinder@gmail.com>, git@vger.kernel.org
In-Reply-To: <20060522133746.GA12302@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20506>

My copy (which is admittedly a draft because I am cheap) does not
restrict undefined behaviour to _range_ errors, but simply says
"Except for the behavior on error, they are equivalent to [the strtol call]"

M.
