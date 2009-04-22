From: Andreas Ericsson <ae@op5.se>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 18:40:07 +0200
Message-ID: <49EF4867.8060002@op5.se>
References: <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net> <1240362948.22240.76.camel@maia.lan> <e2b179460904220255v58986bd5q7c22eb3ab8486157@mail.gmail.com> <alpine.DEB.1.00.0904221516250.14221@intel-tinevez-2-302> <20090422143503.GG23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Sam Vilain <sam@vilain.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matt Enright <awickedshimmy@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 18:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwfW5-00010c-GL
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 18:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZDVQkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZDVQkO
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 12:40:14 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54866 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbZDVQkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 12:40:12 -0400
Received: by fxm2 with SMTP id 2so65520fxm.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 09:40:09 -0700 (PDT)
Received: by 10.204.31.196 with SMTP id z4mr7808179bkc.92.1240418408936;
        Wed, 22 Apr 2009 09:40:08 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 12sm279387fks.25.2009.04.22.09.40.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 09:40:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090422143503.GG23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117216>

Shawn O. Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 22 Apr 2009, Mike Ralphson wrote:
>>
>>> 2009/4/22 Sam Vilain <sam@vilain.net>
>>>> Now that the GSoC projects have been announced I can give you the good
>>>> news that one of our two projects...
>>> It's sort of three, really...
>>>
>>> http://socghop.appspot.com/student_project/show/google/gsoc2009/mono/t124022708105
>> OMG!  That's the third time they are wasting Google's money: AFAICT they 
>> haven't learnt from the past two years' failures.  At least I am not aware 
>> of any of them Mono guys trying to collaborate with us.
> 

I offered to assist with reviewing patches or explaining technicalia to them
last year (while I was learning a bit of C# myself), but got no patches or
requests from them at all.

>> Oh well, maybe I should drop them a mail that they may get valuable input 
>> here _iff_ they just ask.
> 
> I've tried that in the past two years.  I've given up.  The JGit
> code is available.  Its license is quite liberal.  They can look
> at it if they want.  My guess is, they won't.
> 

I'm with Shawn here. They refuse to look at unmanaged code (that is, non-C#
code), and since there is none yet, they're in a sort of catch-22 when it
comes to reference implementations. Ah well. I'll join mono-develop mailing
list again and see what I can do to help.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
