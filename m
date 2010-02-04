From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 12:14:24 -0500
Message-ID: <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
	 <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:15:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5IA-0008J9-00
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758425Ab0BDRO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:14:28 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:60372 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758379Ab0BDRO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:14:26 -0500
Received: by iwn27 with SMTP id 27so1834535iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 09:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=HOE3vl09fFkXge/OZVcWmCCzOzAmsPPjk0f1+A/y9eA=;
        b=lCQGRfqEe13dcWKa2DgZvULsBIUGomMYsAS2cwvlNH5L3PAn4B/lD0VZDgrZQmjLRq
         xen5C/4q27qeYsHnXyvBVfgUbcVe9/8RSygqzc95Q3vdTjBRsuAvWSsssQ2NWRIDatox
         hPm3pr9yEKWFm/ffoV5oy6CULYKIjOeHgPIlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LLksLBmEEl0lzDe3KnL5eX4dLCXZAovUSx09EANeP0T8GeCtJXHZLmY0W2KO/Gy4uV
         c8TbqaWeguEVl8ZCcpkUVhdOqkuy0XpY/P2oiFJzCnQyFXBSrDGNC9Kyzl68rXdGMVty
         uFQC6GQOlTqKTmcGYe9pow8R6ff11Pa8kDKq4=
Received: by 10.231.146.8 with SMTP id f8mr448830ibv.58.1265303664757; Thu, 04 
	Feb 2010 09:14:24 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138982>

On Thu, Feb 4, 2010 at 8:27 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> (Here I'm setting GIT_EDITOR=true just to demonstrate that I didn't
>> change the list of commits in the latter case.)
>
> You can get _exactly_ the same behavior if you use -m.

Or rather, -p. ;-)

j.
