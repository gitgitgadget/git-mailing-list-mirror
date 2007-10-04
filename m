From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: editing description of patch
Date: Thu, 4 Oct 2007 12:45:17 -0400
Message-ID: <9e4733910710040945l2335f3d7le6f45510640d3a6e@mail.gmail.com>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com>
	 <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com>
	 <20071004082624.GA17778@diana.vm.bytemark.co.uk>
	 <9e4733910710040616l5358099dj1b65b47cf94cf031@mail.gmail.com>
	 <20071004154836.GB21717@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTpJ-0006fp-IO
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758759AbXJDQpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758631AbXJDQpU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:45:20 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:61542 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521AbXJDQpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 12:45:19 -0400
Received: by nz-out-0506.google.com with SMTP id s18so212411nze
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Cm1uOZ2pLi6OwdQYN6+3yR1W4+ibicDyu9e3/MqDsi4=;
        b=OFZLT7VclmCYWwG25thtrvYfx4UJKNky/bgKkh5xl06FnzcrwthgefC4sfXhlgdGRMZdcRIH5l/pDtleCrCxllnlCaK/e+mS1yrwQTofLxnrvKUNQBOVCPp75JvL9IRwE5joYQl1Q75Vw0KupMxUPXMjgZ+9BIN+VFm2SWdS7ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ODfu9prmcDqM1IN/A2qM8TspVnXreC8gdWbC1teORGEPFonWGDfQxSalWreCWn5z1Jw6dVZ9KKPdj51w5ba1V28j5Gx/nGIOEZEi44nMNOGeM4xUb/TqTOPGJDpms7O+bA7/J41I3gqi4rjG2lIQ8ZvxSDIIl9RQUiy3UcnwGz8=
Received: by 10.115.108.1 with SMTP id k1mr5966264wam.1191516317406;
        Thu, 04 Oct 2007 09:45:17 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 4 Oct 2007 09:45:17 -0700 (PDT)
In-Reply-To: <20071004154836.GB21717@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59984>

On 10/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I've never thought of the patch names as anything that would make
> sense to export from a repository (like reflogs), so using the first
> line of the commit message for mail subject (like git does) always
> seemed like a no-brainer. But then I don't have any experience using
> quilt or any related tool.

Why are the patch name and the short description independent
variables? Wouldn't it make more sense to treat these as a single
unified item? If I rename the patch it would automatically edit the
first line of the description, etc...

When importing a patch from a saved email, stg should strip all the
email headers out of the description. I have to manually fix that up.

--=20
Jon Smirl
jonsmirl@gmail.com
