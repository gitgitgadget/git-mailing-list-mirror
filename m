From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 11:32:29 +0200
Message-ID: <2d460de70810170232o24fcd1d4pd1c7a7503e17b02@mail.gmail.com>
References: <7vy70of6t2.fsf@arte.twinsun.com>
	 <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
	 <7vwsg7mxb6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:33:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqliL-0008Kl-PT
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 11:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYJQJcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 05:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYJQJcb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 05:32:31 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53301 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYJQJca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 05:32:30 -0400
Received: by gxk9 with SMTP id 9so793037gxk.13
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BHrTIRpxTIzvw6xZ6lIlVOVpgU5IQutQm/bZnki1TOI=;
        b=quzBK0IqeH534c12gH10Pvgrfj3n9gbQZhAz7p0ceWGqVdH+I13TPKzuqUEFi4q4hf
         SZivDH+6p2kC3NGMx80XSEC7/txQyW7YORtW04sDCF0SOAmEGyvHhe+gSXw0rJhBJ8xn
         KmrYhR0WMntrWtyQbW1Z9iILA85QFfD6huNfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U1QAbe7MlwX5hAh9HTSexVINWpkckSKl6O5xDAfKVw7ajY5P0PPJ1xXTN/+9gl5P/K
         9FrzlCZOl7BmDRHjm4Hud9Bopx5fAMyiK8XMZHEjI3NYCFzxLCjzxO0xGQWbcsNcVccs
         aC5qTk+Ndn8G218N8MzBKdqOtEHDlHtuJj2jc=
Received: by 10.100.126.7 with SMTP id y7mr3659800anc.77.1224235949151;
        Fri, 17 Oct 2008 02:32:29 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Fri, 17 Oct 2008 02:32:29 -0700 (PDT)
In-Reply-To: <7vwsg7mxb6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98464>

On Fri, Oct 17, 2008 at 10:37, Junio C Hamano <gitster@pobox.com> wrote:

> Eh, Sorry about that --- I did not mean "ignorant" in that sense.  Perhaps
> replacing the word with "unfortunate" would sound nicer?

A lot yes. No harm done, apologies for picking the bad interpretation
of ignorant.


> Don't you realize that is what the hook is doing already?  After making
> such an error, the definitive information is lost, because the user told
> the tool that the resolution is done and the file is ready to be
> committed) by mistake.  Even then the hook is trying its best to help the
> user.

You misunderstood me, there. I was thinking about the pre-add hook
while writing the above. Doing anything at commit time is obviously
wrong.


> As to pre-add hook, I am not enthused, but if somebody sends in a clean
> patch, I wouldn't be opposed to it at least in principle.

An implicit need for it does apparently exist. Else, the default hook for
pre-commit would not need to check for conflicts.


Richard
