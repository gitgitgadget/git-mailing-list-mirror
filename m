From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: git-svn and svn properties on upstream
Date: Sat, 12 Jul 2008 20:07:36 -0400
Message-ID: <eaa105840807121707s45dfe936m94a0ceeac82d8a66@mail.gmail.com>
References: <608871.39190.qm@web27807.mail.ukl.yahoo.com>
	 <32541b130807121430ia85a3c8u3efc0b5a8591eb44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gnuruandstuff@yahoo.co.uk, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 02:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHpBo-0004lT-5E
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 02:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYGMAHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbYGMAHj
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 20:07:39 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:56595 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYGMAHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 20:07:38 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2363650fkq.5
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=GRnzDP/TUXC1MxbFhUUm6S4cr4HHXdDBhZfhAK4VzPk=;
        b=Jis8TxM+WeGiVO3DTLTcs9kQJ932lwl+Bp5gl6tPlxR3AnUSwv01zuTP04F1Viz+DI
         QXYMJEEDFTDmbDpmuvYA4YGPVy7B4DELggYQ0DWcFYRmTLk1+MvrYprTwrxXKJtqhukW
         ei4oX7u553zhJjQJ8XO16O/0zP3vhtz00OswM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=qkeP1MRVRz+1Z5MW1QVLEtuC0qJfU7sFn0nbnVY4CP2f7NyOBLX9UTR5sgmauOask9
         bxREgfFC2BBs3mP+Fxahe6+P9enMmHhg7yWYfPtLf5+2wThdauyn4awJIxEIt+1ehSmB
         RUNVqh51VWLIB3gSwfCjtzqGs5+N2jLnOR/Ek=
Received: by 10.125.100.8 with SMTP id c8mr3347209mkm.157.1215907656329;
        Sat, 12 Jul 2008 17:07:36 -0700 (PDT)
Received: by 10.125.159.20 with HTTP; Sat, 12 Jul 2008 17:07:36 -0700 (PDT)
In-Reply-To: <32541b130807121430ia85a3c8u3efc0b5a8591eb44@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 925f4164b07cc455
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88275>

On Sat, Jul 12, 2008 at 5:30 PM, Avery Pennarun wrote:
>
> I guess in an ideal world there'd be a way to track svn properties in
> the git history, but I have no idea where such things should probably
> go.

.gitattributes?

svn:eol-style translates roughly into crlf. svn:keywords translates
(partially) into ident.

git appears to ignore unrecognized entries in .gitattributes. The rest
can be stored there untranslated (or lightly translated - ':' is not
legal for .gitattributes names, if I read the comments correctly).

Peter Harris
