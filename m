From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Buffer overflows
Date: Mon, 03 Sep 2007 02:19:24 +0200
Organization: At home
Message-ID: <fbfju8$7gh$2@sea.gmane.org>
References: <1188502009.29782.874.camel@hurina> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org> <200709021542.31100.johan@herland.net> <3f4fd2640709020811r4ea8f01fw775257859e26af29@mail.gmail.com> <85veatqelm.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 02:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzg6-0002wI-Dk
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbXICAUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbXICAUF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:20:05 -0400
Received: from main.gmane.org ([80.91.229.2]:59668 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbXICAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:20:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IRzfe-0004tv-8G
	for git@vger.kernel.org; Mon, 03 Sep 2007 02:20:02 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 02:20:02 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 02:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57414>

David Kastrup wrote:

> "Reece Dunn" <msclrhd@googlemail.com> writes:
> 
>> Which is good, as this means that along with the tests in the
>> library, it will be more stable and less likely to be buggy than
>> something that is written from scratch.
> 
> Remember git's history.

On the other hand instead of doing binary diffs from a scratch, git uses
[customized] LibXDiff library. The same might be done with bstring library,
I think.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
