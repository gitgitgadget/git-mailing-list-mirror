From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FastCGI support in gitweb
Date: Tue, 04 Mar 2008 09:22:45 -0800 (PST)
Message-ID: <m37igiietq.fsf@localhost.localdomain>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com>
	<m38x12jeqt.fsf@localhost.localdomain> <47CBEED2.30808@vilain.net>
	<200803040119.22240.jnareb@gmail.com>
	<slrnfspi8b.83u.jgoerzen@katherina.lan.complete.org>
	<m3od9uiyru.fsf@localhost.localdomain>
	<slrnfsqoai.njm.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Juan Jose Comellas <juanjo@comellas.org>
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 18:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWasK-0003Ds-W6
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 18:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758308AbYCDRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 12:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbYCDRWv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 12:22:51 -0500
Received: from ik-out-1112.google.com ([66.249.90.182]:7171 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765295AbYCDRWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 12:22:49 -0500
Received: by ik-out-1112.google.com with SMTP id c28so1158133ika.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:newsgroups:subject:references:from:message-id:lines:user-agent:in-reply-to:mime-version:content-type:posted-to:date;
        bh=wV2bQURZbOF3v3DdeAbIfVx8I7vPDTg6Z83W6tnSvjg=;
        b=dVDxpo7x09ubq74poz6WSSLn1dzt4Cvefqx3EzGz7rdOitoqEUglcEWBqlnKhyyuxu4zH+hbrF/VPbVvXL2/J8PutsggzaP27bXwmx4NhXKpu8/xHD75eoVVhey9/oDH66zARrYgnAEy29WbAGdHrdIGGgg1dXw2pV8iOkj7ULY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:newsgroups:subject:references:from:message-id:lines:user-agent:in-reply-to:mime-version:content-type:posted-to:date;
        b=v1zeE47GDQwHrky2fbp9X7BfKL0lBr7uQha6AFPgZEF7LMcBFCCoY0irgkIkYVFyfKTLEqv2JbmrT4EM8WAr+MpiT3snvauPY/UulXZ8Nik7ju6tmCdd+nwdbuZcqB0MWyj8Wjs8IAbmF0Q7HexP47+GsyXt91XCpMFzKjclr8A=
Received: by 10.78.168.6 with SMTP id q6mr3637691hue.65.1204651366982;
        Tue, 04 Mar 2008 09:22:46 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id c25sm2257188ika.9.2008.03.04.09.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 09:22:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24HN2ZF013796;
	Tue, 4 Mar 2008 18:23:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24HMwfd013792;
	Tue, 4 Mar 2008 18:22:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
Newsgroups: gmane.comp.version-control.git
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
In-Reply-To: <slrnfsqoai.njm.jgoerzen@katherina.lan.complete.org>
Posted-To: gmane.comp.version-control.git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76122>

The following message is a courtesy copy of an article
that has been posted to gmane.comp.version-control.git as well.

[Cc: Sam Vilain, Juan Jose Comellas]

John Goerzen <jgoerzen@complete.org> writes:

> FastCGI is much, much lighter on resource requirements if you are
> deploying apps written in various languages on a single server.
> Sometimes even if you aren't.

If you want to add FastCGI support to gitweb, besides fulfilling
constraints I have mentioned earlier (it must run as CGI and mod_perl,
must run without CGI::Fast / FCGI), I think it would be best to
separate input validation and dispatch into separate subroutine.

Perhaps even going as far as getting only required input in the
"action" routines, for example
  our ($hash, $hash_base) = gitweb_params('hash', 'hash_base');
at the beginning of git_commit() subroutine, etc.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
