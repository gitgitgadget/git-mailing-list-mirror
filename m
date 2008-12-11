From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [RFC/PATCH] Add support for a pdf version of the user manual
Date: Wed, 10 Dec 2008 19:06:04 -0500
Message-ID: <ee2a733e0812101606m1c522541j9380b6f5d5dc7fc8@mail.gmail.com>
References: <1228949090-22475-1-git-send-email-vmiklos@frugalware.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZ5S-0004cd-H7
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYLKAGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYLKAGI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:06:08 -0500
Received: from mail-bw0-f13.google.com ([209.85.218.13]:33108 "EHLO
	mail-bw0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYLKAGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:06:07 -0500
Received: by bwz6 with SMTP id 6so1688282bwz.13
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jdG/jDi1IKjglyRC3lDO1MjNme7jyBRtN4IBc57ohzU=;
        b=EURKXBg/wD0iVOhFafvOU9zlAmviQdoP6/8AtyF0p3QbpMxRWMzqnMzkrjDSptPxWZ
         kF4Loz3vo83twhZS38lIFcnrRpN6FNROA6uTt5eJ8JdQJ46AwQP8Pac4RDMGI7mvRiF4
         S7Sz/t+4N5DNXTGuuoZUSxhHqVFC7i7p30YAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=YAJDOx0WID4L/rijAUQVqh7qAz3ZlXRgp7HAWheCxEVC/wE+j4LD6/a3Ca2CiqXr/n
         x4LNAWIJKsD9QnwcXO3quGz0WvAmYDrxwU5yKnQIH+xfyh/LAgbAGP6p+BzrldCrWnF9
         1/PGGD17M3dTJ0L5Fjw1cP/SDlE72FTLx6xNM=
Received: by 10.181.197.6 with SMTP id z6mr636181bkp.213.1228953964964;
        Wed, 10 Dec 2008 16:06:04 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Wed, 10 Dec 2008 16:06:04 -0800 (PST)
In-Reply-To: <1228949090-22475-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102747>

On 12/10/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Use dblatex in order to create a pdf version of the git user manual.  No
>  existing Makefile targets (including "all") are touched, so you need to
>  explicitly say
>
>  make pdf
>  sudo make install-pdf
>
>  to get user-manual.pdf created and installed.
>

Thanks a lot! Having manual in pdf forms rocks!
BTW, for those of us without dblatex, is it possible to have pdf
manual pregenerated the same way html and man pages are pregenerated
for official releases in the git repo?? I would love to have pdf (and
'info' for that matter) branch in addition to html and man branches.

--Leo--
