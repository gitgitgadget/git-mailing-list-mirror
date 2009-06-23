From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Wed, 24 Jun 2009 02:38:24 +0400
Message-ID: <85647ef50906231538m118120adnd2292b65ec953baa@mail.gmail.com>
References: <20090622214032.GC19364@coredump.intra.peff.net>
	 <20090623011001.GA15352@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 00:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJEdN-0003FO-SK
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 00:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502AbZFWWiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2009 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbZFWWiX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 18:38:23 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:55098 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbZFWWiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 18:38:23 -0400
Received: by ewy6 with SMTP id 6so635750ewy.37
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F5lL1AotxMcaCG1jsSXB7VmpTdQA0s/vLtyv8orpfIk=;
        b=d1t9JRB8i4tb7wiSUtHOvTiz58djuAIjdgNIurvJTqyIzrQtCkTYag7urksqRKMQOd
         5V2nAsZSkP+QvVAYxroZNFPKglFXCmrR8dCQas9S+o/lG8ADEObx9AX2oi/lPWum1VYs
         ezB0WSA7WbWfcxtl9reLWXLt9HoDo8Zd3x9Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jIYfRO7zI3hEEfB4PF8ukr5e1Q/6tUm2ryGKCt6d/Uop4Fh2xwQgY/SwR26OJCU4xg
         EVvzYreHTyMfpnpwypIY+aRxDmC9OYV5kRXrcps3TRSFrVgYTv7xO9Ove4HHU8Z2SY7j
         +YKmaSVSDZzEuvOFwQShYBHsS91UsF2TbwuMQ=
Received: by 10.216.29.201 with SMTP id i51mr173170wea.214.1245796704093; Tue, 
	23 Jun 2009 15:38:24 -0700 (PDT)
In-Reply-To: <20090623011001.GA15352@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122113>

On Tue, Jun 23, 2009 at 5:10 AM, Larry D'Anna<larry@elder-gods.org> wro=
te:
> If --porcelain is used git-push will produce machine-readable output.=
 =A0The
> output status line for each ref will be tab-separated and sent to std=
out instead
> of stderr. =A0The full symbolic names of the refs will be given. =A0F=
or example
>
BTW is it possible to have --porcelain + -v together. A machine
readable progress output would come very handy for IDEs and other GUI
tools that use command line tools.

The git tendency to be less verbose when there is no tty is really
annoying from point of view of GUI.

Regards,
Constantine
