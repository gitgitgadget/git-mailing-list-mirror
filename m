From: John Keeping <john@keeping.me.uk>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 2 Feb 2014 11:31:41 +0000
Message-ID: <20140202113141.GB29976@serenity.lan>
References: <87a9e92424.fsf@fencepost.gnu.org>
 <CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
 <8761ox2240.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vHF-0001fg-H1
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbaBBLbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 06:31:50 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:55712 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbaBBLbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 06:31:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7DC556064E4;
	Sun,  2 Feb 2014 11:31:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rxwOLPyyxWXs; Sun,  2 Feb 2014 11:31:48 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8DA5B6064A9;
	Sun,  2 Feb 2014 11:31:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <8761ox2240.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241363>

On Sun, Feb 02, 2014 at 12:19:43PM +0100, David Kastrup wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > The file is for past commits only.
> 
> > New commits can contain these info in their messages.
> 
> If it's not forgotten.  Experience shows that things like issue numbers
> have a tendency to be omitted, and then they stay missing.
> 
> At any rate, this is exactly the kind of stuff that tags are useful for,
> except that using them for all that would render the "tag space"
> overcrowded.

Actually, I would say this is exactly the sort of thing notes are for.

git.git uses them to map commits back to mailing list discussions:

    git fetch git://github.com/gitster/git +refs/notes/amlog:refs/notes/amlog &&
    git log --notes=amlog

See also notes.displayRef in git-config(1).

Notes aren't fetch by default, but it's not hard for those interested to
add a remote.*.fetch line to their config.
