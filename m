From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH svn-fe] fast-import: make code "-Wpointer-arith" clean
Date: Mon, 28 Feb 2011 17:15:11 -0600
Message-ID: <20110228231511.GF1942@elie>
References: <20101224080505.GA29681@burratino>
 <20110226114435.GB12231@elie>
 <7vhbbolm5q.fsf@alter.siamese.dyndns.org>
 <20110228213210.GD1942@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuCJI-0007pb-4e
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab1B1XPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 18:15:19 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39383 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab1B1XPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 18:15:19 -0500
Received: by vxi39 with SMTP id 39so3662142vxi.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 15:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SDNlnU3ERBZQl5IaGTTPpAJtyVt30diqGzQsQnxPSTU=;
        b=V8Qg4jSuuAix18zs72OBlakc9hnyNdj0XJ7k73vuEZXWwuic8EslNJv19W7q+ezZK3
         PVaHY/s7tO66MBBqjpVI+Ify6ScBtI2qNg6RUTgGY35/c+TgoraNuvP/OZWwsfcNVt2G
         T2wWQoDX+q2r83VS2dP3dIG76h6NuBUOQtPXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qET7kaGbSTjOQ1Llt3OvLPl4ayQfiGJwQwXLvC8oedATndzrPHgPSmnT9f7SGyRKYR
         tUV/Tc/CHFvUkDqsgOCB6wDqG2QO/xfLMIlENeqnJjc+l6wXpKn/zFv4w8SV9N9lQMx7
         VRBQGQzUg/+7ajkxsJz4VG3ui1LrVsznqYXWs=
Received: by 10.52.173.35 with SMTP id bh3mr5490982vdc.206.1298934918520;
        Mon, 28 Feb 2011 15:15:18 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id l6sm1895911vcp.38.2011.02.28.15.15.16
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 15:15:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110228213210.GD1942@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168162>

Jonathan Nieder wrote:

> This should fix it, I suppose?

Pushed out.  Thanks again.
