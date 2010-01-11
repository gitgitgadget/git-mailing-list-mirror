From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 20:36:44 -0500
Message-ID: <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
	 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
	 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 02:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU9D8-0001ma-WE
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 02:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab0AKBgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134Ab0AKBgq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 20:36:46 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35812 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab0AKBgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 20:36:46 -0500
Received: by ewy6 with SMTP id 6so21376301ewy.29
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 17:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7tXz9seV5WyEoo8/JMBxcgDR/Ee/Rog8V+B5OkDXWh4=;
        b=Oclpb6Ra3uirFDhQLKz6CVerCQSfGA8Doww37kXHGN9taibxBpWJ0zUug623xO+k3R
         HRdxpGUtwd96kEZ4hLKSejaq4fbFbvVGzS3j7odMRMSoUA3d8E9z2wF9fxkH7g1AdbBf
         57pJ0jAHGrDLPt+N7vaUcPQei6rl186SyQsNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=foIAdCMBQ8sbZLY3aSYrawLKJEdHCDIv2hjh9PSMGN+R1arLa6+k0RO/GA77gXX6Ji
         SRuCwD+00a+Gg/ftq7BUUiUF7DaD12G6viEReC6QP0xc0ACZmXTVEDmCyEqPMWNUgXtj
         hU0QrOo7YmJerxv6VonW304WmXmBkIbG8DD2I=
Received: by 10.216.87.67 with SMTP id x45mr484865wee.18.1263173804645; Sun, 
	10 Jan 2010 17:36:44 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136593>

On 2010-01-10, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 10 Jan 2010, Junio C Hamano wrote:
>  >
>  > A feel good factor is in play?  IOW, "I am short of time, so I won't be
>  > able to really afford to 'git pull' and test the result of re-integrating
>  > my changes to what happened on the other end.  If I can learn that there
>  > is nothing happening over there, then I won't have to do anything and know
>  > that I am up to date."
>
>
> Just do a fetch then.  If the fetch progress display looks like if it is
>  going to take a while then just interrupt it and go home.  If the fetch
>  looks trivial then just merge it.  In any case, the "feel good" factor
>  can't be that great by only knowing if the remote has changed or not.
>

Forced interruption is not such a good idea. I would favor a
non-destructive way to monitor availability of remote commits.

BTW, pull and push are in a way symmetric operations. Is there any
deep reason why push supports --dry-run but pull/fetch does not??

--Leo--
