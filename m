From: Max Pollard <ajaxsupremo@yahoo.com>
Subject: Re: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 13:07:50 -0800 (PST)
Message-ID: <790332.92389.qm@web45907.mail.sp1.yahoo.com>
References: <7v63xco0w5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJxhB-0000Nq-VR
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYA2VHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbYA2VHw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:07:52 -0500
Received: from n23b.bullet.mail.sp1.yahoo.com ([69.147.64.243]:36130 "HELO
	n23b.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751196AbYA2VHv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 16:07:51 -0500
Received: from [216.252.122.218] by n23.bullet.sp1.yahoo.com with NNFMP; 29 Jan 2008 21:07:51 -0000
Received: from [69.147.65.165] by t3.bullet.sp1.yahoo.com with NNFMP; 29 Jan 2008 21:07:51 -0000
Received: from [127.0.0.1] by omp500.mail.sp1.yahoo.com with NNFMP; 29 Jan 2008 21:07:51 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 24651.45813.bm@omp500.mail.sp1.yahoo.com
Received: (qmail 92731 invoked by uid 60001); 29 Jan 2008 21:07:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ltB1RolhdSLR7OD6bJVRJxoGRgy/hJCThiyvnreJ+RP07neHiSwVl+80/lbb1L+JE6bfNunWoVukSr8CCiYu0nLuSrFSxtU/kefwoAiSWpal//ceMbxVubthr+cg91Hk5KFOXZbYcIHXDjblyxx0CKxVcVEBnys8NrX575eGXlk=;
X-YMail-OSG: 5q7icGcVM1mSTBHJdfDbkfH5gA5LH7uRyAqcRjFgQXRPBm__rt2gaRPvd1UAxC.6Olbms0Y1ncB6GOLfQlqe7WNe5t1XURtEuKH6
Received: from [66.122.195.143] by web45907.mail.sp1.yahoo.com via HTTP; Tue, 29 Jan 2008 13:07:50 PST
In-Reply-To: <7v63xco0w5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71995>


--- Junio C Hamano wrote:

> Max Pollard writes:
> 
> > I only see the log corresponding to the 2nd commit (v1.5.3.5).
> 
> That is what you are asking "git log" to show.  "git log b.txt"
> means "please simplify the history by throwing away commits that
> do not have changes to paths that match b.txt, and then show the
> resulting log with the change pertaining to that path".  The
> first commit does not change a path called b.txt (in other
> words, "git show --stat HEAD^" will not give diffstat for "b.txt"),
> so that commit is not shown.
> 
> $ git log --pretty=oneline --name-status -C -C
> 

Got it - many thanks.  So -C -C is the answer, with --name-status or --stat to
actually show the result.  From the code, a status like Cxxx appears to contain
the "similarity percentage" in xxx; so that C100 would mean an exact copy...


MP



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ 
