From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull opinion
Date: Mon, 5 Nov 2007 23:16:06 -0500
Message-ID: <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	 <20071105234049.GA31277@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 05:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpFrU-0000PP-Mv
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 05:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbXKFEQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 23:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXKFEQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 23:16:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:53865 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbXKFEQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 23:16:08 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1573645nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 20:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nx9Jcyo1QrB6ms6afjsYwcQPDOBjLPj8lLh3TPkxoAs=;
        b=KpozOxe73zDE0rpQlfv9GdnnYsy6/ed3RPN3exn/3J6Q/wj76KWgppuwMYCUp2eTG+f2bzj05Z34MRuo6vq+35j9odVYENcf4A6u4OLbK9X0PWsXhCSAIdkGp/EWkA0E0zRSmhzXzzlJPEHCCg1GjhFXsTAHp7fPM0b3+kKWoPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qrJXTj6/Gks4Qnr5L9caLDadnl8oSb3y3ngM7h5AG/MQGiXTFlowAfBbGRrHokA0Cg4mYuvgU0SdnYNfm6Ynu48qBfIreGTaH9yXvwQnQosa03psg1kPL3grLsXkT7CpmhBYqcxeCXsg2rTrV6oszV1+2YPUhmlfnq/GGqKXUbk=
Received: by 10.78.149.15 with SMTP id w15mr4402155hud.1194322566613;
        Mon, 05 Nov 2007 20:16:06 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Mon, 5 Nov 2007 20:16:06 -0800 (PST)
In-Reply-To: <20071105234049.GA31277@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63622>

Hello,

> who will run git stash clear? :)

Yes you are right. By the way, in the context of merging into a
dirty tree, "git stash clear" seems to be a dangerous command:
there is a risk of loosing all your changes without a question
asked!

I know unix is a harsh world but ...

- Aghiles.
