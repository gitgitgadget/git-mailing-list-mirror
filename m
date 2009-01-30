From: Matt Graham <mdg149@gmail.com>
Subject: Re: gitk run from subdir and "find commit touching paths"
Date: Fri, 30 Jan 2009 00:56:22 -0500
Message-ID: <1c5969370901292156k2456b585r8e79889db516bc59@mail.gmail.com>
References: <slrngnug78.877.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 06:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSmNz-0001PP-Sd
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 06:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbZA3F40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 00:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbZA3F4Z
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 00:56:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:17100 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZA3F4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 00:56:25 -0500
Received: by fg-out-1718.google.com with SMTP id 13so211760fge.17
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 21:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lJExbWGos7FcvZBVuNUidSCBhQvAOKPFoNNqReGZ1SE=;
        b=asaNwFMnHPIpq8HWknKuTS+0N7Kob0a4rw4P4jasso3TY2At+Wzb/rjwxIhd2lE+9N
         gYF+SeBCfRhbYZ0K4GUKPxOqzLRJ/aHEQ4CzoMSNmshgbnb346oh+y4w1VogwA4OxrdL
         Wnu4NrqxRuJbf5ilaMhq1wJn8WHtSufcLJzHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UAWwExH+cSyLJmVrEe0Q+HM2LHPNYDEFD//qBO2bc1+dE6ctT+Vs2tAjmT3q8L5de2
         6iXksSF8zyQExuPvXB5PSTJvMmx8rNM5kgS3aWKcM/l224iVbnrYJL68QGT47rwJ0TJS
         fesUHHR/kdbVaM4f/Jgzoq8eGBDu5RhLP+cug=
Received: by 10.223.114.2 with SMTP id c2mr710955faq.85.1233294982931; Thu, 29 
	Jan 2009 21:56:22 -0800 (PST)
In-Reply-To: <slrngnug78.877.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107774>

On Tue, Jan 27, 2009 at 12:14, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> If I run gitk from a subdirectory, and then try to find a
> commit touching a path, it doesn't work.  No movement of
> cursor on "Next/Prev".
>
> Running from the main project directory makes it work ok --
> you can go "Next" or "Prev" finding other commits that
> touched the same path.
>
> Is this a known problem?  I couldn't find it in the mailing
> list archives.

Hi,
I get this too.  My repos are small enough that I'm usually able to
just cd to the root dir and rerun gitk.
