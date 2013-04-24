From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] git-diff.txt: document the .. and ... forms in
 SYNOPSIS
Date: Wed, 24 Apr 2013 12:03:17 -0700
Message-ID: <20130424190317.GD29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:03:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4yV-0000Sn-CV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975Ab3DXTDW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 15:03:22 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33064 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab3DXTDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:03:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so1376916pab.29
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=j9qgwifvrasOvjF72qSH02v/6oYerINfHP9GzrkXO/A=;
        b=Ja/CGY77mbRgoWCqc3jptsYwuXaFvPAXgf6NVLU9+htexnymogrepHW8sP98slH/ii
         gW19SAH4XgrqQ2gFKs1h2etLiO7R+QvdleTm1AMqQTvRLm8dVaplhDX1tYTzee3aLkam
         mQnEw6Q92zYOpJ6ixXmodPvK9LxyT6iEEQLSc+c9PdN1+V835Diyn461y5bGx+CH2qo2
         Ojj4l0K4LGvRlEJmUwfjVBTlrfte559vruRqiH+mS/WgJ5nuLkeCkCoaGlrAST/3db4V
         9qzgt7XSK30COUC/yseZqikAiA457pHnii2kbU7sWBHSbH01s9kv1vdeYRuC6rtTm9P8
         6KAQ==
X-Received: by 10.68.113.65 with SMTP id iw1mr48400983pbb.31.1366830201736;
        Wed, 24 Apr 2013 12:03:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id lo7sm4684616pab.19.2013.04.24.12.03.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 12:03:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366821216-20868-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222297>

Ramkumar Ramachandra wrote:

> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -13,6 +13,8 @@ SYNOPSIS
>  'git diff' [options] --cached [<commit>] [[--] [<path>...]]
>  'git diff' [options] <blob> <blob>
>  'git diff' [options] <commit> <commit> [[--] [<path>...]]
> +'git diff' [options] <commit>..<commit> [[--] [<path>...]]
> +'git diff' [options] <commit>\...<commit> [[--] [<path>...]]
>  'git diff' [options] [--no-index] [[--] <path> <path>]

This is preparation for removing <commit>..<commit> from the
documentation, right?  It makes sense to add the ...  form since
there's no other way to spell it but I can't say I'm excited about
adding the .. form.  Especially since <tree>..<tree> doesn't work,
that form's a little embarrassing. ;-)

*checks the manpage*

Ah, this is to make the SYNOPSIS a better table of contents for the
DESCRIPTION (except that the DESCRIPTION treats "git diff --no-index
<path> <path>" before "git diff [<commit>] -- <pathspec>" while the
SYNOPSIS doesn't).  Maybe it would make sense to go all the way and
make the two follow the same order?

My 2=A2,
Jonathan
