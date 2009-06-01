From: Marcelo de Moraes Serpa <celoserpa@gmail.com>
Subject: Re: Spreading .gitignore rules to svn:ignore and keeping them in sync
Date: Mon, 1 Jun 2009 00:10:34 -0500
Message-ID: <1e5bcefd0905312210l60497a0p2d84795b1cb84420@mail.gmail.com>
References: <1e5bcefd0905291623v6d90d9acv92bdaa05b0e72ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 07:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAznH-0001kD-IF
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 07:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbZFAFKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 01:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZFAFKd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 01:10:33 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:59136 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZFAFKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 01:10:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so15494582and.1
        for <git@vger.kernel.org>; Sun, 31 May 2009 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ZU7Na126ZhMp/3Y+u42DqOxfgJdGaHQjrhQzncTXDNA=;
        b=GPjATkZWUGs5e7vmhBdnkrZIlJQTEOnfpAntuVkoO4wmXmI5AbUZ9BnED7wkGNS5V5
         BQua8uYIWjPRkyLioaTmnpaoWOhU8Cn8n4KZAoKLI0/VEjmFuR+MrjNDPPv5ium5GlWV
         m/73YbX50n/RTK6pJ8iAiFFVfvxp+b5agXqw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hLmPepBnL/JYKLTU3NETQvTtBL3uboEJ2TT2etqp3Q8y96I+VMvW7OlE0lX1dXV5Rf
         NHpIdeMhmx6GQdQdlAoiVTCsxJSg7ERAeWmAe1ln+Pi5Fj24oxAl2nTkuj1vawXBLaPh
         ldSJwcel5tUjCRjrjdFTpBQbwsN4GzBGzXeMM=
Received: by 10.100.141.15 with SMTP id o15mr6561500and.20.1243833034740; Sun, 
	31 May 2009 22:10:34 -0700 (PDT)
In-Reply-To: <1e5bcefd0905291623v6d90d9acv92bdaa05b0e72ee9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120443>

Anyone?

On Fri, May 29, 2009 at 6:23 PM, Marcelo de Moraes
Serpa<celoserpa@gmail.com> wrote:
> Hello list,
>
> I'm working on a project that is using svn as it's
> vesion-tracking/control technology. I'm the only rebel and I'm using
> git-svn to interact with this svn repo :)
>
> I need to make the version control system ignore a specific file and
> spread this ignore rule across all developers. Now, if everyone was
> using git, this would be a simple solution -- just create a .gitignore
> file in the root of the working tree and commit it. The thing is, all
> other developers are using svn, and I'm not sure how I could put this
> entry into svn:ignore for them and also make my .gitignore synced with
> svn:ignore.
>
> Any ideas?
>
> Thanks in advance,
>
