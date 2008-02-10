From: "Derek Mahar" <derek.mahar@gmail.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 11:30:52 -0500
Message-ID: <5f4b18bf0802100830w682c67e0r9886b2fe32ce3715@mail.gmail.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com>
	 <200802101415.00726.robin.rosenberg.lists@dewire.com>
	 <5f4b18bf0802100801t20952180u6afd1eeaf2fac17@mail.gmail.com>
	 <200802101717.32747.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOF5W-0005Xi-S4
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYBJQaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYBJQaz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:30:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:2470 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYBJQay (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:30:54 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4487931wxd.4
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YJlylR7fwLfqHgAJaDpNNKg5IQzEKXwCHT055fVIGvM=;
        b=NBlwg8dNeeeWmL9Me6ncAC96djHVSMBrNl76zYqOcVaPFhM6aAVq2wsPg6oogYLFbzsaGncb61eh1RNnVdBCa8dJHb0G0CkmyTIfbyAPb7A+3dovRfrrq33o3uAmsOUNrDq/wJpTLrGMHTGsvTNise5EvSLRxz1Y203Fuffqzcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KwDMqwf1NWdL5yxXUbDYcz1HOIJCh+f5DnyrmS65TJF2HoeBuRirbIAJ1ctxvqrshn0pKtOChSdyOkiCR7qdf4wKqfOL/FVVTwWDV77VGZCGrH0XqaVF7B9RRoi5DyD+Fkz3R2lXdEfq1qIj3lMAHt8dbVJf6E5NsgN28b6SoUE=
Received: by 10.143.40.18 with SMTP id s18mr711330wfj.168.1202661052487;
        Sun, 10 Feb 2008 08:30:52 -0800 (PST)
Received: by 10.142.177.13 with HTTP; Sun, 10 Feb 2008 08:30:52 -0800 (PST)
In-Reply-To: <200802101717.32747.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73367>

On Feb 10, 2008 11:17 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> If you involve CVS (or any other SCM) you must rebase on top of the
> CVS imported version, whether your repo is a clone or not. The changed
> commit to me also means I can see wheter it s a pure git checkin or
> whether it is from the official CVS repo, which is a "good" thing.

Good point.  I can also keep a second "pure" git clone of the CVS repo
from which other users make copies.


> > Can fromcvs read from a remote CVS repository via pserver or does it
> > only parse the RCS files directly?  I have only pserver access to our
> > CVS repo,
> RCS only. Note that sometimes you have rsync access. If not politely ask
> the admin of the repo that you get read access to the raw files. (the CVSROOT/*
> files are not needed in case that is a concern).

Thank you.  I'll try this suggestion.

Derek
