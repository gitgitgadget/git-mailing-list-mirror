From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 19:26:18 +0030
Message-ID: <4d8e3fd30802251056t626ff51dx8a6ea7a006222e72@mail.gmail.com>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
	 <4d8e3fd30802241456l6c02a040te21643c830cf0e46@mail.gmail.com>
	 <20080225183547.GB15131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "John Goerzen" <jgoerzen@complete.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:57:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiVX-00021a-M3
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbYBYS4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbYBYS4U
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:56:20 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:60332 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbYBYS4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 13:56:19 -0500
Received: by wf-out-1314.google.com with SMTP id 28so927617wff.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EFWz0jaZhiokJ5VMcNMV9pp31/uL/bnsncHmr6y1TIg=;
        b=gfGRdvaBYgvWwGQWD0xqgAkRzx0Hzr47sq1O2K5aYny/a9YTU3K0mNHjro658BOxTnNPTpjTDstoQK9W87BuhDRaqbX7VYeRtJuDpywsEWE+L7nMWzJLAZ2rhTODXe28TuPT4QCxVUVF5UYLEhGZnMdo4zq3SgmnPYHOA4M17pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FkQDPdFjkqbYVjAu4iFZqcDyRXI/P1YxiUSi6aLEty+Eljm+0tdjQE4Wd1R3O/RkapHrUcsWS1pRRatJblXvvCVIF7zI++xOA6mgEvHKSA/AdDkWCl0Ol/hNgqTvy+Sgz9/aPwG0LtBhrFU0kGrfwWHeEMz5LJAcuOva4ASNZCE=
Received: by 10.142.11.2 with SMTP id 2mr2636216wfk.223.1203965778313;
        Mon, 25 Feb 2008 10:56:18 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Mon, 25 Feb 2008 10:56:18 -0800 (PST)
In-Reply-To: <20080225183547.GB15131@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75044>

On 2/25/08, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 25, 2008 at 02:26:03AM +0330, Paolo Ciarrocchi wrote:
>
> > I can't think of how to unify the commands from the ui point of view.
> > What do you suggest?
> >
> > However, i like the idea of a --send commad line option to
> > git-format-patch that calls git-send-email to create and send the
> > patch series.
>
> I think it makes sense the other way around: have git-send-email invoke
> git-format-patch.
>
> My reasoning is that git-send-email users almost always use
> git-format-patch, but git-format-patch users frequently do not use
> git-send-email.


that's correct. I even like the idea of a single git email command.
ciao,
--
Paolo
http://paolo.ciarrocchi.googlepages.com/
