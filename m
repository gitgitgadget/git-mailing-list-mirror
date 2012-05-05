From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat, 5 May 2012 11:47:36 -0500
Message-ID: <20120505164736.GC14684@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
 <20120505155423.GA14684@burratino>
 <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQi9P-0002oE-6q
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 18:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab2EEQr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 12:47:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41311 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab2EEQrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 12:47:42 -0400
Received: by yenm10 with SMTP id m10so3027847yen.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UUOg4qWSdJfHYGStuB4FpbmwO7SfQDZ2/bLKJ/7BzhY=;
        b=pTDmei6Iqm4ya5pHD6pYOfABFtdlWf47FTkSG/v88BSp37FqKPb+8WqzpWlsz5v73H
         gC5F4HhdCniONOco+dhGgeQIbtKvp+dxEUfo407zbweuHKrFNv7Z+viCVrC3O69anntj
         NevScGzbHg/4APRSeGsKygHX75bwif+WGELTv4r606kwk9amU39x0AOFCh9w7yzx9VnB
         jQFOX3KAOSwdykrpmcoq5A91FfcjVbF+Fct+S958sSUsiSaJ6v7PZvm+vNnJKBeKuzlg
         3LVgSphV0E5wZuI2hlq/FHIxtFA8rrehLu/Myqvc2GOsxwQDZhZz/nmRsv2D5pLUenVi
         Kuqw==
Received: by 10.43.49.201 with SMTP id vb9mr1141832icb.35.1336236461920;
        Sat, 05 May 2012 09:47:41 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xf6sm3407716igb.13.2012.05.05.09.47.40
        (version=SSLv3 cipher=OTHER);
        Sat, 05 May 2012 09:47:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197124>

=46elipe Contreras wrote:
> On Sat, May 5, 2012 at 5:54 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:

>> Following a convention similar to the bash-completion project's
>> proposed future convention doesn't really help compatibility. =C2=A0=
If we
>> want to be able to include this function in that project without
>> change some day, we'd have to call it _BC_git_complete. :)
>
> No, that's for bash-completion's functions, this is a git bash
> completion function.

Please read again.  "If we want to be able to include this ...".  I
assume we do not, but that would be the reason to follow their
convention to the letter.

[...]
> But wasn't you the one that suggested we follow the bash-completion's
> guidelines, or that was only when the guidelines happened to match
> your preference?

Sorry for the lack of clarity before.  I like to hope that "Because
Jonathan said so" is _never_ the only justification for putting up
with a technical change you disagree with.  In this instance, my
personal justification was "Because our completion scripts are already
using this convention, which happens to come from bash-completion's
guidelines and here are the reasons behind those".

Also, I think you have misunderstood me.  I was asking G=C3=A1bor for i=
nput
because you were proposing changing a convention and I thought G=C3=A1b=
or
had been maintaining the completion scripts.  I was not trying to say
"Please don't do this".

I was not inviting you to argue with me.

Kind regards,
Jonathan
