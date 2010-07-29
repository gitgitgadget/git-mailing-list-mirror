From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 13:22:01 -0500
Message-ID: <AANLkTikpLHdMzbpix8jnyS6YwSkgie=Ts44AJP5dA4=T@mail.gmail.com>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com> 
	<20100729021946.GG25268@spearce.org> <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com> 
	<C77AA970-4288-487F-9568-E86CF776FCED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bradley Wagner <bradley.wagner@hannonhill.com>,
	git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 20:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeXkR-0001tn-GB
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 20:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0G2SWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 14:22:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53552 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0G2SWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 14:22:21 -0400
Received: by gxk23 with SMTP id 23so239502gxk.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QULQmH4zFucxlyEX3ywVkCf5moFwsLXReim2cai9qPk=;
        b=OHKFAdpJhPm/F/A7WpM8mtt3975nuBiVZRPGEbtG1K21VgY9SalR2AULSqQa9J49ut
         UiLoGUIfu9WjPY06v+QPv14E7s3mG3akm7/99DlvGgYkaUYAruKM4TEzobESuUX9BrBU
         6fB7KC73oU4r+ENgqY2BDyaRISfCp/BgzkSnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mIk/frX9VcPd1VrsQAsKak9SaOAsq4rhtxAkT/WAVyOuyYI0DjKoNUtC2vBr8KWTVZ
         LxBcJl+zbUqfL3WIaTdUvANdglNZdW3AiwF3PeXQH7BVdMRDew7wHCt2Xnk5dB578OkG
         Hj9fVB+Etn9xFsKPBC5d/R6Py0ybUB9VAE2dg=
Received: by 10.150.175.17 with SMTP id x17mr1531546ybe.300.1280427741171; 
	Thu, 29 Jul 2010 11:22:21 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Thu, 29 Jul 2010 11:22:01 -0700 (PDT)
In-Reply-To: <C77AA970-4288-487F-9568-E86CF776FCED@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152192>

Heya,

On Thu, Jul 29, 2010 at 13:10, Joshua Juran <jjuran@gmail.com> wrote:
> How about if you had two (or more) components with a shared protocol,=
 and
> you updated each to speak a new (and incompatible) protocol. =C2=A0Th=
e changes to
> each component might be done in separate topic branches, but you'd wa=
nt to
> merge them all at once.
>
> $ git checkout master
> $ git merge client-v2 server-v2

Very nice example, but do we have it _documented_ anywhere? If not, it
would be great if you could add that somewhere :)

--=20
Cheers,

Sverre Rabbelier
