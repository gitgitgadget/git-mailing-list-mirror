From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Wed, 8 Dec 2010 20:11:17 -0600
Message-ID: <20101209021117.GB31119@burratino>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com>
 <20101209015926.GA31119@burratino>
 <192758EC-4276-445D-B1D5-284073D5AB32@sb.org>
 <AANLkTikOehig7LjpUC=b6iSjGnuF=TsZmipWDfQB7AW6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 03:11:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVyq-0003ac-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 03:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623Ab0LICLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 21:11:31 -0500
Received: from mail-qy0-f177.google.com ([209.85.216.177]:53025 "EHLO
	mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0LICLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 21:11:30 -0500
Received: by qyk27 with SMTP id 27so1349892qyk.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 18:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rSjp5/bae9xKbukSxqvGkskzTxi+DrXMKbkHn8fgnQQ=;
        b=ItxWWkigW4HlNPxjW/BxBPIfY3136aQWhRfxCFLrEEWPsfGlDZjyuoBxRQ2UIPXAFx
         NIGnaUaYTWuPqvWmIfvv17RQpCQnVwLLF/8uvIfcojhPehP9jYdGAp6EgNxQ097eCAir
         smI08XDdpa3ely/1Wb4S+mVc3EH2aGeFfWY+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m4NyWh97JPmQDX1JZnUc5sguj2sLJjaFiyn2cBA47XaZVGlLr7smGUGhWuyflVnG6T
         KFHFYrPOYRbu5iWhkf1fH7PLFfxjzfG48YIpfhPbNuGf67dNVL51LV1SRR/EfzRGxUsV
         iwx3iqT1zymEp6CHO0uva2+tTr8FtJ3WgIE2U=
Received: by 10.220.176.131 with SMTP id be3mr1866163vcb.199.1291860690016;
        Wed, 08 Dec 2010 18:11:30 -0800 (PST)
Received: from burratino ([69.209.58.175])
        by mx.google.com with ESMTPS id e16sm386672vcm.32.2010.12.08.18.11.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 18:11:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikOehig7LjpUC=b6iSjGnuF=TsZmipWDfQB7AW6@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163259>

Nguyen Thai Ngoc Duy wrote:

> OK so :nth(3)/foo for all branches?

That steals namespace from "the path 'nth(3)/foo' in the index".  But
is "the third instance of foo in all branches" something that needs to
be possible to say?  Branches do not have a well defined order,
anyway.  A command to list all commits with "foo" in the subject
like

	git log --oneline --grep-subject=foo

sounds more useful (assuming --grep=foo yields too many false
positives).
