From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/2] Allow deletion of several patches at once
Date: Mon, 23 Oct 2006 12:57:03 +0100
Message-ID: <b0943d9e0610230457l2ff82a05pd9c7eddfcfac68f2@mail.gmail.com>
References: <20061022125337.15194.64831.stgit@localhost>
	 <20061022125816.15194.3341.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 13:57:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbyQY-0004de-Me
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 13:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWJWL5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 07:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJWL5H
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 07:57:07 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:47218 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932146AbWJWL5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 07:57:04 -0400
Received: by py-out-1112.google.com with SMTP id z74so148793pyg
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 04:57:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kUXUEqd42zI09fF49IJ+LoW/LG3sWW9tqqQC0hPF+MVYsHfzeRVBDa/I62bxBb1OeGr7OWChVke44yve2502HPq+SBYDTLutqFKfDi9djgWVTiJe/S1CHpd3VwpobJVXQ6Pk+VfUcYqSAY1TRSmBmsgtUrFDBD2/og2vJybT0Lc=
Received: by 10.35.113.12 with SMTP id q12mr6417749pym;
        Mon, 23 Oct 2006 04:57:03 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Mon, 23 Oct 2006 04:57:03 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20061022125816.15194.3341.stgit@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29829>

On 22/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> +    applied =3D {}
> +    unapplied =3D {}
> +    dontexist =3D {}
> +    for patch in args:

Any reason for not using the parse_patches() function in
stgit.command.common? It allows one to specify patch ranges like
patch1..patch2. Have a look at how it is used for the push or float
commands.

--=20
Catalin
