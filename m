From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] fast-import: notemodify (N) command
Date: Tue, 1 Feb 2011 01:13:06 +0100
Message-ID: <AANLkTikz-3euie78rDAO=QVLwoW-r36T5zfmSVQ14Y-k@mail.gmail.com>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
 <1255083738-23263-8-git-send-email-johan@herland.net> <20110131183350.GB31826@burratino>
 <AANLkTi=3P0xc3mJj5Tsg_P26SAXmgVfCk1VeYQ=k2UtT@mail.gmail.com>
 <20110131190128.GC32374@burratino> <AANLkTikxFSa1CSujk2zgh4K8SWCuKHRrDRFVNt9JPGo0@mail.gmail.com>
 <4D4739B5.6080103@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, Johan Herland <johan@herland.net>,
	gitster@pobox.com, git@vger.kernel.org,
	Augie Fackler <durin42@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 01:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk3sc-0004RM-5u
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 01:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab1BAANs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 19:13:48 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63301 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab1BAANr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 19:13:47 -0500
Received: by gyb11 with SMTP id 11so2230458gyb.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Te5YkHN7t3O+y3UVpITYWwSbIuxGDitvFH8mnzWRROg=;
        b=DFyqn2W9BqXe024u0eBDFdnThpZNbB3fmJXdnGw1FEaGNXTpkjAZFn6gLgWh6GVDh2
         NUdcAKMm5ROJQPeFynaFldKOWOjVlJOY8CDaVXDMr3P6aqXRe7Db1az47nJEb7xWXnja
         X+CoEQOzZNhn5GKXAO7V0IbgdBg3rcyUgDhq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZSKwxKNWq10Pu1WeKSKvfGnj1LJ5ru8TUpcaBjuNF71LLiI8J9jGapZOp7wrjbbesj
         6XhhTxxLRm0xv/1j+PudaYw9lmsdUFDiq2+XyNJpnniAKb0iKSaGbgPr1iQfJjZ4hMUh
         7B5q9a+sQljMlH9Vz6KsqIequP1LhjbjoUcdQ=
Received: by 10.150.50.12 with SMTP id x12mr8844365ybx.112.1296519226562; Mon,
 31 Jan 2011 16:13:46 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Mon, 31 Jan 2011 16:13:06 -0800 (PST)
In-Reply-To: <4D4739B5.6080103@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165778>

Heya,

On Mon, Jan 31, 2011 at 23:37, Sam Vilain <sam@vilain.net> wrote:
> This is not a "fact".
>
> If you add configuration in your git config to fetch and push the refs,
> then they are propagated.

Heh, I was contemplating whether to add "(by default)" or not, I guess
I should have.

-- 
Cheers,

Sverre Rabbelier
