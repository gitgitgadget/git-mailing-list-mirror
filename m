From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: fast-import.c: zlib_compression_level vs pack_compression_level
Date: Sat, 19 Jan 2008 09:47:36 +0100
Message-ID: <e5bfff550801190047n5616b252w4d1c5802343af864@mail.gmail.com>
References: <e5bfff550801180504v17df7976x59d12f210efe583e@mail.gmail.com>
	 <alpine.LFD.1.00.0801181043100.25841@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 09:48:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG9NC-00040p-PQ
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 09:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbYASIrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 03:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYASIrj
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 03:47:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:35613 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYASIri (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 03:47:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1136317rvb.1
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 00:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IBEBBUhXzbmUxqkCgC+Jpd3d5YC4fzHm+pbFih87p0o=;
        b=DqqMV9NzqkUVr/HA39XA5x64/tnl3Dz6UXOKusrIlzE2byUo7zV/HKy1o2dsAzFHByIDZm1/zCUwB7r7NFwsLoZF0FzmnIZGv7Yon6BKi1xX6F3u5XziU5ujY6bPz1B+vIN/vYLzxYobUBAl9F1XIiFJO6Tf0EzRGCsbvSv8TkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aFDJ+/GtAMl0XtCY52DBLYE8okt/GMK3X8/GGXBako9BimgIPt+4OYdNv/U5mTy1mj873g0qG1Ff/42QgI6kEst+hr/+T/UYMFfW1LuS41N3AOnTdDUUWn9Y6Ez8q+Sy/DhCmWSFBCWbhwiWbgbCjI4wVveuNMk4KM4pJTgK6vE=
Received: by 10.140.179.25 with SMTP id b25mr3001531rvf.152.1200732456975;
        Sat, 19 Jan 2008 00:47:36 -0800 (PST)
Received: by 10.141.68.21 with HTTP; Sat, 19 Jan 2008 00:47:36 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801181043100.25841@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71088>

On Jan 18, 2008 4:44 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 18 Jan 2008, Marco Costalba wrote:
>
> > My question is, does fast-import should use pack.compression instead
> > of core.loosecompression?
>
> Yes it should.
>

I have a patch on top of my comrpession cleanup series, if people
agree I would leave this as is now. It's really not a biggie and 1.5.4
_seems_ very near.


Marco
