From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Hacks for AIX
Date: Fri, 18 Jul 2008 18:14:07 -0500
Message-ID: <JG5kjY-tH7BPWcgn8u14UlNtG-iT5ab0jyExlDkbmv3hzFsVs2Ve0Q@cipher.nrlssc.navy.mil>
References: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com> <7v3am9sn2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Cowan <chris.o.cowan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 01:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJzAd-00030n-Bn
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 01:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbYGRXO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 19:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbYGRXO1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 19:14:27 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59523 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531AbYGRXO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 19:14:27 -0400
Received: by mail.nrlssc.navy.mil id m6INE8US007783; Fri, 18 Jul 2008 18:14:08 -0500
In-Reply-To: <7v3am9sn2p.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Jul 2008 23:14:07.0852 (UTC) FILETIME=[FAAC4AC0:01C8E92B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89086>

Junio C Hamano wrote:
> "Chris Cowan" <chris.o.cowan@gmail.com> writes:

>>     * /usr/bin/patch - really old version, doesn't do well with some
>> diff formats.   I avoid using it.
> 
> t4109 seems to use patch to produce expected output for the tests; we
> should ship a precomputed expected results.  Do you know of any other
> places "patch" is used?

t4110 also uses patch in the same way.

-brandon
