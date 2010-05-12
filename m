From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/8] Documentation/notes: simplify treatment of default
 display refs
Date: Wed, 12 May 2010 05:50:02 -0500
Message-ID: <20100512105002.GB17740@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
 <20100509033223.GF7958@progeny.tock>
 <20100509070022.GC23717@sigill.intra.peff.net>
 <20100509084325.GA9801@progeny.tock>
 <20100510060630.GC13340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 12 12:50:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC9WC-0007Ac-Fh
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 12:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab0ELKtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 06:49:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62165 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab0ELKto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 06:49:44 -0400
Received: by vws17 with SMTP id 17so1982291vws.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Eil4FGYhYotg2+/dSlDUfEuXXNxpCQfq4tGkmtFU8KA=;
        b=EWY5swxbHnYlQLB8W/jA02yRLmVABSKZJOr1MGU74dvPEhZ+emhEpscJP1fxiJsU3b
         e4Uew35RszamFUEBRp/KTRNihm0CmZKUrXCLNLpyA9WJIB5qaCu/YKbipwaC5QqGuED7
         m6HPXLGZHOejj6Dca9GHpLHaxRXfEIz3+uKKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QpfZegDe18ssx2Zsq1rt5H0JSDEx1Cd8cqCyAEF2FK/Nzu5r2F+oOxGk/IYne5xiQt
         GNEpo2ouXUwt9TnLRm6T0HxOgLn9JYD4czwF6V+O/GroAB1wXgr/zjGWNP4Ff0wsB210
         UCUBMUzcAF3BWke3/REwP27rbQSENvEWxFj2E=
Received: by 10.220.123.68 with SMTP id o4mr1160209vcr.148.1273661382664;
        Wed, 12 May 2010 03:49:42 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id s9sm140150vcr.15.2010.05.12.03.49.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 03:49:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100510060630.GC13340@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146938>

Jeff King wrote:

> Searching
> for "conflict" even in just a list of options should come up with
> "merge.conflictstyle", and I had always intended for such a gitconfig=
=2E5
> to have a full list.

Makes sense.  So the breakdown of that page might be

  Synopsis
  Description
    Syntax
  Configuration items
    Sections
    Index
  Core configuration
  Identity
  Suppressing advice
  Command aliases
  Colored output
  Paginated output
  Examples
  See also

with the index listing all configuration items, with a short phrase
describing each.

To keep this maintainable, I would like to have a single source file
with a short and long description for each configuration item.  Then
a script would process it into an index and snippets for the relevant
command pages.

I=E2=80=99m anxious to get started.  Thanks for the pointers.
Jonathan
