From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 12:42:37 -0500
Message-ID: <20120525174237.GA4267@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 19:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyXM-0003xS-JD
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab2EYRms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:42:48 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43821 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab2EYRmr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:42:47 -0400
Received: by gglu4 with SMTP id u4so1020698ggl.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nxdVh9uDjtAN/oFEe+mZd8Z0Fg08AuzQHSLjb+1T660=;
        b=PIcg57oaWiC6DtqQCjurq3GNVedWiuJMFkNDJ8I61f8N2LwkrwTVDzaDLMW4R2XeWJ
         M3Wys28timQy2FcjLx+gLJ5oXlWzvQJPZ1UtReOWfFp7PqJ6VBYx7GmLxwYHDX6ovSVc
         BJZQAOK/mrydbSFWFEavT5z1ZNTSqkReBiGYCycp8QwT/D/xSX4yDX5ZgMf1at6ZfwUL
         F3rv4dEuQL+/zyfc2B94upcQenbx7f62NWqah7p69ySSGio+M1IEp95HVTQAqAZnZipp
         eeEckwItpTorsXh6O8Bl/YpZFm7vbmfRHiy58x+CxTh0DpAgkDxFadiqZDTAKdDhGLL5
         dwmg==
Received: by 10.42.132.138 with SMTP id d10mr531577ict.28.1337967766483;
        Fri, 25 May 2012 10:42:46 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wh8sm7947616igb.11.2012.05.25.10.42.43
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 10:42:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198491>

Hi Hilco,

Hilco Wijbenga wrote:

> This is, of course, highly OS dependent. Ironically, I'd say we need a
> setting in .gitconfig for it. :-)
>
> There is also /etc(/default|/sysconfig|)/git/config to consider
> (perhaps for some settings that should be the same for everyone).
> Better yet, it would be nice if at least some settings could be part
> of the repository itself (whitespace handling e.g.).

The FILES section of git-config(1) might leave you happier. :)

Regarding $GIT_DIR/config, it says "The filename is of course relative
to the repository root, not the working directory.".  Is this out of
date?  (Cc-ing Peff and Duy.)

Jonathan
