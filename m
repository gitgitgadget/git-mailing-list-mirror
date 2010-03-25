From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 10:18:51 +0100
Message-ID: <81b0412b1003250218t3205e12cj5a5013d97e2c0e38@mail.gmail.com>
References: <4BAADF34.3080806@gmail.com>
	 <4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu>
	 <4BAAE981.4040205@gmail.com>
	 <e51f4f551003242154p7fb20ffch790dd1ada15eca0@mail.gmail.com>
	 <4BAAEDF7.1080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kris Shannon <kris@shannon.id.au>, git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 10:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NujDP-0001rd-6M
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 10:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab0CYJSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 05:18:54 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62411 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab0CYJSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 05:18:53 -0400
Received: by bwz1 with SMTP id 1so651268bwz.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=j2/zebGyJ5AvHeCs6ohfuz6rZEJxbuS/jFHMkpp3lBY=;
        b=oAjGX+yjEa+LHDa2aL7P2O7fzTUGLQ/KqcqgnwBSxvN3cE3roPVna6zWSaJvHodXsn
         L48VlvpcYcMasNVszEvJuZ2os9WnSxsp71QM03mIQ+ZwniY3g0x0EV/ZvGuN65yFlXia
         ew7O1k6YO+d7BuXfF+8mZOTNkWAD1fwglfLBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KZoFIIShqCeUQpsIAou0/nqSK0jtvtn5F3TRDphLjNats/nFWo9tH5TZ2iJMBDQTAu
         ArLIyNRjyHe+JTQ2lWAU2BujsJLa8XqdE/ku284k421oeWaqMD45wk9I+/hvevzNbUEv
         q77huNFX5yMvz2icKO6BcVLLs0L7qk0ank3QM=
Received: by 10.204.11.11 with SMTP id r11mr535141bkr.12.1269508731448; Thu, 
	25 Mar 2010 02:18:51 -0700 (PDT)
In-Reply-To: <4BAAEDF7.1080107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143174>

On Thu, Mar 25, 2010 at 06:00, Mike.lifeguard <mike.lifeguard@gmail.com> wrote:
> In any case, is the answer "git can't do that" or not? Because that's
> actually the answer I'm interested in.

git commit --author "I am not Mike Lifeguard <mike.lifeguard@gmail.com>"
