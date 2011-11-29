From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 11:41:05 +0100
Message-ID: <20111129104105.GA10839@kolya>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
 <201111291024.01230.trast@student.ethz.ch>
 <20111129101546.GB2829@kolya>
 <201111291125.41943.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Manuel Koller <koller.manuel@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 29 11:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVL7O-0004qB-Ql
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 11:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1K2Kku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 05:40:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54409 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab1K2Kkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 05:40:49 -0500
Received: by faaq16 with SMTP id q16so65578faa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WHZ/wDwCyKt44ZMgiE0S0Fed6fusICWJE+v92kbt1MM=;
        b=OB9zyacQY1s+qbe4axQ7d+RiCQZa9SLymq33KHtUMy96jiJJotm/LNd4gYfye2fBVo
         ybwsfdl6DVQPtJsDTJ8pAQQCLQk4JDNFgLJU0f+ORNsw7OLqjvxk0CHumV0XKqqYcwnF
         HuOHok2jSuEHihd1tf/bNajr4q4wjXOJBXBqY=
Received: by 10.205.135.129 with SMTP id ig1mr50517338bkc.106.1322563248055;
        Tue, 29 Nov 2011 02:40:48 -0800 (PST)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se. [82.182.194.253])
        by mx.google.com with ESMTPS id f14sm36146711bkv.3.2011.11.29.02.40.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 02:40:47 -0800 (PST)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1RVL7Z-0002pN-VX; Tue, 29 Nov 2011 11:41:06 +0100
Content-Disposition: inline
In-Reply-To: <201111291125.41943.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186053>

On Tue, Nov 29, 2011 at 11:25:41AM +0100, Thomas Rast wrote:
> So maybe the right questions to ask would be: what's the *official*
> way of removing a submodule completely?  Do we support overwriting
> submodules in the way Manuel wanted to?  Why not? :-)

I suggest that we add a command for that;
git submodule remove <submodule>

That should be pretty easy and straight forward to do. However I would
like to hear what Jens, Heiko and/or Junio has to say before starting t=
o
implement it.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

E-post: iveqy@iveqy.com
Tel. nr.: 0733 60 82 74
