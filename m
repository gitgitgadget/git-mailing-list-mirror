From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 16:21:04 +0200
Message-ID: <8aa486160805270721q64dff3f0gfbb9eb5384db027d@mail.gmail.com>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
	 <alpine.DEB.1.00.0805271151430.30431@racer>
	 <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
	 <alpine.DEB.1.00.0805271411520.30431@racer>
	 <8aa486160805270637m3fc640bfr9fa51eb917460e5c@mail.gmail.com>
	 <20080527135259.GA12551@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue May 27 16:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K103v-00024U-FA
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbYE0OVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755506AbYE0OVI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:21:08 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:47988 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbYE0OVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:21:07 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1301948ika.5
        for <git@vger.kernel.org>; Tue, 27 May 2008 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rBK/2mchY9Ow96Zygxkv0CvDzpmQUp20+JNC7wS2F48=;
        b=Y5wccjBGKygmsTbvAgNI3OEn+/LH5teTJXn/Ks/i4nuniPH9rMroXUnVGeYcBc6FMuvIy0JYcl2fUkzijrbF8jGpiMi29/e7wekj+7U95MdAVzsfC4nvJs5zd2pIBWsDneIocJL1QXfb4BQBICqXCHe4LNQGuJQDwKWK2Nr+KYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lOgC/wvfnDDElCn8cIOjmactq7abG7uqFwTrG8Hybyg2rW0tpUroGNsoyoyElDy4D/HZnIyhBxu7QD8TRoClHYMTpnaJBHdcXXF7I0EwFkdA/l0iDt95lzuN8Xf0BeJI47kbZJNLAZ7vFJifTrZgkqDsNd4X3Hiy0cdNcCtF5YA=
Received: by 10.86.49.13 with SMTP id w13mr2580588fgw.65.1211898064826;
        Tue, 27 May 2008 07:21:04 -0700 (PDT)
Received: by 10.86.27.11 with HTTP; Tue, 27 May 2008 07:21:04 -0700 (PDT)
In-Reply-To: <20080527135259.GA12551@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83019>

On Tue, May 27, 2008 at 3:52 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Santi B?jar wrote:
>>On Tue, May 27, 2008 at 3:12 PM, Johannes Schindelin
>><Johannes.Schindelin@gmx.de> wrote:
>>> Sure it is.  But cluttering up the commands for something that is not
>>> really proven to be wanted by many is IMO inferior.
>
>>This is an argument against git-whatzzup.sh in general. Point taken.
>
> Not really.  It's an argument against cluttering up the existing core
> with this stuff.

Ok. I misunderstood it, sorry.

>
>>Moreover, this could be integrated in "git status".
>
> I personally have no need for such a thing, but in effect it is the git
> commandline equivalent of MS-Office "Clippy", which provides a hands-on
> tutorial in git while you are trying to use it (with the subtle yet
> important difference that it only provides advice when called).

I don't have experience with Clippy, but my git-what.sh was just
showing the help as shown before (well, actually not for bisect but is
easy to fix).

It is not a hands-on tutorial, it is more of "in which state (merging,
bisecting,...) is my working tree, if it is in the middle of a complex
process (bisect, merge, rebase,...) tell me what was the help
message". It is not that different from the output of "git status",
but for states.

Santi
