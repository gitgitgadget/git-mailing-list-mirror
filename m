From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport cannot handle zsh CVS repo
Date: Fri, 8 Jun 2007 07:19:14 +1200
Message-ID: <46a038f90706071219h35d776d2m15a9dcf7f9bc24aa@mail.gmail.com>
References: <20070607073336.26979.qmail@178148a41cee98.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, 426617@bugs.debian.org
X-From: git-owner@vger.kernel.org Thu Jun 07 21:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwNW3-0005W6-Km
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 21:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762068AbXFGTTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762152AbXFGTTQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 15:19:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:20784 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762068AbXFGTTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 15:19:15 -0400
Received: by wx-out-0506.google.com with SMTP id t15so505927wxc
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 12:19:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OWogAZysdNUAkjII/gwRVoxxZ9/P46WmOF4c6lGoAjNLoVkHZuOyrqTMOXt+ltfXhFNJY7DHmXCCSui9qhu4i+MF7Ko1pnc+aCbpjul0qmMSVveNrUwmI7k3uaFxmnGVgfJDCDM/ABO/XT7ncgvvLDsvaD1QuNQWgSfwvtfSkko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J3VfRPXvV6tibpeRXFn+b59Jew/Fn6GZ4nRLEiBIxF2V0NeNgkIByrDiwQHSVXNFVZrpXtEaPpn0TeIN2uxlt9aDRa3o/FAWkElYdrNY96PwpmMwpTUenlFyezabWzFOX8PgggexaA2nQBAf1RNypIno6l2evQ+/9wrKzU7mdGw=
Received: by 10.90.88.13 with SMTP id l13mr1998183agb.1181243954858;
        Thu, 07 Jun 2007 12:19:14 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Thu, 7 Jun 2007 12:19:14 -0700 (PDT)
In-Reply-To: <20070607073336.26979.qmail@178148a41cee98.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49380>

On 6/7/07, Gerrit Pape <pape@smarden.org> wrote:
> Hi, I'm stuck tracking down this issue, unfortunately reproducing it
> seems to take ages.  Any help would be appreciated.
>
> Please see http://bugs.debian.org/426617

This is probably a problem with cvsps output on that repo. If you run
cvsps against the cvs repo, what does its output look like around/past
patchset 6965

There's a number of things that can confuse cvsps, as the cvs repo
format is horrid.

cheers,


martin
