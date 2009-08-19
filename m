From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 15:25:22 +0700
Message-ID: <fcaeb9bf0908190125u3e1bcaaap27e72a5784f4f9db@mail.gmail.com>
References: <1250509342.2885.13.camel@cf-48> <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302> 
	<vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48> 
	<alpine.LFD.2.00.0908181246470.6044@xanadu.home> <m3fxbpneqe.fsf@localhost.localdomain> 
	<alpine.LFD.2.00.0908181537360.6044@xanadu.home> <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de> 
	<alpine.LFD.2.00.0908181936130.6044@xanadu.home> <alpine.DEB.1.00.0908190921360.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:26:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdgUX-0000kJ-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbZHSIZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 04:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbZHSIZn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:25:43 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:15601 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbZHSIZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 04:25:41 -0400
Received: by an-out-0708.google.com with SMTP id d40so3801844and.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qqLtnbaq9Cr/AirW6+Gff+97nOtMhInJq26nj41lmz4=;
        b=EMhzePXVvLuvf52cg3gpJf9CD55goWiOmohtQN2gU6yyv8B9bOU2AzLwslHXPSy+D/
         w7fJRXf4hheqPp+euS8O19iffDoD28Exak5/G783KDycjnQ7WqZ9B2COG1nSkLH5439U
         VxRzAQg1+vv0vXfGH2WA/Ss2DM/IiIhsBA7QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RCIOEDQJ0GQQTPyoAxwFPbxVCTj3OyQ+9itFr3F8MWhbmMc1zgE0uROJfFY5eR2rBr
         zVoI/CDv8rDJLGQ1RzwoJPuKbtCZoxhuTScyV0WJNMpxJDoSRpFssneneJ26XR0REEE7
         9iuxtObF9ydx2THkK4AWNDU5RojPKXDE0Uqsc=
Received: by 10.100.53.9 with SMTP id b9mr6673436ana.33.1250670342090; Wed, 19 
	Aug 2009 01:25:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908190921360.5594@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126518>

On Wed, Aug 19, 2009 at 2:35 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> But here comes an idea: together with Nguy=E8=A6=81's sparse series, =
it is

=46WIW, you can write "Nguyen" instead. It might save you one copy/past=
e
(I take it you don't have a Vietnamese IM ;-)

> conceivable that we support a shallow & narrow clone via the upload-p=
ack
> protocol (also making mithro happy). =C2=A0The problem with narrow cl=
ones was
> not the pack generation side, that is done by a rev-list that can be
> limited to certain paths. =C2=A0The problem was that we end up with m=
issing
> tree objects. =C2=A0However, if we can make a sparse checkout, we can=
 avoid
> the problem.

But then git-fsck, git-archive... will die?
--=20
Duy
