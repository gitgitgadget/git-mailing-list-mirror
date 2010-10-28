From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] Change "tracking branch" to "remote-tracking
 branch"
Date: Thu, 28 Oct 2010 14:56:41 -0500
Message-ID: <20101028195641.GB16006@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYam-0004kN-6y
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0J1T4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 15:56:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34340 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab0J1T4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:56:48 -0400
Received: by fxm16 with SMTP id 16so2307846fxm.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n6Cv2OBv+REZMFFEmZ7Y6BV4rtemlSnIE79IPKBIegk=;
        b=bmybxi/6UraiiUownYKRY8TiGdtzjMc5sUCrJgYzce+4yxO3IZs72HLROl9xLtf6Re
         Qm0YPWVDE6GuWJ1FLGn9zATQvghixXlz2PxynGl1WvzwmQZqrB8yFFoJdk0VsEDL7XXi
         EE4IyktkHP23McwgIHJuIXTqq+A18ev7nHDG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q6rwo9RXdjSE5c70ruX24Iwl7/IsAYTM1A0ob3cPWRc2XS+kbLmJryxtVNb63ldMuy
         MNb3JmbWd41UPZn2rOPJswqmBzQkqSFwXKrsPTHtPdtbx1oGjexkrNGm9lUS3I2VLNpu
         RLHBkeR4Z7+20cWNqHl6Dq1NdaCpxef0a/uNc=
Received: by 10.223.116.9 with SMTP id k9mr4448161faq.124.1288295806879;
        Thu, 28 Oct 2010 12:56:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a10sm687645fak.27.2010.10.28.12.56.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 12:56:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-5-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160217>

Matthieu Moy wrote:

> One more step towards consistancy. We change the documentation and the C
> code in a single patch, since the only instances in the C code are in
> comment and usage strings.

For what it's worth:
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -349,6 +349,14 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	master branch head as to-upstream branch at $URL". See also
>  	linkgit:git-push[1].
>  
> +[[def_remote_tracking_branch]]remote-tracking branch::
> +	A regular git <<def_branch,branch>> that is used to follow changes from
> +	another <<def_repository,repository>>. A tracking
> +	branch should not contain direct modifications or have local commits
> +	made to it. A remote-tracking branch can usually be
> +	identified as the right-hand-side <<def_ref,ref>> in a Pull:
> +	<<def_refspec,refspec>>.
> +
>  [[def_repository]]repository::

In particular, your explanation for this hunk makes sense.  Any links
out in the world to "gitglossary.html#def_tracking_branch" would go to
the top of the page after this change.  Once there, the reader can
easily search for "tracking branch" to find the right entry.
