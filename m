From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 22:51:26 +0200
Message-ID: <201010102251.27095.j6t@kdbg.org>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com> <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <ericsunshine@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Mike Pape <dotzenlabs@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 10 22:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52rn-0006yl-0g
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab0JJUv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 16:51:29 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27022 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab0JJUv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:51:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FAB92C4009;
	Sun, 10 Oct 2010 22:51:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 36F6619F5C0;
	Sun, 10 Oct 2010 22:51:27 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158705>

On Sonntag, 10. Oktober 2010, Erik Faye-Lund wrote:
> On Sun, Oct 10, 2010 at 9:50 PM, Eric Sunshine <ericsunshine@gmail.co=
m>=20
wrote:
> > On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
> >> + =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0* ReportEvent() doesn't handle strings containing=
 %n, where n
> >> is + =A0 =A0 =A0 =A0* an integer. Such events must be reformatted =
by the caller.
> >> + =A0 =A0 =A0 =A0*/
> >
> > The comment about '%n' seems to be warning about a potential proble=
m but
> > does not actually protect against it. Should this issue be handled?
>
> This is again an issue that was discussed in the first round.
> ReportEvent() CANNOT report a string containing "%n" (where n is an
> integer). And while we could probably try to work around it by
> inserting a space or something, and I don't think we ever were able t=
o
> find a case where we could report a string containing "%n" in the
> first place...

I recall that it was mentioned that this could happen for IPv6 addresse=
s?

-- Hannes
