From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Sun, 11 Oct 2009 17:27:29 -0500
Message-ID: <20091011222729.GA5114@progeny.tock>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 00:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx6pB-0001Mo-N7
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 00:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZJKWTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 18:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbZJKWTo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 18:19:44 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:36859 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZJKWTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 18:19:43 -0400
Received: by yxe26 with SMTP id 26so3063529yxe.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4I7Th9ZqBGO4UMzjA1oXWqqysmB9bXBy3ACPAe2AJyA=;
        b=KoDhNBK94utWmqWrIoKOfuF0DXe6rrmLv90MSibVYKiU2jBMd3qpp47WgvXhIRcXeG
         Uz+fSAES9VvgAx3Uv4llLNRnH8GSH+My7LDqqB5WGCgiaUmdNyltelfIHo0EAcYepFdN
         LGJ/GFaYyAaOZgrPqNsMJx820z4x7obzqkh/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rX6vKn7lOMaEhKT8+OAGM5JSv4Su8hFO61AUaVorNbHUyJlGE+FooeJjBRZSuyZNUX
         PsMcdOSryWyU02J95sfTFes/EdtINoxT+ZYc5OMB89wlAp6G9kPJDSJk8cjlM8OqEkrL
         wsNF2NbDyZdewkCkYvEdI6ZzZmBX+g9neYb8A=
Received: by 10.150.127.36 with SMTP id z36mr8782279ybc.326.1255299547537;
        Sun, 11 Oct 2009 15:19:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm2203295gxk.8.2009.10.11.15.19.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 15:19:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129963>

=46elipe Contreras wrote:
> So that users get to know how to configure git from the get-to with g=
ood
> practical example (color.ui =3D auto) that most people would probably=
 like
> anyway.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Good idea.  Some comments:

> +Git's configuration is distributed among different locations--this m=
anual will
> +only to deal with 'global' (for the user) and 'repository' variables=
, where
> +'repository' variables take precedence over 'global' ones.

What are these different locations you speak of?  If git=E2=80=99s conf=
iguration
is complicated to deal with, maybe that is something that could be
improved.

This is very early in the manual, where every word counts.  I am not
very good at wording and do not have any better suggestions, but would
it be possible to more efficiently convey this:

	Git reads its per-user configuration from ~/.gitignore.

	That file can also be manipulated with the "git config"
	command, which can be convenient in scripts or when using
	operating systems like Windows where it is not clear where
	the home directory is.

	For example, if your terminal supports it, you can tell Git
	to use color in the output for commands such as "git diff"
	with "git config --global color.ui auto".

	For more information and a list of possible settings, see
	git-config(1).

By the way, this reminds me that I am not sure git-config(1) conveys th=
e
list of configuration items in an ideal way.  It can be easy to dismiss
that page as plumbing documentation when seeing it for the first time.
Should we ship a sample .gitconfig with all items included and comments
describing them, or a separate gitconfig(5)?  Either would be easy to
generate from config.txt.

Thoughts?
Jonathan
