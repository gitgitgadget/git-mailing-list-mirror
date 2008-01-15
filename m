From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 09:58:12 -0600
Message-ID: <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 16:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEoBY-0000SP-Tg
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 16:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYAOP6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbYAOP6O
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 10:58:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:47147 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYAOP6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 10:58:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4401175wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=G8EbTjv6yfrUcp+uaW6oeKlz3fo9XHzPFVmgSuc3tMg=;
        b=B9Nwylyx0Jc3mardyFz5QUv8m+QFtsUQts75Gtgfzc+jnEDXaS+Lz3igR1Tz/hoog2cwVwb6EThiTbU3up0k78R2nFZshYdnNV4f7DFqnFhjZVZyK4OjRSEIpJ8ccAsycsaOSmVKIsMy5pFxtHRIC+gpaUojasEHaVxKUPoGkuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pWtsZZD0J44CZ/X5kIPRCCq5SFDemt7rGkC/2nEcjQdaEbO68OWHDBcZrgxI9JfY0ClDkFlqbg0Qh3ET0PVMwIODHvHxXEpDqaHVolbeXNm+FaqSlsHiuI/00IuMf/CVz9f7EDFQ7u9JfVTmRVyrpUP71X1hbdtPvdCmgxHx4Ls=
Received: by 10.114.146.1 with SMTP id t1mr5289142wad.20.1200412692842;
        Tue, 15 Jan 2008 07:58:12 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 07:58:12 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70528>

The format that TortoiseSVN expects is the same as the format of svn diff.
The most apparent differences are

diff --git a/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj
b/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj

becomes

Index: Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj

and

index a0a0d38..9676e16 100644

becomes

===================================================================

and

--- a/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj
+++ b/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj

becomes

--- Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj	(revision
4715)
+++ Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj	(working
copy)

The rest is pretty much the same.

Thanks
