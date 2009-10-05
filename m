From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 18:10:59 +0200
Message-ID: <6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com>
References: <4AC8F22F.5070101@gmail.com>
	 <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
	 <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
	 <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de>
	 <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 18:19:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuqEX-00056b-E3
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 18:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbZJEQLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 12:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbZJEQLh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 12:11:37 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:54319 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbZJEQLg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 12:11:36 -0400
Received: by bwz6 with SMTP id 6so2607154bwz.37
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RaVOVZ3GjIqxqhQfbA3CRj0+U22jeIUvHKNFp6w7OoM=;
        b=jWY7e6fVlleCWWQBGthTLV8xLLifKgE2nwM4t/IeXRwbstVEdz+oOSGALSVqxj5Eu1
         4p5+JPlL89XAHgLts9VC/0s8lPr437W0I+aZTKkUcBNyK8M88cwBXuyGR70n9uNpr1Cx
         xrtgqFfmVNvBqfJBwmRgl9AfiMocp1pUk8EjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hjqnR5rd300TKtiYM6E1e+/54EnGS22BYNlA8xiUvl2hWX52lkyKdaHCCPYOCt3EFy
         PV0U6bM7I9HbrPPf1dJc7+SuY2ZGrD17/ZrrWn0+TI+IuacaOWsiTI/2XBU3fSu9v1GM
         0+T2/jkIBQBeFOJcKeZeSOPuE7YTylZ2A1G68=
Received: by 10.204.33.193 with SMTP id i1mr4214289bkd.75.1254759059203; Mon, 
	05 Oct 2009 09:10:59 -0700 (PDT)
In-Reply-To: <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129570>

On Mon, Oct 5, 2009 at 11:39 AM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> 2009/10/5 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> My objection was that the "upcoming" (yeah, Sverre, I am imitating D=
uke
>> Nukem Forever here) "merge" command would clash with "msgedit", whic=
h was
>> why I suggested "rephrase" (but would be okay with "reword" Junio
>> mentions).
>
> I also dislike 'msgedit' because it's abbrev-ed, I would prefer
> "reword" for that reason.
>

Thanks for the comments. "reword" it will be then. I'll send a new patc=
h soon.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
