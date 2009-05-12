From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during tests
Date: Tue, 12 May 2009 16:27:31 -0700
Message-ID: <7viqk57vh8.fsf@alter.siamese.dyndns.org>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
	<loom.20090511T195910-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Wed May 13 01:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M41PE-00062l-0I
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 01:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbZELX1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 19:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757036AbZELX1c
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 19:27:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56243 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbZELX1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 19:27:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512232731.HRSY17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 12 May 2009 19:27:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id qnTX1b00G4aMwMQ04nTXG0; Tue, 12 May 2009 19:27:31 -0400
X-Authority-Analysis: v=1.0 c=1 a=6FHiilcIfxYA:10 a=s4hJD8TZ4iwA:10
 a=9vXuR5GGAAAA:8 a=X5qfkU2QAAAA:8 a=m0bHr2FCAAAA:8 a=dZcN94hdiSLN3RnCaiwA:9
 a=79JlgUsAAjdicw-nILFP-xHV5ssA:4 a=Ht_zg9lMJPUA:10 a=eDFNAWYWrCwA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118971>

Eric Blake <ebb9@byu.net> writes:

> Don Slutz <Don.Slutz <at> SierraAtlantic.com> writes:
>
>> 
>> This is a patch set to do the work from mail message:
>> 
>> http://kerneltrap.org/mailarchive/git/2007/8/7/254415
>> 
>> It is split into 6 parts.  This is because the tests do not work on
>> Linux if autocrlf=true.
>> 
>> 1) The change to autocrlf=true by default for cygwin
>
> I help maintain the cygwin packaging of git, and I don't particularly like 
> patch 1/6.  Cygwin very much recommends that users stick with binary mounts, 
> where cr's are not inserted/stripped by default, and enabling autocrlf in that 
> situation is asking for problems...

Ok, thanks for the comments; I won't touch this for now myself, with
objections and concerns from people working on windows (you on Cygwin
side, and Dscho on msysgit side).
