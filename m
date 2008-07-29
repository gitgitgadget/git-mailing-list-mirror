From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>" (solves part of problem with system_path)
Date: Tue, 29 Jul 2008 13:31:14 +0200
Message-ID: <92EF2709-424A-4DA8-AE2C-B54C69F6BB0B@zib.de>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de> <1217308647-23673-1-git-send-email-prohaska@zib.de> <20080729052459.GC11947@spearce.org> <7v4p69meka.fsf@gitster.siamese.dyndns.org> <42EF8777-BABC-4757-AD49-627320F24D39@zib.de> <alpine.DEB.1.00.0807291310390.4631@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 13:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNnTP-000793-Mw
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbYG2Ldf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbYG2Lde
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:33:34 -0400
Received: from mailer.zib.de ([130.73.108.11]:39293 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbYG2Lde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:33:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6TBUpiF027320;
	Tue, 29 Jul 2008 13:30:56 +0200 (CEST)
Received: from cougar.zib.de (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6TBUklE014897
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2008 13:30:46 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807291310390.4631@eeepc-johanness>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90616>


On Jul 29, 2008, at 1:13 PM, Johannes Schindelin wrote:

> On Tue, 29 Jul 2008, Steffen Prohaska wrote:
>
>> On Jul 29, 2008, at 7:42 AM, Junio C Hamano wrote:
>>
>>>  We prefer running the dashless form, and POSIX side already does  
>>> so;
>>>  we should use it in MinGW's start_command(), too.
>>
>> Thanks for reading my mind ;-)  This was the alternative  
>> justification I
>> had in mind after reading my patch again.
>
> Well, given that the justification you gave had the obvious flaw --  
> which
> you even pointed out -- that non-builtins are _still_ affected, i.e.  
> that
> you leave that bug unfixed (but your description purports that you  
> want to
> fix that bug), it would have been wiser to give the alternative
> justification, which makes the commit obviously correct.

We still need to fix the problem with system_path(), because currently
we cannot release Git-1.6.0 on Windows.  That is why I pointed out the
real problem we are facing.  The (good) side-effect is that the
MSYS-codepath is now prepared for 1.7.

	Steffen
