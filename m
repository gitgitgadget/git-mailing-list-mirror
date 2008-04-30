From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 18:28:00 -0400
Message-ID: <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
	 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
	 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
	 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
	 <1209594215.25663.864.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Thu May 01 00:28:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrKnG-0001gg-Cl
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 00:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762156AbYD3W2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757512AbYD3W2F
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 18:28:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:27135 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384AbYD3W2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 18:28:04 -0400
Received: by fk-out-0910.google.com with SMTP id 18so516878fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hJlaWaRcmV6hqxAtCHPY1/9aDtQPl/oOJll69FFCWDg=;
        b=LF4ObaxOddfkoRq83TPTrYOt5FfEmOVu2F9L58mczT5bFA9Q8O+aASl0TPPf5wFW/UbAbNq8dRPca4D9Alu9Zy3OmUp2klTILnsFzVy1bqdddCifaTKT5019+Kq5qLeICkZMwVMmXCMkCA7I1cbAJzUkTUvmjFQnKL8RMUEIJbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mu2dLi2GXoIkGzbmzopOz9E2t2IkOrE0SqtknfhEteZNamAGyjOO2R0qYFR+YTN2eyT9GWuKSSpV/TJqLIEYhPNczTB8Do0RHU+FNQseHEHp2OEneZMFq1t64YVZs3buTbHtgUhmsOMy2+eU0ITfyh3WrFJ5fybL6rMlE5zR/Gw=
Received: by 10.82.126.5 with SMTP id y5mr190042buc.50.1209594480630;
        Wed, 30 Apr 2008 15:28:00 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 15:28:00 -0700 (PDT)
In-Reply-To: <1209594215.25663.864.camel@work.sfbay.sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80877>

On 4/30/08, Roman Shaposhnik <rvs@sun.com> wrote:
> On Wed, 2008-04-30 at 17:48 -0400, Avery Pennarun wrote:
>  > It would be awesome if you could turn the fancy behaviour of this
>  > bundle into patches to git-submodule, for example, and then have your
>  > textmate macros call the modified git-submodule.  It might be a bit of
>  > an uphill battle to get the patches accepted into the release, but I
>  > think it's worth the effort, as git-submodule in its current state is
>  > just a non-starter for my group at least.
>
> Doesn't the fact that the workflows around submodules tend to differ so
>  much call for different incarnations of git-submodule? IOW, wouldn't
>  it be ok to have an alternative to git-submodule somewhere in contrib?

This would be okay with me.  git-submodule itself doesn't seem to do
anything very complex.  I would be happy to help contribute to such a
thing, as my group needs it rather desperately.

Avery
