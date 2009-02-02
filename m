From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored 
	repository
Date: Mon, 2 Feb 2009 08:36:15 -0500
Message-ID: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com>
References: <76718490902010652w7a332550w5e0658a390c7dea9@mail.gmail.com>
	 <1233503309-40144-1-git-send-email-jaysoffian@gmail.com>
	 <20090202132909.GD8487@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 14:38:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTyzq-0002IK-A2
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbZBBNgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbZBBNgX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:36:23 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:30473 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZBBNgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:36:22 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1473709rvb.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 05:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L5bI7ryXplRXkOQZmFSKY/1XMxzuprlRfNYVMcs/eD0=;
        b=gkkQa6LsdBH/cm3eietbj2O/VIid6lZi+Q2rKTeqZFMSK8ZD8GpwkjFNRqi9vGdcPO
         LVQcRUgySuOdcn2CN0ea62qp1Ro3DWlFgkE+wCSSunxF0Fqym6zNihj23I1S5oFtZO/W
         1NkD63O85oMkTMLZMzjWNwXqKQg0x18X//FeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hzUMrsKTKehw2PbF9m5dYa1nct1xhgRmWR4GrC9b/rhe0t7c7ZdiiG0UekZHZ6stoj
         VCPp0DnC86z2Oxpbms80v6icfIIv7oOD3VSS2RjG6W4XIrmm4jrWSyFNd7/DLnAyOhuD
         tmgchM2B5z1PsYDYRK9quZOluu4hgCyk3SIHI=
Received: by 10.141.179.13 with SMTP id g13mr1751656rvp.74.1233581775861; Mon, 
	02 Feb 2009 05:36:15 -0800 (PST)
In-Reply-To: <20090202132909.GD8487@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108085>

On Mon, Feb 2, 2009 at 8:29 AM, Jeff King <peff@peff.net> wrote:
> In that case, your safety valve makes more
> sense.

Thank you for the review.

>>  builtin-remote.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> Tests?

Yep, will resend w/tests.

j.
