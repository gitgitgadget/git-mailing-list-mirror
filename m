From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 17:10:59 +1200
Message-ID: <46a038f90706192210t4594cc86he6a2dd6093b9a1f3@mail.gmail.com>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
	 <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
	 <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
	 <alpine.LFD.0.99.0706200053520.20596@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 07:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0sT8-0007tl-4z
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 07:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415AbXFTFLA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 01:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756841AbXFTFLA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 01:11:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:47735 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbXFTFLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 01:11:00 -0400
Received: by wx-out-0506.google.com with SMTP id t15so70124wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 22:10:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K1fUqrze0Llqr1WHpgxvP2TxbKVsfkyimrAJTdG7wp4S+HoB/dkPY3Mu3GvNc/7ekitNtpZcjfoEf85VnZ+hT1pWsRPbicHb6nxmzcVAMYWillw5c2XHonulfk6gGTnLsyttwdGm+csdMAUKF0xhmRop+GJhM9uN1Vbs+keyt6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U6nGjKq4EE/OrPUsW91l3oPM6PdhlLIN547tb7ko1BMXywLw0LhZPgWdoJJ7XMKp6mXdFsXHYhaTDUseWDtBE0kCs7ann6G90fQTPqkxIJQw4hRLPw1UwspVBgbGc/3qmp5awqinBjs9Ypt4cPPKSmXUBJCELJLX7+peUdWJM3A=
Received: by 10.90.98.3 with SMTP id v3mr33476agb.1182316259441;
        Tue, 19 Jun 2007 22:10:59 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 22:10:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0706200053520.20596@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50532>

On 6/20/07, Nicolas Pitre <nico@cam.org> wrote:
> Well... to be fair, we should say that your setup is a bit non
> conventional.

You mean this doesn't affect things between 1.4.0 and 1.5.0 on either
end of the git protocol?

> I also note that you're using cogito.  And from what I can deduce, it
> seems that cogito is simply copying the pack(s) over without further
> sanity checks.  This only serves to muddy things even further.

Yep - we are moving away from cogito; the machine is important, but
it's very awkward to install/upgrade sw on it.

cheers,


m
