From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] split largest remaining scripts, gitk and gitweb
Date: Wed, 2 Feb 2011 00:20:28 +0100
Message-ID: <201102020020.30622.jnareb@gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <m38vxzaa03.fsf_-_@localhost.localdomain> <7vsjw7xuy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 00:20:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPWj-0004yV-06
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 00:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab1BAXUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 18:20:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34206 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1BAXUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 18:20:43 -0500
Received: by wwa36 with SMTP id 36so7631647wwa.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=29RzZeNkUg9ssnF0GjZGqA/9nxh1cDXtWxll8027Vbc=;
        b=Xv64PNVvr+76cUoeUDCAFDV7UHc+wTS9FY/Zp6TdYkaSGALDyDhxDFoJEkghDCyNya
         ByJiXvPnuD9a5tlg7NS5LlOLrw2ihiHinbJKtFDqEh2jvJZNzJIpDrtCRUChy51SPFmQ
         Uk21GFmcbNbrezB1/MsdOMUXlwKytDa3YKELs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LLpvkdaYNPdsot9Qo81ZmplD+XoPIw+0tnJKwa6WzeLrjdLYoUDWD6I8sdlTDgzNOq
         BVeoqLeujgGhzxdBVBVAtEvOPEt0yXDfPtJSYkgfAnOHNGnbevW9DYXNB19PJyskqwta
         vuGfYBeuS/8sPBy4u65NbTU1LpkvwZOtamLCs=
Received: by 10.227.141.67 with SMTP id l3mr8503746wbu.104.1296602441491;
        Tue, 01 Feb 2011 15:20:41 -0800 (PST)
Received: from [192.168.1.13] (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id o6sm4842715wbo.3.2011.02.01.15.20.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 15:20:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjw7xuy3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165878>

Dnia wtorek 1. lutego 2011 23:15, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > Two largest files in git repository are gitk and gitweb, see the
> > ...
> > What do you think?
>=20
> What does this have to do anything with 1.8.0?  Isn't this all intern=
al
> implementation that can be brought in without affecting end users?

In the case of gitk we have "prior art" i.e. git-gui, which got split.
In the case of gitweb I am not sure if there having multiple files to
install wouldn't be inconvenient for users (though with "install-gitweb=
"
target...)

Anyway, I have posted this in subthread of

  [1.8.0] reorganize the mess that the source tree has become

because it is also code reorganization.

--=20
Jakub Narebski
Poland
