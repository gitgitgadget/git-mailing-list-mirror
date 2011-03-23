From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: git svn perl issues
Date: Wed, 23 Mar 2011 22:38:35 +0100
Message-ID: <AANLkTikowuFsXFwLL14oS0zzHh3RiHOrGTVHXgyy8dLw@mail.gmail.com>
References: <20110323085237.1a52ab7e@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 22:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2VlK-0000bb-In
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 22:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728Ab1CWVii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 17:38:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59770 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab1CWVig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 17:38:36 -0400
Received: by bwz15 with SMTP id 15so7038323bwz.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2s8KAqh0Zg3XiUDHa0Jw2g2CLXBaUmVed3EowISjbCQ=;
        b=QLEPV59l6n/JRF2T6pE4l3Rb7tdsvtdmzJ5Ig5uvgORqFAUQ9cTZkOvZJOJjhyheki
         7+hslGPzDdM0q9AqQLFrgHQHcYKni6pSU+Dn1DjZGVWgfXXtVwv2zf14BaDJYxgNLvnV
         aS5P7B4lF9ULJm5rKsgMwqSjE1Kx29kYBsKFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=md+0YxZZ7vJM3R9znjXpPOL4lun06l6EtJoJPrb7JdpKncHsikXmKqi119MLjzpTnn
         83p5WahPz7TDpQgWSx3FwCjMl8hnMTCm6SW4qAlmueaGR7oOPzYpOO/E/W92WhXn//um
         g/K8FUaT95QkLQwo0o0auPlGGdpAlL9FkbSjQ=
Received: by 10.204.126.148 with SMTP id c20mr6625477bks.87.1300916315146;
 Wed, 23 Mar 2011 14:38:35 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Wed, 23 Mar 2011 14:38:35 -0700 (PDT)
In-Reply-To: <20110323085237.1a52ab7e@nehalam>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169874>

On 23 March 2011 16:52, Stephen Hemminger <shemminger@vyatta.com> wrote:
> 1. The following needs to be fixed:
>
> $ git svn clone
> Use of uninitialized value $_[0] in substitution (s///) at /usr/share/perl/5.10.1/File/Basename.pm line 341.
> fileparse(): need a valid pathname at /usr/lib/git-core/git-svn line 403

While noisy and ugly, uninitialized warnings are usually pretty harmless...

> 2. The git-svn perl script does not follow Perl Best Practices.
> If you run the perlcritic script on it, all the following warnings/errors
> are generated:

Some of these are undoubtedly valid complaints, but the so called best
practices that the perl critic policies implement are, in my opinion,
not widely accepted as such by the perl community. At least not all of
them. I wouldn't go following them blindly - especially in working
production code...

/Lasse
