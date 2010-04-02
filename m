From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Fri, 2 Apr 2010 17:12:44 +0200
Message-ID: <h2md2d39d861004020812t8463e4f8zbc825bd220fef961@mail.gmail.com>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
	 <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
	 <u2ld2d39d861004020707m7577182et40b4cd6b93bae830@mail.gmail.com>
	 <RWfCNK1AsUFfin9YdRY1QqUtD-ISnv9hImfDeE0DFlh3_fRWdvEF2w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Apr 02 17:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxiYW-0004tJ-NI
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 17:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab0DBPMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 11:12:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:24517 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0DBPMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 11:12:49 -0400
Received: by fg-out-1718.google.com with SMTP id l26so669338fgb.1
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+S0saU9ZKnFLA3EajIJJ56VCntbnAzJ9RZsgBd2MBHU=;
        b=wTG3y5kuKUdz9UkH1KNr2+17LURTBMvYCo3y09uVuSNUcD451EasRxRk4+ZsOGAQ5x
         mlTDxE6Foho9GBefb8POLSNZmRbk8HZWtNVWihqDu2qOGSrrDGEeJ7AULCqKONk4r1Uf
         AEJCd2WlxnCx1sJ3yDmc9JdVPBuGZHFKlfvu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=XmQCHjTHkHHwTn3oVbikaOUUukhrJSLw9luvmVjelVFMdbjK2lDSXuaIIWyVHDiI84
         BL40O6ui+LS/QzCgV4AL5ZoWV9LgiZNGxQGCjA0kYhPgcp8ZFO7eiLSddjvlnGGxikf9
         pbgD0hcITtL5KkvcedoVqL3eDfYTtn08+2dmA=
Received: by 10.239.138.80 with HTTP; Fri, 2 Apr 2010 08:12:44 -0700 (PDT)
In-Reply-To: <RWfCNK1AsUFfin9YdRY1QqUtD-ISnv9hImfDeE0DFlh3_fRWdvEF2w@cipher.nrlssc.navy.mil>
X-Google-Sender-Auth: d52088ba048c6c00
Received: by 10.239.187.131 with SMTP id l3mr174615hbh.104.1270221164188; Fri, 
	02 Apr 2010 08:12:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143819>

On Fri, Apr 2, 2010 at 16:56, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:

> Here's another snippet which will show whether $? has the correct
> value inside a trap on EXIT:
>
> =A0 (atrap () { exit $?; }
> =A0 =A0trap atrap EXIT
> =A0 =A0exit 1) && echo 'FAILURE' || echo 'SUCCESS'
>
> If that prints 'FAILURE', then you will need the patch that I have in
> order to run the test suite. =A0ksh from IRIX 6.5 and Solaris both fa=
il.

It's 'FAILURE' on Tru64 V5.1. I've confirmed 'FAILURE' on IRIX 6.5.30
and older too, as well as IRIX 6.2 and Solaris 10. And AIX 5.1 plus
AIX 6.2. in fact I've only got 'SUCCESS' on Linux (pdksh)...

> -brandon

-Tor
