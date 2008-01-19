From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Sat, 19 Jan 2008 02:38:57 -0800
Message-ID: <402c10cd0801190238l6c8975bt34185d78536583e2@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
	 <402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
	 <7vodbibzch.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 11:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGB75-0001rq-Om
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 11:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYASKjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 05:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbYASKjE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 05:39:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:43908 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYASKjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 05:39:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1290294fga.17
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 02:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hunXz5BL7Fvyy/ms8Xojplbykzfid7o4nHQr2CEpnng=;
        b=Gt/mD8Vwabjybua4CngNnkelAEXbmJkGh046EhbA1i/g+H8yOuhpkca9GAUcpjy6D05JVXUukpJ3cc7a4fX/6VQnAMob1hJIy9ztXoDHhUWGgra8eyDbSrl3wAWqQgbW+7VbUITQ1Eap5h9clt92WshhXUohy1WAk0xkUa8AFiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=v+ZITn+L6UXf4ID2Sih+yV6gQrAtY0lSRfMRHGZUAcVvibEMXIpmydsTmyr2Eo+UOANn+fqIrG/AzafLxHG6E2w8M8saM94dqD7ypkDinnZi9mf81HG8WeSIJhnCmu2vygTwCGj1FhHRvHrhy6+xEyMkKRvlz1mflReMCT9abiU=
Received: by 10.82.182.1 with SMTP id e1mr3195305buf.27.1200739137979;
        Sat, 19 Jan 2008 02:38:57 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Sat, 19 Jan 2008 02:38:57 -0800 (PST)
In-Reply-To: <402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71095>

On Jan 19, 2008 2:28 AM, Sverre Hvammen Johansen <hvammen@gmail.com> wrote:
> I suggest we keep it simple and implement this new feature as a merge
> strategy and the commit reduction is only done for fast-forward.

s/fast-forward/single/

-- 
Sverre Hvammen Johansen
