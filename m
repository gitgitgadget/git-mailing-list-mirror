From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 15:48:02 +1000
Message-ID: <ee77f5c20709062248oc346ea3p12a410d6d92babfb@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <1189004090.20311.12.camel@hinata.boston.redhat.com>
	 <vpq642pkoln.fsf@bauges.imag.fr>
	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
	 <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 07:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITWhO-0003T8-Uu
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 07:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbXIGFsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 01:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbXIGFsE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 01:48:04 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:7227 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbXIGFsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 01:48:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so343136rvb
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PFqtgDNzaSKrN3YUKBeuTM02gotsswfvU3A5ygliMR4=;
        b=bTxZx086LdCQJpuzSNXMx+v/njwYNLWBXKz/9mSZHlhb0gD51eVtCBOfSal1EIDeXccy++yJgPpSvNamZTHB0jbHA0aFNfrTw2XhrorOWFS59ZUIyNizYSUXFjoWp+n8CqV0W3fPr33dZDz4ROYfsfqBc7o07VEFqxO4RkIh+gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uahtSwtMCOO18cnmFGnJWQvtgtpXD3A9U0txxkLCL0yOKtJ9BgwoVS9x+cOM2mHf+lXzu9/wwmRmKXY1JciBW3h8wdCu+LzyZfw04IpCvsuYju7ZASWBlGGz3mtvRzAqm1QKGusFC41kZRgRLS2IEmz3wwav8Z21qGnYsmirldc=
Received: by 10.141.35.21 with SMTP id n21mr584008rvj.1189144082649;
        Thu, 06 Sep 2007 22:48:02 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Thu, 6 Sep 2007 22:48:02 -0700 (PDT)
In-Reply-To: <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57981>

On 07/09/07, Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> My goal is to *use* Git. When something does not work *for me* I want
> to be able to fix it (and contribute the fix) in *shortest time
> possible* and with *minimal efforts*. As for me it's a diversion from
> my main activities.
> The fact that Git is written in C does not really contribute to that goal.

That's just it -- Git's goal isn't to make it as easy as possible for
Git _users_ to fix it (thought that is a nice thing to have). Git's
goal is to be a very good, very fast SCM. Bugs should be found and
fixed, but that can most effectively be done by the people who are
already knowledgeable about Git's codebase (i.e. its developers), not
its users.


Dave.
