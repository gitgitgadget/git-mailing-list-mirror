From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 11:47:39 -0700
Message-ID: <fabb9a1e0910291147o78fef01g3f91f4a9e85cacc9@mail.gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> 
	<1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org> 
	<fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com> 
	<20091029155607.GA10505@spearce.org> <fabb9a1e0910290932u45c9c416m4d0ba0a8b2f5b01d@mail.gmail.com> 
	<alpine.LNX.2.00.0910291311570.14365@iabervon.org> <fabb9a1e0910291039u3c9d7eb6qe36e25ea76cdddc9@mail.gmail.com> 
	<alpine.LNX.2.00.0910291435180.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:48:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3a2a-0000Ll-8V
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbZJ2Sr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755495AbZJ2Sr4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:47:56 -0400
Received: from mail-ew0-f209.google.com ([209.85.219.209]:52314 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbZJ2Srz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:47:55 -0400
Received: by ewy5 with SMTP id 5so305352ewy.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=NLDPZ2Pw1dcvvz/rbEd6d7CfG2yBxXPLMeY2lojHLUw=;
        b=rIR22DYXRVdwEctUhLDSTa+cE5GRhlR4b1XCQqNa5IWWj7i4gV37CqhVrkvrdde4gE
         O2oCnF7t3eh1fi/HMILUeyn/iQ/nudq59RgrvxBMZ/NCpmyhDuz3qdX3HzoBTgLowd59
         ZJH62/t+ZcZxbS9YyyYZww+ZPN9V0xpg0z5YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CzYP9cDK+Dq/K90zXQBy4W7CSbZEBhAGVYgZprLnlYs8j4mlmG0I/UBwLdfjduRlDD
         VJOA4WcR0dVe8iGlQ6McYcADu/50fi67TTPjMLa+gVcZFakbAhOKpgu61sIM5y2gM0l8
         ECkuDX2BCg2AZOB7qx7hVM+SBZ2fAO7rIJz9M=
Received: by 10.216.89.193 with SMTP id c43mr150724wef.221.1256842079152; Thu, 
	29 Oct 2009 11:47:59 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910291435180.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131645>

Heya,

On Thu, Oct 29, 2009 at 11:43, Daniel Barkalow <barkalow@iabervon.org> wrote:
> It probably shouldn't. Actually, I bet Nico's clone will get extremely
> confused if the remote's HEAD isn't the same as any of its branches. I'll
> try to take a look tonight.
>
> I'll look over it later, thanks.

Thanks!

-- 
Cheers,

Sverre Rabbelier
