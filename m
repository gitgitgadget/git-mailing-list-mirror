From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/10] xdl_merge(): add optional ancestor label to
 diff3-style output
Date: Mon, 15 Mar 2010 03:35:21 -0500
Message-ID: <20100315083521.GB10068@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
 <20100315074909.GA8824@progeny.tock>
 <7vzl2a0zud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:35:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5ll-0007Cb-8y
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759892Ab0COIfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 04:35:20 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:41564 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759885Ab0COIfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:35:19 -0400
Received: by gxk27 with SMTP id 27so405782gxk.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fAGLj4NpxDmBy4wJeoPlQ3dk9mlpBw5MjvutvtjaBag=;
        b=cGbdSIf+oI6dAusTCmO9AFbyieADNUqqdW7RS12NkD7wAxj3SQv/KK4+TEtMyAPsUO
         97g/iB1Pc5tpYkbl3Au7DKhZ2+9Mh3OQTX9PyPQtss0pu0taLWYgD7KEPOSCDAxgLJ4t
         frrdHvfhbv/3odI2Mpatfmv/mIal/BHJf7Ybg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w4JZ+Tk/yQn57KyJdm8Ynfbg0NbpNOsH95dxUqILOfGwU8BkiJEl5ZgZ1aAgegZBj7
         US16Nbg2hdR1J53g7q5E/qh3wn8PTWGzhMcrpoLMlfTABDNSCmBSyLi7AuRDDMGyjOud
         71+gWwpzY7y++Xs2/ygdDXidnpf02ybY+i6jk=
Received: by 10.101.154.17 with SMTP id g17mr1186361ano.48.1268642118863;
        Mon, 15 Mar 2010 01:35:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4037734iwn.5.2010.03.15.01.35.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:35:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzl2a0zud.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142192>

Junio C Hamano wrote:

> I think this patch itself makes sense, but if you were to add one name to
> xmparam structure, wouldn't it make sense to store all three names in
> there?

Good idea.  Will do.

Ciao,
Jonathan
