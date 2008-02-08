From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 11:23:30 +1300
Message-ID: <46a038f90802081423v13a19a65oe842b94ba7f85528@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
	 <alpine.LSU.1.00.0802081151170.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbdf-0001Bv-4a
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYBHWXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbYBHWXd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:23:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:32098 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYBHWXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:23:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so952467ugc.16
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SovJGu8jVHMBVRcJvOdVWQxTwUa7IyyVzvKnEKRTLM0=;
        b=xdk/HEKtUH9rHF9GQctL6lfjpBgwJiSFsSc73K0mMBKlyzRsnDQLILAG10opM54hH0knvBLZxUibqhO8dTt/tco8Zqc/bLKfAPjY8JAH2TvR4N9twtLNDUXNsBcOZOdbR620VAejgnKmBOqenh81glfWUeSdfH1YeDsG4TbJ6eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=At9r5ihTiGIBet9TNjM1rjydTe5SmlRGYa/+ieOrkOjPrnNlYxcbGyS19aYhbSOY6qHr5pqF0iYn9W8bQwto1KjyUa6vxEuk0ePNd6tBq/ppzWW9uhyDM5XIEttrIHnVcR0tTsvNa54weqChgZNWi7udv6RZWsmCD26iVF+yMR8=
Received: by 10.66.221.17 with SMTP id t17mr5904624ugg.66.1202509410687;
        Fri, 08 Feb 2008 14:23:30 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Fri, 8 Feb 2008 14:23:30 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802081151170.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73163>

On Feb 9, 2008 12:52 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> That question comes up pretty often, I think.  But you need a working
> directory to resolve conflicts for merges.  You only have one, though.

Once all the remote refs are fetched, it is trivial to determine that
it is just a fast-forward, therefore _no_ merge and no chance for
conflicts...

cheers,


m
