From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:45:05 -0400
Message-ID: <8D972813-2D7F-4D6A-958F-B76E947E7BC3@MIT.EDU>
References: <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <20071020063628.GV14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij85Z-0000FN-2l
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762493AbXJTGpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762425AbXJTGpZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:45:25 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:34415 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762493AbXJTGpY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 02:45:24 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9K6j7YS006623;
	Sat, 20 Oct 2007 02:45:12 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9K6j6go022709
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 20 Oct 2007 02:45:06 -0400 (EDT)
In-Reply-To: <20071020063628.GV14735@spearce.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61800>


On 20 Oct 2007, at 2:36:28 AM, Shawn O. Pearce wrote:

> Today I move the file, then unstage the hunks I'm not sure about,
> then go back and restage them.  Annoying.  It really disrupts
> my workflow.

I know it's against policy, but the proposed change should be set
as the default at some point, in my opinion.

Perhaps when the -u flagged is not used, there can be a warning that
states -u will become the default at a certain time.

In fact, -u speaks "update" to me, and I would expect it to signal
the current behavior.

I have a feeling that my suggestion will not go far,
but I also think that backwards compatibility can
overstay its welcome.
