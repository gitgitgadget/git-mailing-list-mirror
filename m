From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] fmt-merge-msg: Update fmt-merge-msg and
 merge-config documentation
Date: Fri, 20 Aug 2010 09:10:35 -0500
Message-ID: <20100820141035.GD16190@burratino>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
 <1282307041-19681-4-git-send-email-artagnon@gmail.com>
 <20100820123935.GB9448@kytes>
 <4C6E78CB.1090907@viscovery.net>
 <20100820131218.GC9448@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmSKh-0005QD-7l
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab0HTOMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 10:12:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36855 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0HTOMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 10:12:18 -0400
Received: by pxi10 with SMTP id 10so1215628pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nw+TFWTCnplS8feZKahywhE03iPALO9KqMP+C0h/qyQ=;
        b=NrP9oWkP1KwocVJcltqmUw4CCR2b4Z4VKNT9TySZLpDyLshiTQUSE/5FgsLhOMldAD
         WJZsXjeumYhWMDpWSn21N7SocHh9pDjiwyL7j2dTnWJsrHVcD8hdgtj+Xqt4gfD0hvge
         D9hVckBjArfUbH8qBlvZKs5F4UlPSaKkmPe4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Px577uyxMHx/E4XcR4j0/FiAA5zIpJeqdZOuTeK8Lt+NEH3yh3Wq7N2QckK17jkE5L
         TuF4/IeW3Jk4lsuNA8DB38jn4pfc9jrsh+2h2wurGbd9QdHYXsjBDc8IcXlYFedaJwVO
         sl4gi/Ru/FZwGf+UEJZCKckjtAHZPjP7e3dwg=
Received: by 10.114.102.11 with SMTP id z11mr1584942wab.13.1282313537583;
        Fri, 20 Aug 2010 07:12:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i8sm1056673vcr.9.2010.08.20.07.12.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 07:12:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820131218.GC9448@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154041>

Hi Ram,

Ramkumar Ramachandra wrote:

> I noticed that the command-line parsing framework has only OPT_BOOLEAN
> and OPT_INTEGER, but no OPT_BOOLEAN_OR_INTEGER.

--no-<foo> works already with OPT_INTEGER.  But for --<foo>, one
needs the

 { OPTION_INTEGER, short, long, &var, "n", description,
   PARSE_OPT_OPTARG, NULL, 20 },

form.
