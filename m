From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git log --objects
Date: Fri, 25 Jun 2010 12:06:18 +0200
Message-ID: <AANLkTim_93FIAoz5_EPpRspCNUpMD30yk56enwcejglg@mail.gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
	<4C23702F.8030707@viscovery.net>
	<4C237AE7.8000003@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 25 12:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS5no-0002JI-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 12:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab0FYKGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 06:06:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:41764 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0FYKGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 06:06:21 -0400
Received: by ey-out-2122.google.com with SMTP id 25so55047eya.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 03:06:19 -0700 (PDT)
Received: by 10.103.84.1 with SMTP id m1mr120641mul.26.1277460378877; Fri, 25 
	Jun 2010 03:06:18 -0700 (PDT)
Received: by 10.103.138.16 with HTTP; Fri, 25 Jun 2010 03:06:18 -0700 (PDT)
In-Reply-To: <4C237AE7.8000003@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149676>

On Thu, Jun 24, 2010 at 5:33 PM, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> Shouldn't 'git log --objects' print out a list of all objects in the
> file tree of the commits it lists?

In fact --objects prints all objects reachable from the given commits
(or between commits if $commit1..$commit2)

>
> I tried git log with lots of other parameters, for example '-p' and
> never saw any difference to the normal output and definitely no list of
> hash ids.

I think --objects, --objects-edge, --unpacked are for "git rev-list".
So they should not be listed in git-log man page.

HTH,
Santi
