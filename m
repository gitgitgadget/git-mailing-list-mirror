From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 8 Feb 2007 08:25:20 +0100
Message-ID: <8aa486160702072325q1d63c5d2mc1c6a492392802c6@mail.gmail.com>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF3en-00020S-Gv
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbXBHHZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 02:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbXBHHZW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:25:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:28763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030661AbXBHHZW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 02:25:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so392205uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 23:25:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eYlC+5POq7TG2mUPguj25IBcoRlVdVqMBYSbQm2MTJXzTyLijxnZdTfyvdK/u5fxqpT9fgG1WfkkiIqSHytii3jT4BXgNU1+Xr3LdD+4xY+0gU/+EJLA043guO2+HlXm20IC/595vyoIuoxSC9i3hr2Gk4g2gtvb/q/68+nkgF4=
Received: by 10.78.192.20 with SMTP id p20mr371023huf.1170919520577;
        Wed, 07 Feb 2007 23:25:20 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 7 Feb 2007 23:25:20 -0800 (PST)
In-Reply-To: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39036>

On 2/8/07, Santi B=E9jar <sbejar@gmail.com> wrote:
> Hi *,
>
>   when a reflog entry do not have a reflog message the refs@{num}
> syntax gives a different result than with 'git log -g'. Actually 'git
> log -g' just skips this ref.
>

Also:

$ git log origin/master

works, but

$ git log -g origin/master

does not. You have to put the remotes prefix.

Santi
