From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 00:46:45 -0500
Message-ID: <20100410054645.GA17711@progeny.tock>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 07:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TWf-00051f-0l
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab0DJFqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 01:46:20 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:33510 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab0DJFqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:46:19 -0400
Received: by gxk9 with SMTP id 9so2354306gxk.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 22:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xb3VLADMHjjkcWYL1apr7xecNRC3znaE0qEP+zsV0MA=;
        b=KX1eHa+p3MTYTHkqma7eOGmbjXiNWwLSzwOdEfvemXRsX60KZI8N4P9EUAfoVxAg/0
         Wz8l6lddpfYE7dm81rZrOV12w15Xjykd70QPcvkZsnfHCji8fGQvP9FhrVPRvy0ECIAt
         p48JBaE+TYaFPKmmZYQ73o1YI0FvfO6GK/9rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Pai3RXrjwQjvD2pdjfckUsrC3OQXR12ZZJm+YHGI+Z1NvlR2wMhqrol9IG5l8Ub8Il
         +hnYhhSEgiFEkw7nQ+wGASgUu6TCaV/mGFrUJ+1pTuvMzg2yMrR9ZRwGQbzyGfOWxWUH
         VeoxQBBvyyfgoTg2JLbPlMthoDO/UqYMftIC8=
Received: by 10.151.128.7 with SMTP id f7mr415202ybn.65.1270878378552;
        Fri, 09 Apr 2010 22:46:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1514692iwn.3.2010.04.09.22.46.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:46:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100410040959.GA11977@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144512>

Jeff King wrote:

> If you really want a list of ignored files, I think you are stuck
> comparing the output of "git ls-files -o" and "git ls-files -o
> --exclude-standard".

"git clean -n -d" may help.

Just my 2=A2,
Jonathan
