From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 23:44:14 -0400
Message-ID: <76718490903102044j4ca3462eye5ffcb178608dc29@mail.gmail.com>
References: <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	 <20090311020409.GA31365@coredump.intra.peff.net>
	 <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
	 <20090311030604.GA3044@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhFO5-0006YM-2R
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 04:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbZCKDoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 23:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZCKDoQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 23:44:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:64019 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZCKDoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 23:44:16 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2538354rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2aRRrscbvgv4JECKRfvtyQIdG9SI+IE7m2npPAdELeo=;
        b=vShgJOK5edoEf4evR/KO9kpO1DN5prAzk3Gbqzw7iqvA3hoGRaw0nhVSx9cJwCItSv
         oyO2nNzig+cLn+YK0CRaTgDlCCknlKrUsy8ZnMK4vqlRiIZwzvYfl33dJPCTmkP5wlrV
         hlX5EmN1ULNZB7wCpFhQuVDGsH345W487UAec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZIibGAgsNEDxq4wjNKZQWjruGwdl/be78VBMQhtZK/dc4pEMh41DCtH+NYkw+xxLOB
         NYNisuvrCESQubNSlEuDi1Io20SOlJUaGoHq7lIvzJi8f4DJiBGI9sH0zMlPxae/se3H
         lUl6lsLuAZLWzCAPE8fhMjNpqWKlAptecx0js=
Received: by 10.141.71.14 with SMTP id y14mr4123205rvk.202.1236743054158; Tue, 
	10 Mar 2009 20:44:14 -0700 (PDT)
In-Reply-To: <20090311030604.GA3044@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112875>

On Tue, Mar 10, 2009 at 11:06 PM, Jeff King <peff@peff.net> wrote:
>> No, look at how -m works. [<oldbranch>] <newbranch>. I modeled it after that.
>
> Hmm. I think of that as "make <newbranch>, move from <oldbranch> or
> HEAD".

Um, I think of it as "rename <oldbranch> to <newbranch>" where
<oldbranch> defaults to the current branch (aka HEAD).

> Just as regular branch is "make <newbranch>, start from
> <oldbranch> or HEAD". But your proposal is "update <newbranch> or HEAD,
> from <oldbranch>".

Wait, what? No it isn't. My proposal is add or remove tracking
information to <branch> where <branch> defaults to the current branch
(aka HEAD).

-u w/o --track/--no-track is a usage error.

j.
