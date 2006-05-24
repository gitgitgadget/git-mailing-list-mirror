From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 20:25:39 +1200
Message-ID: <46a038f90605240125q3fb58466w55745348846c48fc@mail.gmail.com>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
	 <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 10:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiogf-00016l-Qv
	for gcvg-git@gmane.org; Wed, 24 May 2006 10:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbWEXIZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 04:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWEXIZr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 04:25:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:16433 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932665AbWEXIZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 04:25:46 -0400
Received: by wr-out-0506.google.com with SMTP id i3so1446820wra
        for <git@vger.kernel.org>; Wed, 24 May 2006 01:25:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZlIv09BpQUY9HxQNuFikyN1cAsBqMrtt6nBYpk/BBxXkkt0CpgiDIn07hVzF+go/HjMKMs1WW5uQ//ndT04m4rmpSP1Qfvpfeqn0n1H92a3+uNB9PEXmpS+ekbNXQ2Qqu6d543W0ZgcVZfLKx+UyZzMPA9PjKXWFyLbRcJKYNPM=
Received: by 10.54.153.18 with SMTP id a18mr6926980wre;
        Wed, 24 May 2006 01:25:39 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Wed, 24 May 2006 01:25:39 -0700 (PDT)
To: geoff@austrics.com.au
In-Reply-To: <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20673>

On 5/24/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> You _will_ need a lot of memory though, as cvsps grows large (working
> on a workaround now)

While the workaround is worked around, you can create the cvsps file
using something like

CVSROOT=~/tmp/gentoorepo/ cvsps --norc -x -u -A gentoo-x86  >
gentoo.cvsps 2> gentoo.err

and then pass a -P gentoo.cvsps to cvsimport. s/gentoo/myproject/ ;-)


martin
