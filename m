From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: (unknown)
Date: Mon, 26 Nov 2007 21:00:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711262043450.4845@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bulb@ucw.cz
X-From: git-owner@vger.kernel.org Mon Nov 26 21:01:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwk9I-0007wo-4A
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbXKZUBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbXKZUBZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:01:25 -0500
Received: from mailout10.sul.t-online.de ([194.25.134.21]:60833 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753644AbXKZUBY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 15:01:24 -0500
Received: from fwd34.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1Iwk8u-0001Nq-03; Mon, 26 Nov 2007 21:01:20 +0100
Received: from [192.168.2.100] (bHnBqrZaQhE6N9teHlMso5j0PA-Xr3nWfgGLSMj7+elRt3FH2Ymljrf36A4csCCwHj@[84.163.255.82]) by fwd34.t-online.de
	with esmtp id 1Iwk8N-1hfSDY0; Mon, 26 Nov 2007 21:00:47 +0100
X-X-Sender: michael@castor.milkiway.cos
X-ID: bHnBqrZaQhE6N9teHlMso5j0PA-Xr3nWfgGLSMj7+elRt3FH2Ymljrf36A4csCCwHj
X-TOI-MSGID: d3fa0da0-5fbb-4fd1-97c8-8ccf5a46660f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66106>



>On Mon, Nov 26, 2007 at 20:12:37 +0100, David Kastrup wrote:
>> Jan Hudec <bulb@ucw.cz> writes:
>> 
>> > On Mon, Nov 26, 2007 at 18:10:10 +0100, Benoit Sigoure wrote:
>> >> On Nov 26, 2007, at 5:46 PM, Andy Parkins wrote:
>> >> While we're discussing bad names, as someone already pointed out, I 
agree 
>> >> it's sad that "git push" is almost always understood as being the 
opposite 
>> >> of "git pull".
>> >
>> > Well, it is an oposite of pull. Compared to it, it is limited in that 
it will
>> > not do a merge and on the other hand extended to *also* be an oposite 
of
>> > fetch, but still oposite of pull is push.
>> 
>> With the same reasoning the opposite of a duck is a lobster, since a
>> lobster has not only fewer wings, but also more legs.
>
>No.
>
>The basic pull/push actions are:
>
>git pull: Bring the remote ref value here.
>git push: Put the local ref value there.
>
>Are those not oposites?
>
>Than each command has it's different features on top of this -- pull 
>merges
>and push can push multiple refs -- but in the basic operation they are
>oposites.


In the case remote branches are used push and pull are not exactly 
opposite. Pull uses the remote branch and push does not.

                                 .
               LOCAL REPO        .       REMOTE REPO
    .............................................................
    a_local_branch ------------ push ------------->a_local_branch 
         ^                       .                       |
         |                       .                       |
         |                       .                       |
       merge                     .                       |
         |                       .                       |
         |                       .                       |
    a_remote_branch <----------fetch ---------------------
                                 .

Cheers,
Michael
