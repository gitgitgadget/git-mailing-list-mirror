From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] var doc: default editor and pager are configurable
 at build time
Date: Sat, 31 Mar 2012 05:51:06 -0500
Message-ID: <20120331105106.GA12552@burratino>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
 <20120331084015.GC4119@burratino>
 <20120331084234.GD4119@burratino>
 <4f76de0e.2ac7b60a.54ce.ffffd85eSMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Rodrigo Silva <rodrigosilva@rodrigosilva.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 12:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDvtw-0006jA-If
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 12:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab2CaKvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 06:51:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53613 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab2CaKvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 06:51:14 -0400
Received: by iagz16 with SMTP id z16so2037269iag.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6RA8c2jWGtkGGwFqwW9Zkz9MtjowHX/gC0h9dSb5ipY=;
        b=mIPJ2Si6R7nxOjAYQ+wMXyduIsk343DG67ZUY46ecHii8lOFhpPVgU+H9N682rQSG+
         XWzxIv+37KYlhzKZMWLWDZJgrngGp7yRFu7yabxPhKDj9bEffHfK6nptM8Zub30e1wlh
         VmMsDCz29WuA7znaTDN0uK3w/YhuT/qaGo4yBq5aHT8JGMnPcfKVydXUdWaXIyYgnUvC
         VNDhWt7DQOd6tEXS2VejTGitV59RsuS6cDS3WcsZt8MK6MqSbawxSRN+0WA1/EHsuoEe
         sYRDxkloRl5NB8H+B4DdlSP5SjAaeVJ3DdqqzL4RzHvPRmLEC+fpuwCs5PKfrkdB0xrH
         3WpQ==
Received: by 10.50.42.136 with SMTP id o8mr1163905igl.50.1333191074152;
        Sat, 31 Mar 2012 03:51:14 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k8sm5165845igz.4.2012.03.31.03.51.13
        (version=SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 03:51:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4f76de0e.2ac7b60a.54ce.ffffd85eSMTPIN_ADDED@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194447>

Hi Rodrigo,

Rodrigo Silva wrote:
 
>> Unfortunately those compile-time settings do not affect the
>> documentation, so the uninitiated user who tries to understand git by
>> reading the git-var(1) manpage can easily be confused when git falls
>> back to 'nano' and 'more' instead of 'vi' and 'less'.  Even if the
>> distributor patches the distributed docs to reflect the new default,
>> the user may read the official documentation from the git-htmldocs
>> repository online and be confused in the same way.
>
> I'm sorry, but I disagree with this approach. There is no "usually":
> upstream sources are *always* 'vi', and Debian packages are *always*
> 'editor'.

I disagree.  If I build the pristine source from Junio with
"./configure --with-shell=my-favorite-shell", I still have built the
pristine source from Junio.

[...]
> Upstream git /could/ say "... and finally, a hardcoded editor chosen
> at compile time, by default 'vi'"

It is not hardcoded.

[...]
> IMHO, only saying that "it can be customized", "it is usually 'vi'",
> without saying it /was/ customized and it /isn't/ vi, but editor, is
> not a good approach.

Ah, perhaps that is the source of misunderstanding.  This is a
two-patch series.  The two patches are meant to go together.  Does
that help?

Sorry for the lack of clarity,
Jonathan
