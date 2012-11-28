From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 01:26:22 +0100
Message-ID: <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Nov 28 01:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVU6-0007a5-9B
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab2K1A0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:26:23 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63144 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab2K1A0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:26:22 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13029960oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NGb0mcejJMDm4I7T4mp5zoQt6vhRTst3VpYD8qeO89U=;
        b=Vy6QiWQPBQMX8eU27W4n3AIbZ29hnagmxtf/CsHAPITsPtfht5gnsFXVLXVg1fwYvM
         cKADUiIaCINNhzFkFR5OGs7vEsPFMQ3QjX7CqiStM66VqR6P9mZku8TAh/gQtkvgDlMk
         VJDnYgnpgxg+ziEObVDd5zbCF6d6vLs/df/TB9PtayPePBBbx5zEFGV3lhOhKriAAaJY
         +VIveGn82Iby+ga8g+IN00UtdAKq+sTNGOTdw9TXwisYTPyZBrr29s9ymdT2/A8xFDlm
         JnlHQNV161Fo7qFNp3V3tC6BQ6OMDcD8IAz7JcyuD+BcG09li5fHfe0iT4UmTDy8rcQT
         5GSw==
Received: by 10.182.111.104 with SMTP id ih8mr1403202obb.13.1354062382222;
 Tue, 27 Nov 2012 16:26:22 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:26:22 -0800 (PST)
In-Reply-To: <20121128001231.GA27971@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210642>

On Wed, Nov 28, 2012 at 1:12 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Shawn Pearce <spearce@spearce.org>:
>> Well... if we added a fractional seconds to a commit, older versions
>> of Git will scream loudly and refuse to work with the new commit. That
>> would create a fork of Git.
>
> So much for that idea, I guess.
>
> Unless..I don't know how git's database representations work.  Are they
> version-stamped in any way?  If so, some slightly painful hackery would
> get around that problem.

% git cat-file -p HEAD

You'll see exactly how git stores commits. Changing anything in there
must be done carefully.

-- 
Felipe Contreras
