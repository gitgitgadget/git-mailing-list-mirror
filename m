From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:34:49 -0400
Message-ID: <FF5A82CA-8AE3-4E1C-872D-26D938933E1B@MIT.EDU>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7vS-0006TP-Nz
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbXJTGe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbXJTGe6
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:34:58 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:33577 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758343AbXJTGe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 02:34:58 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9K6Ypb5003341;
	Sat, 20 Oct 2007 02:34:51 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9K6Youl022298
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 20 Oct 2007 02:34:51 -0400 (EDT)
In-Reply-To: <20071020062400.GA30388@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61794>


On 20 Oct 2007, at 2:24:00 AM, Jeff King wrote:

> Because I was having trouble understanding what Michael was trying to
> accomplish with his "here are two methods, and one is better" since  
> they
> seemed to do different things. But that is perhaps my fault for  
> joining
> the thread in the middle. I may have simply caused more confusion by
> getting involved. :)

The first method is wrong, because I wasn't considering the fact that
he may have already staged something.

Because I thought both methods achieve the same result, I called the  
latter
"better", because it is more efficient.

Michael Witten
mfwitten
