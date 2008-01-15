From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 13:04:23 -0600
Message-ID: <c0f2d4110801151104j4c34dekc7d06dcfc89bfbe6@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	 <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	 <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
	 <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>
	 <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness>
	 <c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com>
	 <alpine.DEB.1.00.0801151709330.5289@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEr5k-0001bn-7s
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 20:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbYAOTE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYAOTE1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 14:04:27 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:56797 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbYAOTE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 14:04:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4489940wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9LeyixcwQix431As72FG5tlv6IO6Fm3M8aagazvx65c=;
        b=mvkSup7CpZIxvnZqRDPFHlEll2ioGptZrWRAIgQ9140xJLKGr9TB6F7QuZB8R2bJ9jOwwIHUN/mRIcY7hbf98VtgtWA6uPg96CL8jU+vspI3XMwJM85jP7GEJQfcOwKttAne8twZ+igqZ2fkVkTPcZWTHUDIy8MPWx7t+jK1MIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=omxOreyz+U3bhaT2Lw6qMZYqSqOotgpHFIgbWtEgKit4J560EY3jOEE9vTLbeskYABfGbUVniKgGOgJ1cpvS8TJjoYlBXAipyTM+bmZQprfMXqnDoZZupxaTPevtFjpspDBnI/G7RIyABVuu3LjcotNv4MgDO3k1ph8pc2wd6jw=
Received: by 10.114.149.2 with SMTP id w2mr5118937wad.5.1200423863398;
        Tue, 15 Jan 2008 11:04:23 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 11:04:23 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0801151709330.5289@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70542>

Myself and many others have excellent luck with the cygwin version.
But the reasoning behind wanting this isn't so much for the developer
that is creating the patch as it is for the person receiving it. Most
of the projects I work on use tortoise to apply the patches and don't
typically have patch.exe

If something like this was to be accepted and become part of standard
git is there a requirement that it be written in perl or is some other
scripting language fine?
Thanks
