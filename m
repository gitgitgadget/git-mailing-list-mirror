From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Summer of Code project ideas
Date: Fri, 25 Mar 2011 14:02:14 +0100
Message-ID: <201103251402.16280.jnareb@gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <m37hbx5ncw.fsf_-_@localhost.localdomain> <878vw4c8c5.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	"J.H." <warthog9@eaglescrag.net>, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 14:02:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q36ez-000728-Bp
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 14:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab1CYNCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 09:02:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56460 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1CYNC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 09:02:29 -0400
Received: by bwz15 with SMTP id 15so874621bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QMxUhdrOeej8ljVzz57nSvY+QWKbT8Eee82q6MSxuDg=;
        b=KjPjK6q4mBAuwHmG+RF7X/tELuzbSTFN479SjSd9K2QPySXHEEizfo7PvLwic5U5AI
         a6lNY7KczT+QlMQcqdtcngtuBRz8YBm8UII0k5mO4zua6PpuLcgfO4AcsRoprxIz4hbA
         nush6f2CWgIbdpSI9pVEK/lYI0efWJbW7FxoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QgPOFMzbjUkXgunsIO0HZ2MjPU5ZUZprD7QfLZGlpsaIhttWpacPAKUlNNN9Lw0wYG
         eEpYrIxKTtAnAA023wtXGN5xw0HkZila546cvTfH2X1GZKOEqEsDxwxmUiD6QxW267fN
         ojTlGpXkg6JiKQf0h+1qFJ550q2+kQyT/SFrQ=
Received: by 10.204.175.194 with SMTP id bb2mr726653bkb.121.1301058148435;
        Fri, 25 Mar 2011 06:02:28 -0700 (PDT)
Received: from [192.168.1.13] (abwk172.neoplus.adsl.tpnet.pl [83.8.234.172])
        by mx.google.com with ESMTPS id w3sm718584bkt.17.2011.03.25.06.02.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 06:02:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <878vw4c8c5.fsf@fox.patthoyts.tk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169985>

On Fri, 25 Mar 2011, Pat Thoyts wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

> > A few project ideas I am not sure if they are feasible for GSoC:

> > * embedding graphical diff and graphical merge tool in git-gui, e.g. as
> >   "git gui diff".  I think that we can use xxdiff; the license is 
> >   compatibile.
> >
> >   Pat and Shawn, is it something worth doing?  Does it look like a good
> >   project for GSoC2011, or is it too small of a project for this?  Would
> >   we be able to find mentor for this idea?
> 
> There is also tkdiff for stealing from. I'm not sure about the worth -
> there are lots of free merge tools around. But if someone wants to do
> that then fine.

I meant TkDiff, not xxdiff here; I'm sorry for the mistake.

TkDiff has the advantage that is already written in Tcl/Tk, so we can
borrow code (like e.g. "refining" diff), not only algorithms.

> > * splitting gitk, common library (Tcl/Tk bindings) for gitk and git-gui
> >
> >   Pat and Paul, do you think it is right scope, or is it too large project
> >   to put as an GSoC idea?
> 
> It shouldn't be too large. You are likely looking at doing Git.pm as a
> Tcl package (without looking in much detail). Testing that gitk and
> git-gui didn't get broken will probably be tedious. So adding some test
> suite to each could help. The Tcl test package is quite capable of being
> used to test Tk apps provided some tests get written.

I thought that would be mainly re-using library part of git-gui in gitk;
tests are decidely a good idea, though I don't know if there are ready
tools to do tests for programs written in Tcl/Tk , and for testing UI.

-- 
Jakub Narebski
Poland
