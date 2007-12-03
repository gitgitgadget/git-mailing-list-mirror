From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: committing only selected diff's of a file
Date: Mon, 03 Dec 2007 03:09:41 -0800 (PST)
Message-ID: <m3tzn0uj9s.fsf@roke.D-201>
References: <4753D465.10802@ecocode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 12:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz9Bc-0001Pl-4f
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXLCLJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 06:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbXLCLJo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:09:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:35684 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbXLCLJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 06:09:43 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2675989nfb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=aCLW9p8JAAMvZn+88jGa8G+vRxEF4UurorT5jwUOrnQ=;
        b=UnYgsD3sV/Dphf7HwMRdKnxXFkIFgvERhub2EbCr/JyxCj4cjtzp8RMkk87Rc6KletdBXGSaBhDTDs18p+zIjM9ixXoooslLYh7FFEK7dOTjW2rnsLh2pqDAkM8M0C0fmJYmomybwfkDsYfjDiPNGolbfavWvHApaSO3D+sbzPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=uCTDIhIEPDiKFDc4QtQvDFLQEg53rMWREyxJfHq3Nb1lw6bLSKKeT3EVwdXJu8+pxuJlyAOmP/rqyGicq5GobA47S6PMXwdQYwjTKOi5hhxjIPl/6Mkly7YhGFhj3oc4x6l6ODYrYV9y+7OpOVgbeZdw7B8zy1nJgD+jZQ2Ziuc=
Received: by 10.86.1.1 with SMTP id 1mr10511427fga.1196680182305;
        Mon, 03 Dec 2007 03:09:42 -0800 (PST)
Received: from roke.D-201 ( [83.8.225.86])
        by mx.google.com with ESMTPS id e11sm6103022fga.2007.12.03.03.09.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 03:09:41 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB3B9bm4006188;
	Mon, 3 Dec 2007 12:09:37 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB3B9ZkE006185;
	Mon, 3 Dec 2007 12:09:35 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <4753D465.10802@ecocode.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66908>

Erik Colson <eco@ecocode.net> writes:

> Does Git allow to commit only selected patches from inside 1 file ?
> I'm coming from a darcs world where this is supported...
> Probably it is supported in Git too, but I can't figure out how :-/

Use "git add --interactive" or "git gui" (the latter requires Tcl/Tk).

-- 
Jakub Narebski
