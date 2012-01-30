From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Sun, 29 Jan 2012 20:50:15 -0600
Message-ID: <20120130025014.GA15944@burratino>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 03:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrhLW-0003mH-0e
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 03:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab2A3CuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 21:50:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62479 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab2A3CuX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 21:50:23 -0500
Received: by yenm6 with SMTP id m6so1566055yen.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 18:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jk9c15te9WXCu5Oba5kJ46E8i08bkuSAlaq6rNmljEw=;
        b=SB7Qch7bx7g1ELafPVUUycgYV0D7VaTLW3SjjZbiKhsx6zRic6OIyexcPqNYMN2/wf
         b/XdTXwK+gtg5X7Ee0Tdg06eCHnad/ROe+dJNsxnkOa1h+BObwhiGesC0qjrviGNYKbX
         IaFdFl0DoceBMqwV1k6r8YT9H3W24IoTwFW3w=
Received: by 10.236.133.210 with SMTP id q58mr928569yhi.6.1327891822939;
        Sun, 29 Jan 2012 18:50:22 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s7sm42338702anc.4.2012.01.29.18.50.21
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 18:50:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189315>

=46elipe Contreras wrote:

> No need for thus rather complicated piece of code :)
[...]
>  contrib/completion/git-completion.bash |   30 ----------------------=
--------
>  1 files changed, 0 insertions(+), 30 deletions(-)
[...]
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2730,33 +2730,3 @@ if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; t=
hen
[...]
> -if [[ -n ${ZSH_VERSION-} ]]; then
> -	__git_shopt () {
[...]
> -else
> -	__git_shopt () {
> -		shopt "$@"
> -	}
> -fi

What codebase does this apply to?  My copy of git-completion.bash
contains a number of calls to __git_shopt, which will fail after this
change.

By the way, is there any reason you did not cc this series to G=C3=A1bo=
r or
others who also know the completion code well?  The patches are not
marked with RFC/ so I assume they are intended for direct application,
which seems somewhat odd to me.

Thanks and hope that helps,
Jonathan
