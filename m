From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 12:06:53 -0500
Message-ID: <47E7DFAD.4060209@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site> <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site> <47E7D818.7090501@nrlssc.navy.mil> <alpine.LSU.1.00.0803241745240.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdq9H-0004Aq-6H
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 18:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbYCXRHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 13:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbYCXRHK
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 13:07:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48060 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbYCXRHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 13:07:09 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2OH6rhj027868;
	Mon, 24 Mar 2008 12:06:53 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Mar 2008 12:06:53 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0803241745240.4353@racer.site>
X-OriginalArrivalTime: 24 Mar 2008 17:06:53.0282 (UTC) FILETIME=[7520BC20:01C88DD1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--6.129000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 
	150567-700075-139010-113922-700630-700999-701455-700782-148039-148051-20042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78064>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 24 Mar 2008, Brandon Casey wrote:
> 
>> So right now, tags matching the refspec are rewritten. They are currently
>> rewritten with a lightweight tag.
> 
> That is unintended.  My understanding of a tag was always that it is 
> something immutable.  I mean, _really_ immutable.  If you released a 
> certain version, then that is tagged.  You must not rewrite the tag.  
> Ever.

Then what is the intended behavior for --tag-name-filter?

-brandon
