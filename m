From: "Tony Stubbs" <antony.stubbs@gmail.com>
Subject: Re: git svn rebase - could not detach HEAD
Date: Fri, 8 Aug 2008 00:53:41 +1200
Message-ID: <f7d8f60b0808070553o6f709445j9dd036f380763f6e@mail.gmail.com>
References: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
	 <7vd4kljnpn.fsf@gitster.siamese.dyndns.org>
	 <f7d8f60b0808070033g7a322ee4w9147dd51e41850c6@mail.gmail.com>
	 <20080807074117.GA7648@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR50x-0001TU-HG
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbYHGMxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Aug 2008 08:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756393AbYHGMxo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:53:44 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:8504 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360AbYHGMxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2008 08:53:43 -0400
Received: by py-out-1112.google.com with SMTP id p76so255875pyb.10
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UACmlShPribgbMmHGtQbWN2wiB9bmP4ebsAfW3rzPoA=;
        b=m/qg88O9DjuhZW+PayCpPCuDm+YBMcExD5hOzYAEku8CUO1f4RM0hZy6tD8pYFzFke
         Qehn0ZglaNj0WfXBtByXPqnNijD+YMnosljb4sLstwJRUgByEiY98cysoV63HQ/WYnxa
         F8Tbmzckht6o+qaspPlF22PbjgTAsOXaSGuAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ym8hQZyt2iuUddRx+PhDTTKeTN3WNBOeQDbx5FIfxdf6QjyJZINoIDUYouulqRFOEk
         SWXD0Iun5aQFe1MXo+4oa96yESJQNNe2N5mCIUM4QfIaxsxpEDW8X1K9n18cQAT3sefl
         fVei2hJ5j98Ov3ou4q+RuhoyXa8ejmcdLqsfE=
Received: by 10.115.79.8 with SMTP id g8mr1246631wal.215.1218113621549;
        Thu, 07 Aug 2008 05:53:41 -0700 (PDT)
Received: by 10.114.157.2 with HTTP; Thu, 7 Aug 2008 05:53:41 -0700 (PDT)
In-Reply-To: <20080807074117.GA7648@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91578>

2008/8/7 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> that seems to have got it. so are you going to apply that patch to g=
it proper?
>
> It already is.

Great!

>> <manually deleted "untracked file" here>
>
> Maybe you're ignoring that file? git clean deletes ignored files only=
 if
> you use -x/-X.
>
> Bj=F6rn
>

That's probably it, I'll try it tomorrow. However, that could be a
problem. There's ignored files I don't want to keep (build artifacts),
and there's ignored files I do want to keep (i.e. .metadata).
Is there a good solution?

--=20
___________________________
http://stubbisms.wordpress.com/
