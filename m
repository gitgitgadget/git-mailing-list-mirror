From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Mon, 3 Sep 2007 09:34:32 +0100
Message-ID: <b0943d9e0709030134g6cf9f69ctc688c27dc705df9@mail.gmail.com>
References: <20070826202724.16265.85821.stgit@yoghurt>
	 <20070826203344.16265.66280.stgit@yoghurt>
	 <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com>
	 <20070829111102.GA29980@diana.vm.bytemark.co.uk>
	 <20070829171621.GA2214@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7OL-0003S1-72
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXICIee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 04:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXICIee
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:34:34 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:8678 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXICIed convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 04:34:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so907161rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 01:34:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r9QODf7qbrs6TZu6K4XHVrpquXdGvH2Ya6hxgx6QiclB+hqbesaq6EYh247lVktuNF+GkxjtKIcDQoaSGHIPFgSgsdLbRcmfIzJ2wlqdWlZUWoSzfB9UbJr7CkGiH/3tvuUbRynGfAxIpxPQ+W3GqVEO+pUK/6tKDwOYP3FoyWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EnNlYdT6W93j/zmGYBWPVQIBCh8g8OKlW9tTjtAJMiJAYymXYQopwpe5v72bVdOwIVq5GNFSHx9pWDN/VXPb8ewhJGcrJLBg5RZBC8eORvZBK0e+u147d7ACrq+Y3myXyCUvl1i6vS1KPe27V24/i3h04KSgCmdX+iwtwZ8UDOI=
Received: by 10.140.144.4 with SMTP id r4mr1857962rvd.1188808472787;
        Mon, 03 Sep 2007 01:34:32 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 3 Sep 2007 01:34:32 -0700 (PDT)
In-Reply-To: <20070829171621.GA2214@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57445>

On 29/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-08-29 13:11:02 +0200, Karl Hasselstr=F6m wrote:
>
> > On 2007-08-29 11:50:11 +0100, Catalin Marinas wrote:
> >
> > > Any objection to calling this variable STGIT_SUBPROCESS_LOG? We
> > > already have STGIT_DEBUG_LEVEL (used in stgit.main). I can do it
> > > in my tree before pushing as I already merged your branches.
> >
> > No, no objection at all. I was simply too lazy to actually check
> > what the existing naming convention was, and misremembered.
>
> You changed it in the code, but forgot to change it in the commit
> message. :-P

I changed it on my office PC and the locale setup breaks your name
encoding :-). I tried to avoid it.

--=20
Catalin
