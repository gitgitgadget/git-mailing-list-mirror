From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 14:34:28 -0500
Message-ID: <20100724193428.GA4491@burratino>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <20100724110239.GA13067@vidovic>
 <20100724125408.GA17481@burratino>
 <AANLkTi=R2-=TNXyFq4OCo6LsYOMNgVga+=6QrAfCoHRx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 21:35:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OckVW-000411-GO
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 21:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278Ab0GXTfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 15:35:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40179 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab0GXTfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 15:35:32 -0400
Received: by iwn7 with SMTP id 7so1413147iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/TzRrSQBXmfeKOM8YY7HExaxjGfbqMun4e5GYwD/Sdw=;
        b=EMTRhrRPXt5Sk3Z9kEqauTdh4rJtTVIldWolfZgZcfSgMxrpnMYHCmf7Tm3P3PcJJ4
         DSrpBnjcUmO3VXXfO5n+DOdWBfJ8TV8uvotu2bG/cxApdcTEj9Qgyc4BaRInH55S66kL
         atDgFoYUvJO/PBFrlR85OnKNp/bpoIqGROPFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RYSHRei0L3wk/PU8nveVhI1F2h7RoFNJHzHONWi4FH06aPdf64jN6Cb9oBW80okp/m
         qWMvJSZV0WgUybZ7xuy3FVhTPJLEPkMxZMNmhcWr3/UCp5yBxvzMQZT2xDSZI/4KT9bD
         uGUjlZWLOf2o0mj9hSIyWvxyrXqmoqYW0Y20w=
Received: by 10.231.183.81 with SMTP id cf17mr3280627ibb.32.1280000131644;
        Sat, 24 Jul 2010 12:35:31 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm1643976ibb.20.2010.07.24.12.35.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 12:35:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=R2-=TNXyFq4OCo6LsYOMNgVga+=6QrAfCoHRx@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151664>

Avery Pennarun wrote:
> On Sat, Jul 24, 2010 at 8:54 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =A0$ git log --oneline -SListbox.font -- gitk-git/gitk
>> =A0$ git log --oneline --follow -SListbox.font -- gitk-git/gitk
>> =A062ba514 Move gitk to its own subdirectory
>> =A0$ git log --oneline -SListbox.font -- gitk-git/gitk gitk
>> =A0207ad7b gitk: Set the font for all listbox widgets
>> =A0$
>
> This is a bug in git log --follow

The first one is not.

> FWIW, I previously tracked the bug down to the fact that it doesn't
> track file renames that happen during a merge commit, which is what
> subtree merge produces.  I don't have the time or knowledge required
> to fix it.

Another pointer for interested people:

  http://thread.gmane.org/gmane.comp.version-control.git/150727/focus=3D=
150796

I prefer to work without --follow, anyway. :)

Hope that helps,
Jonathan
