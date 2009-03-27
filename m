From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 14:39:28 +0100
Organization: Universitaetsklinikum Regensburg
Message-ID: <49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCJR-0002qo-Uf
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbZC0NkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbZC0NkD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:40:03 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:28712 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752483AbZC0NkB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 09:40:01 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id A5224ABD41;
	Fri, 27 Mar 2009 14:40:03 +0100 (CET)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id 39E60ABB7B;
	Fri, 27 Mar 2009 14:40:03 +0100 (CET)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n2RDdoO9007909;
	Fri, 27 Mar 2009 14:39:50 +0100
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    27 Mar 09 14:39:50 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 27 Mar 09 14:39:32 +0100
In-reply-to: <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589108@20090327.133413Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114889>

On 27 Mar 2009 at 15:24, Dmitry Potapov wrote:

> On Fri, Mar 27, 2009 at 12:50 PM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
> >
> > what made me wonder is this (about item 1): I thought I've read that blobs store
> > content and attributes, so very obviously I wondered why not store thr "right
> > attributes" (i.e. the time of the file). My reasoning: You make some changes, then
> > test them (which might last several hours or days). The if I'm happy I'll
> > "commit".
> 
> With Git, you usually commit your changes immediately (without waiting
> the result
> of testing), because you can always undo commit until you publish your changes.

Hi!

AFAIK, "committing" in git is "kind of publishing your work" (others may pull it). 
I don't like publishing my mistakes ;-) Even if no-one pulls the commit, your 
"undo" refers to "committing a fix for the last committed mistake", right? Again, 
I don't really want to document/archive (i.e. commit) my mistake. Or did I miss 
something here?
I know: Other's opinions are quite different on these issues.

Regards,
Ulrich
