From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
	case
Date: Fri, 4 Sep 2009 10:04:46 +0100
Message-ID: <e2b179460909040204yb809738p54066430591d161b@mail.gmail.com>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjUj1-00013w-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 11:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbZIDJEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 05:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbZIDJEp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 05:04:45 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:42186 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbZIDJEo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 05:04:44 -0400
Received: by fxm17 with SMTP id 17so520357fxm.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jRDala8iAO89/z90AoY2MU4zohPucu7IDWS7sfgNx6g=;
        b=xzaZoRrAic/Q8neL7dpgWioah0Q93Le+qDXYtjxnzGAxYsIu1dX3WWKrHk8E9dP3ae
         Fal2OmHQks2HlSXBtBKS5i1vQjFtj51pAyHG/IdZBJ/NapyxD1XaWUzwGVy8qra2CxrE
         ZHXM1IISQL1ZsCIciN6XPA1PjmW6KKlAijIHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=omc+fqPJlGIUHW/a9qcdvB0AQjv9IVP6wL2Dg5JOPhTVYwEaFbLNuVb+UDJKAN9hx5
         tgfruIGl4aD1W+tetc/pcW5oPpB29nMbvOs59queZx/W/rs4I890k/DbiTEYzd+xnovc
         XpVSq97NOQ/rbdqm2Mf56m2rWnR1esYA4j3S8=
Received: by 10.223.54.15 with SMTP id o15mr4471823fag.96.1252055086452; Fri, 
	04 Sep 2009 02:04:46 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127698>

2009/9/4 Daniel Barkalow <barkalow@iabervon.org>:
> Instead of trying to make http://, https://, and ftp:// URLs
> indicative of some sort of pattern of transport helper usage, make
> them a special case which runs the "curl" helper, and leave the
> mechanism by which arbitrary helpers will be chosen entirely to futur=
e
> work.

> - =C2=A0 =C2=A0 =C2=A0 PROGRAMS +=3D git-remote-http$X $(CURL_SYNONYM=
S) git-http-fetch$X
> + =C2=A0 =C2=A0 =C2=A0 PROGRAMS +=3D git-remote-curl$X git-http-fetch=
$X

I think .gitignore would need to be updated again with the added and
removed executables?

Mike
