From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about used Workflows.
Date: Tue, 15 Mar 2011 15:15:01 +0100
Message-ID: <4D7F7465.8000307@op5.se>
References: <20110315134331.GA5165@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git-List <git@vger.kernel.org>
To: Valentin Haenel <valentin@fsfe.org>
X-From: git-owner@vger.kernel.org Tue Mar 15 15:15:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzV1u-0008IX-Pl
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 15:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab1COOPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 10:15:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46470 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757543Ab1COOPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 10:15:14 -0400
Received: by fxm17 with SMTP id 17so605275fxm.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 07:15:13 -0700 (PDT)
Received: by 10.223.76.147 with SMTP id c19mr3117668fak.55.1300198506344;
        Tue, 15 Mar 2011 07:15:06 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id f16sm2035698faa.38.2011.03.15.07.15.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 07:15:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <20110315134331.GA5165@kudu.in-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169072>

On 03/15/2011 02:43 PM, Valentin Haenel wrote:
> Dear Git developers and contributors,
> 
> I was wondering what kind of workflow the Git project itself uses. From
> what I gather much of the development takes place using the list, and
> patches sent by mail.

That's correct.

> Do any of the core contributers maintain public
> developer repos?

Some do, although most contributions are still sent as patches for
public discussion and then taken from there by Junio who has some
nifty routine for that already.

Subpart maintainers, such as the gitk author Paul Mackerras (spelling?)
have repos of their own from which Junio pulls on request. Normally
that's in parts where Junio feels his knowledge lacking and he trusts
the subpart maintainer. From what I've gathered, Tcl isn't Junio's
strong point.

> And how many developers on average have push privileges
> to http://git.kernel.org/?p=git/git.git;a=summary?
> 

There's no "average" to it. Linus probably still has push access as
he's the founding father and first maintainer. Junio ofcourse has it
as the current maintainer. Shawn Pearce has taken over maintenance
a few times when Junio has been absent for one reason or another. I
doubt push privileges have been revoked in between absences. Oh, and
ofcourse the kernel.org admin team have more or less implicit access
to push, although the git community would certainly frown quite hard
if they ever (ab)used their admin powers to do that.

All that aside; By peer etiquette and for simplicity reasons, only
the current maintainer ever pushes anything to kernel.org. Noone
becomes maintainer (or kernel.org admin) without having invested a
lot of time and shown a lot of devotion to the project.

For some public credit, Junio's doing a great job both maintaining
and choosing interim maintainers. I've rarely seen an opensource
project where the maintainer so rarely (ever?) get annoyed at
anything and keeps everything running smoothly.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
