From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Copying files and keeping the history
Date: Thu, 11 Jun 2009 23:44:15 -0400
Message-ID: <32541b130906112044m7cf2c0e9s2ba4815a31e534a@mail.gmail.com>
References: <18567.1244726405@zev.se.axis.com> <fabb9a1e0906111129x53a6d90p15a97d958a2d2f63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?J=F6rgenH=E4gg?= <jorgen.hagg@axis.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 05:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MExh7-00052P-BE
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 05:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZFLDof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 23:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZFLDoe
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 23:44:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:11741 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZFLDod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2009 23:44:33 -0400
Received: by rv-out-0506.google.com with SMTP id f9so570247rvb.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=f747xwTd5TxG8MOvsKVxTx0TbkWga4MLO84PhURKGRM=;
        b=Cme5eoJJLBN3TsW2vPLBne4xzgtrblmAplWsdM3IQawdihrTif4LOc6UIOlYqhOwuU
         Ed43OMSJSDB7ze4Cc/JnY52P61i9rFkMyJsgF+JpcQiN5kiuCEnC81pweRT7BW5fJrB2
         2ebGdJEqVGuYr6M519DI6/YSS7d9zf8d8NpVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iGrF3BSSEbwsiVe2FTLrVk2DC49kl0v7Vly6DE7L/8UHweTrbu+L2bVkGlMnWi6s+d
         UDxeDgdiB346hhtLSJGPKvy5DHYPBAsaeKiV6+esvDa2JsC77RCeQI3nE+HD5xg7rkEK
         7x7GbcvFLErB0O2ga9esn3fehmDTF3HW5xJ0k=
Received: by 10.140.164.1 with SMTP id m1mr2518931rve.39.1244778275053; Thu, 
	11 Jun 2009 20:44:35 -0700 (PDT)
In-Reply-To: <fabb9a1e0906111129x53a6d90p15a97d958a2d2f63@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121386>

On Thu, Jun 11, 2009 at 2:29 PM, Sverre Rabbelier<srabbelier@gmail.com>=
 wrote:
> On Thu, Jun 11, 2009 at 15:20, J=F6rgenH=E4gg<jorgen.hagg@axis.com> w=
rote:
>> Is this somehow possible?
>
> Try git filter-branch to get just the commits you want and nudge them
> to contain what you want (do this in a seperate branch/copy of
> repository A). When you're done, pull the branch into B and merge it.
> Instant win?

You could also consider 'git subtree'
(http://github.com/apenwarr/git-subtree) to merge the other tree
(including its history) in as a subdirectory.

Avery
