From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: creating tracking branches with git gui
Date: Fri, 9 May 2008 23:50:00 +0530
Message-ID: <2e24e5b90805091120j1fa5939ck4f2272aae2df00b9@mail.gmail.com>
References: <2e24e5b90805070104i337f9196g90134d11f35a1094@mail.gmail.com>
	 <2e24e5b90805072006j311b276cpe0a0d0eea9fa13a0@mail.gmail.com>
	 <20080508234114.GZ29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 20:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuXDj-0007Js-7m
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 20:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbYEISUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYEISUE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 14:20:04 -0400
Received: from ti-out-0910.google.com ([209.85.142.188]:18120 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYEISUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 14:20:02 -0400
Received: by ti-out-0910.google.com with SMTP id b6so532979tic.23
        for <git@vger.kernel.org>; Fri, 09 May 2008 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=conJKbhu+6Wi9T9O7Fw+tpv6I90JdTYljlWayGjhC6A=;
        b=cH9GnPO5UM8biMjllPBDYNAFV8UTPj88Z6ndGEYykpUPnJFxQvfsBeLUWCudbOBFmEwaRBQxXPtBbzStPnaaEQzGU+qDuTTbqevNvndbFnKqYIltgE6bdvQmzMKIcQ07/j7B/mr/F+CtK4PBN+P6zef1kNa03OzgiMP3bij9alw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FM13TjqEE6sRQEiLfse+w/F27Y7oyee+mu7IYq8kFF7g/ZPLARgXGmf9BZdKgYhCzDmK0JuYBAStafnuDKqZSV9oPskZaPg/lxRTtajJdUyHikaJ9eZDrh67PMAztHG3NxpW1aCc4F0bJpmulHbCAkSRQHBF/ALgDFVFSv6HmCk=
Received: by 10.110.40.8 with SMTP id n8mr466227tin.7.1210357200146;
        Fri, 09 May 2008 11:20:00 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Fri, 9 May 2008 11:20:00 -0700 (PDT)
In-Reply-To: <20080508234114.GZ29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81629>

On Fri, May 9, 2008 at 5:11 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Yea, I think that option actually predates the --track thing that
> git-branch does these days.  Its designed to save a mouse click if

> I don't use the --track feature (branch.$name.remote, branch.$name.merge)
> in my own work, so I have never had the desire or need to make sure that
> git-gui sets this up for you.
>
> I'll try to work up a patch this evening.

Thanks -- I appreciate it.

The tracking feature is very useful; even though I understand the
whole refspec syntax perfectly well I still use this feature.

And I'm trying to propagate git at my job and every bit helps.

Besides, it's a bit hard to explain to folks why the widgets are
called "Match Tracking Branch Name" and "Tracking Branch" but the
branch is not actually tracked :-)
