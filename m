From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-stash fails on OSX 10.5
Date: Mon, 13 Apr 2009 13:57:04 -0400
Message-ID: <76718490904131057k2801a62bn14825b055b345dfe@mail.gmail.com>
References: <be4ebbe10904100944p6ec2c0dao8607fcff75d2754e@mail.gmail.com>
	 <7vy6u8whbp.fsf@gitster.siamese.dyndns.org>
	 <be4ebbe10904101114w33c807d1je19b0c949e9a2009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jacob Kaplan-Moss <jacob@jacobian.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 19:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQQc-0004r0-CT
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbZDMR5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 13:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbZDMR5I
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 13:57:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:23601 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbZDMR5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 13:57:05 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2186241rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=laMG+xXoXLEmBZtDaJnLCVkDomb8TrmBHn2gjXmef24=;
        b=LAtydnB7Ur/BTKOz/LC0Ne1pdMzKVts5srva3cBhZoGyxtGzTdjMJ4C3qyc3eeVkcp
         5DisbadIyXMU3Uzbm5sR270Xf9DtSU3WoNJRxaa4zcPXWFRRSqHvahR/68dNIq2U4Ruz
         NUa9pJhc0KCti5X4PSidNWLEv7ivfOwXQFv1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nRIeATFvA64HBy1NWC5i1X/EBcTWw3W9tyBwYTxTYLst/jwj6SlpjNtQlBugrBaTli
         0Xq0SRnkX52J+HhEfufardN7fxtDUEk8GvDO6iYkZ24kA2I13zXAzfyva4IWHLtAQ1mD
         76cVSTORjbvNRKjWqihOw/C3IYo3RopXoY2sg=
Received: by 10.141.50.11 with SMTP id c11mr2848748rvk.45.1239645424808; Mon, 
	13 Apr 2009 10:57:04 -0700 (PDT)
In-Reply-To: <be4ebbe10904101114w33c807d1je19b0c949e9a2009@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116455>

On Fri, Apr 10, 2009 at 2:14 PM, Jacob Kaplan-Moss <jacob@jacobian.org> wrote:
> Sorry; I trimmed the error message to omit the details of where the
> repository is since this happens regardless of the repo. The error
> gives the full path to the file, i.e. "cp:
> `/Users/jacob/Projects/uri/.git/index': No such file or directory".

1) Does "ls -l /Users/jacob/Projects/uri/.git/index" work?
2) Does "cp -v /Users/jacob/Projects/uri/.git/index /tmp/" work?
3) Anything unusual for OS X? e.g., Are you using FileVault? Are you
using a filesystem other than case-insensitive HFS+? Is your cp
command something other than /bin/cp?

j.
