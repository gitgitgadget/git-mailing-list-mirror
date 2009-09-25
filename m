From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 15:04:15 +0100
Message-ID: <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 16:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrBPL-0006RQ-3D
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 16:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbZIYOEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 10:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZIYOEN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 10:04:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:39647 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbZIYOEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 10:04:12 -0400
Received: by ey-out-2122.google.com with SMTP id 4so108714eyf.5
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+dQbiUZxiJgnIhjPeNec2OOr8xmgjW3nO2QtZ6cDeuk=;
        b=RX2k0t1gBdSXTppJ3mqoIFubWL4saZU3T0HXPXO0PXpnxgDc+5vJy38G7R5L8ridfE
         sDWOrFj3f4dzP5qwD2Yh+o262d1/LN7kb6XRBVpxTvZ3xyqC2Qj+IWb6xQRi+YRKP3iR
         KlMNUyY9VgJRRV2FaAVQxoMunCZ80kiMxbNGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IavrNx5JPH0MQTzYgazG+do4j6yPDtvglWsFl0iatH4UJN/kC4qvzZgFaAuDfbkd9B
         dVaLtZTk39skXiZ7W8q4pdPrAouDXDwtU8Hgsm5I60VKUky96CjlSA+oSApoIcSgHLG9
         TJx29+8/kYTbEkp5iDRFbG9XQrvaMCOS/TPWw=
Received: by 10.216.2.213 with SMTP id 63mr35220wef.207.1253887455707; Fri, 25 
	Sep 2009 07:04:15 -0700 (PDT)
In-Reply-To: <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129085>

On Fri, Sep 25, 2009 at 12:30, Marco Costalba <mcostalba@gmail.com> wrote:
>
> So I am thinking to some setup somewhere that makes git to use
> abbreviated commits instead of full names. Does exist something like
> this ?
>

Here it is very strange. The problem is that git shell is no more case
sensitive.

I have tried git commit -F ...

and I got error:unkown switch 'f'


So somehow the problem is that all the commands are lowercased, and
this explains why pretty format %H is interpreted as %h so that sha
abbreviated form is used.

Now the question is: how to restore normal case sensitive command parsing ?

Thanks
Marco

P.S: Please, at least answer this last question ;-)
