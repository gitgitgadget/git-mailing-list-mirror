From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Documentation/git-tag.txt: Clarify tagging of objects
Date: Mon, 24 Mar 2008 19:16:26 +0100
Message-ID: <1b46aba20803241116k20072dc8wdb70e6de90ed25aa@mail.gmail.com>
References: <1206371505-7698-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Pieter de Bie" <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:17:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrEm-0002Up-Hh
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762493AbYCXSQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 14:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762473AbYCXSQ2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:16:28 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:5227 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762328AbYCXSQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 14:16:27 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1417739rnb.15
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OFr9A7rQOeJ09TlYhQabcp854J13RUrdbSf7uySba+o=;
        b=YnN1lR4MaPjvVQGzEmNaICn6yhGkA9jiesO8iIiEf3AXDuI1DDiWjoO0JA4SD25ZWf758pjMs71G8eItE2y9On89oybQqx7AIrVVctOoUYmgsSug/ZqAii3/jXE+JAH6uZqlnAA9Cm3/YTIaZp6okVFghIzqUdDfxHsJsuyP0OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oepsiAdtm7YA8ucxgYvYPfKVi6o/7vFVRd9KHYK070S/9ORx4eTLjFpBfA5udaiB4sgI6BYH2715fwvLPvpyDOfmUDY7mAeia9p8EBvSuvEuMpjK7Bk8r9vMDBInY8akIXLtL4iI6v39thCE7j5ybFY0aW/WVOjsMPHnIztWtrY=
Received: by 10.141.172.6 with SMTP id z6mr2432944rvo.54.1206382586057;
        Mon, 24 Mar 2008 11:16:26 -0700 (PDT)
Received: by 10.141.115.5 with HTTP; Mon, 24 Mar 2008 11:16:26 -0700 (PDT)
In-Reply-To: <1206371505-7698-1-git-send-email-pdebie@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78071>

On Mon, Mar 24, 2008 at 4:11 PM, Pieter de Bie <pdebie@ai.rug.nl> wrote:
>  -'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
>  +'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<object>]

Note that you need to change also the corresponding string inside
builtin-tag.c , the lines printed when you run "git tag -h".

--
Carlos
