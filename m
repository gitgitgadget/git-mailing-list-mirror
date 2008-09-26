From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Fri, 26 Sep 2008 12:41:52 +0200
Message-ID: <e5bfff550809260341k1ac474c4j470594c53e916d2b@mail.gmail.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>
	 <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:43:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjAmu-0003kS-3i
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 12:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbYIZKlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 06:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbYIZKlz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 06:41:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:5004 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYIZKly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 06:41:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so854338fkq.5
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gVXgWTyslyQtBAc7tQgWDwIOclFQkjMmKMzcmYsajp0=;
        b=edYwnnfJUz192i3o1toYkcszByl7XqmlEE9ycROwECd7kdc7qyG/8SmxHVQLt4OSJc
         f50uXmxg6ibqy0Fr7zjeV6vyH7JUpu91dt909o8LBY7IJkCN2ZcKeWi7dlh1c9TTVjj9
         KWD8fIMclpFeiEYeLxKz3iEXfNhz5NWFoCQec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NKPF1coSxCmWxZaqlQ+0oJJR9/RdwT0uAP+r5zhwsMEX6Rh3ZOXbU1pkBgBCkpGt/r
         9KareMOAqvP0dXTTesZPgPvKRrfS88OLViLdPk6uU9AOh+xBctnUewq2IlOCFgaFRUAv
         atMUrTT3XPQhez5t0mKda0JgGPgxaEQVoQQzA=
Received: by 10.180.214.13 with SMTP id m13mr567542bkg.75.1222425712674;
        Fri, 26 Sep 2008 03:41:52 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Fri, 26 Sep 2008 03:41:52 -0700 (PDT)
In-Reply-To: <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96845>

On Fri, Sep 26, 2008 at 8:32 AM, Wincent Colaiuta <win@wincent.com> wrote:
>
>  [regexp {\b[0-9a-f]{4,39}\b} $id]
>
> would mostly eliminate that kind of false positive.

This feature is already implemented in qgit from a long time. The most
difficult false positive I have found is the debug backtracing in the
log messages. Memory dumps are a big sources of false positives.
