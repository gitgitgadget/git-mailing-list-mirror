From: Ben Bennett <benbennett@gmail.com>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 10:31:30 -0500
Message-ID: <970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	 <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	 <vpq1vlp962h.fsf@bauges.imag.fr>
	 <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 17:39:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msefy-0000QY-A6
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 17:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZI2Pb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 11:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZI2Pb2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 11:31:28 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:35544 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZI2Pb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 11:31:28 -0400
Received: by pxi32 with SMTP id 32so4425992pxi.4
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DXhvBZRvA3BmU1uMLySvChq04TH5utE+M96+ue02eeE=;
        b=aanDKOreY/k2ujAFy37M7vr/NeL5hAXC+KIX9y8vNJ/JGF5m+C87ORDfMAvCDZy7UB
         vPLCLLe96S235IHq0TnTANG7FV1j9iZvbZmMtqkM35cwXAzzT3Iy2gi1M/dxjndaiiYn
         6CIdoO8Q5yH5Queb3uo9uXcfTJ9Fs8FXDNiJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wRVAe1yCa01XLhOZaL9NcCzlFIZnA33yi7Hxyh/WELng8iM2QVMAJZ7C12Am1UKkNA
         zZUefv/B6O36qnqE2yK3sIE/Uw7meCDMMXqed6/EP91yiqyydmGhJlKQi/C2R/nKIPXx
         hBo53bn8tdxk3B2mzbYynXsHCRGaCFGVROYHw=
Received: by 10.141.45.1 with SMTP id x1mr260941rvj.141.1254238291023; Tue, 29 
	Sep 2009 08:31:31 -0700 (PDT)
In-Reply-To: <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129311>

I am attempting to do a https clone. The username is an email address
but when I do a clone here is what happens.

Here is what I get , I might be messing up the clone command . btw ,
if i leave switch it to ssh , yes it does resolve the url correctly.

git clone https://benjamin.j.bennett@fooserver.com@fooserver.com/git_repos/main-code.git/
test
Initialized empty Git repository in /home/benjamin/planning_workspace/test/.git/
Password:
error: Couldn't resolve host 'fooserver.com@fooserver.com' while
accessing https://benjamin.j.bennett@fooserver.com@myfooserver.com/git_repos/main-code.git//info/refs

On Tue, Sep 29, 2009 at 9:32 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Tue, Sep 29, 2009 at 16:30, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> The question is which @ is the login/server separator, and which one
>> is included in the login. A quick test with
>
> I think it only makes sense that this would work, since any @ can
> never be part of the server name (since it's not an allowed
> character), so I'm still curious why Ben wants to escape his @.
>
> --
> Cheers,
>
> Sverre Rabbelier
>
