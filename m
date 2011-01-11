From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override
 committer information
Date: Tue, 11 Jan 2011 19:49:01 +0530
Message-ID: <20110111141857.GB21967@kytes>
References: <igadki$4tb$2@dough.gmane.org>
 <1294568989-5848-1-git-send-email-artagnon@gmail.com>
 <20110109172431.GA7718@burratino>
 <AANLkTi=t98=4p=R2DXeCJ0OVPey8EtTLxHQ=3KfqrQpE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 15:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcf3V-0004Lu-QN
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 15:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab1AKOS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 09:18:28 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39336 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab1AKOS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 09:18:27 -0500
Received: by gwj20 with SMTP id 20so8939530gwj.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E8WujXP2dfD4bUqItodbPRFfh5ckXZLxC7NLNLCvTbg=;
        b=aIDXiK3MKtKX65RAFxoUQlXZCok79cIGgfs/7ZGiEX3B3Iu/5qzkGHXU/0LziKx2f6
         M0pU87/mRc1tZQUppG8paKB4Z+/JMSsyuHW2NxwVNpe72BpmGz9HrryLoA1QC8SlvTrQ
         lT1yCfdDI0ChUhArz/vGvt8jIsiDTIrkJChvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZQvWarMwVAEFOsmNiZjAtL26w13+DS95fAGZF+s7Si14hlsrFB29awa/yVH+h04FOW
         Lp4O6qERQr5ndYg1w6pD5eHISj0suCLXK4Eh35BM4YkDq5ap8jUs09Fn04sdGKOasXL9
         OhlmspWcyfYgjZ2fJUq6nDS+zuLwN1nko2eiY=
Received: by 10.151.109.8 with SMTP id l8mr210344ybm.46.1294755506237;
        Tue, 11 Jan 2011 06:18:26 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v4sm2949157ybe.17.2011.01.11.06.18.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 06:18:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=t98=4p=R2DXeCJ0OVPey8EtTLxHQ=3KfqrQpE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164948>

Hi,

Stephen Kelly writes:
> On Sun, Jan 9, 2011 at 6:24 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> > Ramkumar Ramachandra wrote:
> >
> >> The 'user.name' and 'user.email' configuration
> >> options set both author and committer information. To solve this,
> >> introduce 'user.committername' and 'user.committeremail' configura=
tion
> >> options to override committer name and email respectively.
> >
> > Predictably, I don't like this idea at all. =A0How would we explain=
 this
> > to a new user that is reading over gitconfig(5) for the first time?
> > It makes the semantics of the committer and author name (that are m=
ostly
> > meant for giving credit and a contact address) much more murky.
>=20
> It's like the difference between who are you, and what is your log-in
> identity on remote service X.

This feature should not be widely advertised- while it can confuse
many new users, I think it's useful to have in some scenarios like
this one.

-- Ram
