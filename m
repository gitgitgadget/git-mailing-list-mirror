From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH 2/2] pack documentation review updates
Date: Wed, 11 Nov 2009 11:05:14 +0100
Message-ID: <d411cc4a0911110205j6f3afedw57d2c56fb28dc20@mail.gmail.com>
References: <d411cc4a0911032158j2a4664e5w2601c4af59ba0837@mail.gmail.com>
	 <7v8welbl2p.fsf@alter.siamese.dyndns.org>
	 <20091111171924.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 11:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8A4o-000694-J9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 11:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbZKKKFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 05:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbZKKKFK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 05:05:10 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:55075 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZKKKFI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 05:05:08 -0500
Received: by pwi3 with SMTP id 3so597005pwi.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=unqOYXZMUZ6wGrpCWIottin4d8MAFXmlysNum4bRYYA=;
        b=dhkeuQyuWsRYYcjrXIpyag8KkRZUM0tqH2VAk6gU4A9Gj5RQPqQOPYF2I/pKZvz4KQ
         MhksQq1rYjsXfhgGa6EElS39cCmf3SOs2bXIl8uePanIXkowvowg9I9vtr1MMMbVgy9m
         9hbNgA5GLg8FFvx9PGpMNIcUAP0y6euaIHSHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=djkTMdsmAK8o4GxAIYyh8mJpPtA30yXZoftrr6FUostR8DTJRKjATHynLxlBZvSsqK
         1g7CIxKDZRb8kfJR0XHx3pAuwgVsz+oegumTIsYEcZwYf7UI/X5eACM5j9Z3OvRho3Fn
         esiArriAq2sNew5QOD2zi5+i7pITvVIQlrv2o=
Received: by 10.114.242.14 with SMTP id p14mr1906990wah.179.1257933914449; 
	Wed, 11 Nov 2009 02:05:14 -0800 (PST)
In-Reply-To: <20091111171924.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132635>

Hey,

On Wed, Nov 11, 2009 at 9:19 AM, Nanako Shiraishi <nanako3@lavabit.com>=
 wrote:
> Update Scott's protocol document according to review comments given b=
y Junio.
>
> =C2=A0* name of "%00" byte is NUL not null;
> =C2=A0* requestee sends current values of its refs, not "known values=
";
> =C2=A0* consistently use "obj-id";
> =C2=A0* requestor chooses the capabilities it wants to be in effect;
> =C2=A0* pack data is sent after negotiation finishes, not just after =
"some of
> =C2=A0 it is done";
> =C2=A0* what it has is called "its", not "it's";
> =C2=A0* consistently use "flush-pkt";
> =C2=A0* remove redundant "something like";
> =C2=A0* status report for send-pack is sent from the receiver, not fr=
om client;
> =C2=A0* don't unnecessarily say "SHOULD NOT" when existing servers ca=
n satisify
> =C2=A0 "MUST NOT";
> =C2=A0* only one thin pack is sent and thickened;
> =C2=A0* an all-zero value is defined as a zero-id, so use it.
>
> Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=
=E3=81=93 <nanako3@lavabit.com>
> ---

I was _just_ working on this yesterday and had gotten about halfway
through - I'm traveling a lot right now, so I'm a bit behind.  This
looks good, thanks for taking the time Nanako.

Signed-off-by: Scott Chacon <schacon@gmail.com>
