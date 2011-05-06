From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 09:17:19 -0500
Message-ID: <20110506141719.GA2991@elie>
References: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 16:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QILqm-0000x5-1H
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 16:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab1EFORj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 10:17:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49636 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1EFORZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 10:17:25 -0400
Received: by iwn34 with SMTP id 34so2702282iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7ghrMbUJgDlqvdsPfIDZFtPklCjCfCXFj8px2bxXRo8=;
        b=unrD/khrwa78tZeV7XT3bmgdV2mD5A5L5cAf6ETNMFyI8CiM2yHEsCC+hLX3LxCyJX
         Dj7TzkUevDKVhdHx15L+dqTUjUXPuUw3ifOOhsmRq1081wg4SKuOS6B2dZ3TR/9ctm3W
         mMnECLdp0I2T/RScp2htI7uxj5NBTQ/TOg7Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D1sY/CdXyq56bSR4Hw3HgOA/zhNL70ZVnF6Ke7a4QMqzsXhK+4Vfmr3XqlsKxPU54Y
         TMpbtoN0fXNC+7RyReVEUYa+6p0yLXOKI5+IYWQ4JnyiMnC3E/rRpY65R8QI3lFPfFxL
         lmDubeaQoxc0ZA06X+JLyeaBVq4Q3iORKySWQ=
Received: by 10.42.59.74 with SMTP id l10mr2812183ich.62.1304691445439;
        Fri, 06 May 2011 07:17:25 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id i3sm1362602iby.23.2011.05.06.07.17.23
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 07:17:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172975>

Jon Seymour wrote:

> If git supported the concept of a standard place to put extensions,
> then it could be as simple as:
>
>     unzip -d $(git --plugins-dir) plugin.zip
>
> with no need to configure or choose a prefix and no need to edit the
> an .profile or .bashrc to permanently add a directory to the PATH.

Why not use "/usr/local" in place of "git --plugins-dir"?  (I can
think of one answer --- namely root privileges --- but it would apply
to any system with one standard place to put extensions.)
