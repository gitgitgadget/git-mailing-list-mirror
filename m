From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 17:10:14 +0200
Message-ID: <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <8e04b5820809120533o1e7da548l6868660767a5435d@mail.gmail.com>
	 <m3vdx1o72x.fsf@localhost.localdomain>
	 <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com>
	 <20080912145804.GF10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <hoegsberg@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAIz-0003By-Ct
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784AbYILPKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbYILPKS
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:10:18 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:27963 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbYILPKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:10:16 -0400
Received: by rn-out-0910.google.com with SMTP id k40so646416rnd.17
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DzP1a9zA0rNXYemJNQejs8AYyEdogW+s/YTQ4Ffvm1c=;
        b=EgLHAucSa4s1XWkpYx22qOcwDcaLw1VjzS4iZ4cmGZD8KXWbiPKEhkJKjyv/NQ+kEn
         qiERaXG3ah7XRSqUH1oIaJhRprSuKP8fzHTN/J/3BGpcWay2lIzL1Bv0Bc681Ap+plub
         5h/OyORlM6JVaGKXu2h0tvG+SoMZhSdGuc/k0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bkLlLIEy/f2YOmj6XxUQiNfIRITicYjBSHbovv4lbNzG0PlpWlSBT2IFCSfgIEBXPF
         FYBE474GNOxwP1Y7NdmnfM5LrcI94OLO52gTYKl+helVRLEcIRtUNJtL9OJGO4B05vwd
         OAFPxfe+hbmIuGXaWydrp3iyYzQ1zePjy1z7g=
Received: by 10.114.201.1 with SMTP id y1mr3453055waf.216.1221232214909;
        Fri, 12 Sep 2008 08:10:14 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Fri, 12 Sep 2008 08:10:14 -0700 (PDT)
In-Reply-To: <20080912145804.GF10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95733>

On Fri, Sep 12, 2008 at 4:58 PM, Petr Baudis <pasky@suse.cz> wrote:
> it seems that cgit
> requires all the repositories explicitly listed in the config file.
> Do you plan to remove this limitation in the future?

Not really, I'd rather add another command (or a commandline option)
to generate an include-file for cgitrc by scanning directory-trees for
git repos. I've CC'd Kristian since I believe he's got such a script
running for freedesktop.org; if so, maybe it could be included/used as
basis for something similar in cgit?

--
larsh
