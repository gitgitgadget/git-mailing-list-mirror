From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to rebase backwards
Date: Fri, 6 Nov 2009 09:43:16 +0800
Message-ID: <20091106014316.GC3928@debian.b2j>
References: <20091103054510.GB7117@debian.b2j>
 <7vocnkt5o4.fsf@alter.siamese.dyndns.org>
 <20091103093716.GD7117@debian.b2j>
 <877hu4zsyq.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: David@vger.kernel.org,
	=?iso-8859-1?Q?K=E5gedal_=3Cdavidk=40lysator=2Eliu=2Ese=3E?=@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 02:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6DrO-0004S0-8A
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 02:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795AbZKFBnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 20:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbZKFBnT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 20:43:19 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41107 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672AbZKFBnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 20:43:18 -0500
Received: by yxe17 with SMTP id 17so542921yxe.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 17:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vwnWIGohxBvyM8R1xgzA8oVtU7P1zOusfB59FetGaxM=;
        b=K1DZIsoumzzX1VDhBifwB6TatIXdqOZ1QHLJHS1FtbfANFrVL7dtQQQr+6Vo0TrNLq
         joMnh4WJ2O/b2aPgFxvicGIVpqQwrtDJquTFwRvIwbE1ATooju6pmUKCI7ZdZzXnIjym
         0DNKDcgrhi82BvTwizgOlmnUKnrDtcQuJAOaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jftua0ue3dLM/w5hQGy43wnaurS75kN4vu4xc+5r7mZhTcjdqpvqTLTHkN7Bv01qtD
         xO5sfoal9A5LApvKtgj6ywX5b+pfDhjBfKXcfzMadWpughu9If8ljXtgldloH0CDWVsP
         Divof3Yg0fK+OWmt0H2DSMA9vqVHMbHRGAQIo=
Received: by 10.101.200.37 with SMTP id c37mr3648870anq.10.1257471803814;
        Thu, 05 Nov 2009 17:43:23 -0800 (PST)
Received: from localhost (n219079100195.netvigator.com [219.79.100.195])
        by mx.google.com with ESMTPS id 7sm1201546yxg.50.2009.11.05.17.43.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 17:43:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <877hu4zsyq.fsf@lysator.liu.se>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132266>

On Thu, 05 Nov 2009, David K=E5gedal wrote:
> command. For instance git log --graph master...deply whill show you b=
oth
> branches, starting from their common ancestor. "git merge-base deploy
> master" will tell you that the common ancestor is. Etc.

David, thank you for this info.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
