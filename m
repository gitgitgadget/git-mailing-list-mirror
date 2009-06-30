From: Andreas Ericsson <ae@op5.se>
Subject: Re: Official git repository history?
Date: Tue, 30 Jun 2009 11:33:20 +0200
Message-ID: <4A49DBE0.5060500@op5.se>
References: <h2aj43$ab0$1@ger.gmane.org> <7vhbxy9n9q.fsf@alter.siamese.dyndns.org> <h2chap$i27$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 11:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLZiW-00061H-9Z
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 11:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbZF3JdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 05:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZF3JdV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 05:33:21 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60961 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750937AbZF3JdV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 05:33:21 -0400
Received: from source ([74.125.78.147]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSknb42f+N8Nt05QKgs1XPOjwfHxKQFC3@postini.com; Tue, 30 Jun 2009 02:33:24 PDT
Received: by ey-out-1920.google.com with SMTP id 13so2769eye.44
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 02:33:22 -0700 (PDT)
Received: by 10.210.119.5 with SMTP id r5mr874582ebc.72.1246354402572;
        Tue, 30 Jun 2009 02:33:22 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 28sm1647286eye.46.2009.06.30.02.33.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 02:33:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <h2chap$i27$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122503>

Graeme Geldenhuys wrote:
> Junio C Hamano wrote:
>>> git repository? Was the first 8 C source code files already enough to
>>> work as a basic git repository?
>> He did it very well, and Yes.
> 
> Wow, very impressive! Such a little code, yet already workable.
> 

Indeed. The git concept is an extremely simple one. The complexity comes
when you start optimizing it, really. Producing packfiles today requires
more code than made up all of git at its inception. Simple models can
easily be extended with complex algorithms, while complex models generally
require the simplest possible algorithm to work reliably. This design
lesson has served me well over the years.

> 
>> You would need to check out an old revision, say v0.99, and look at the
>> original tutorial by Linus in Documentation/tutorial.txt.  It was since
> 
> 
> Last night I played further with the first ever commit. I managed to
> figure out the sequence in which commands had to be run. Kudos to the
> people that decided the make the commands easier in the later versions. :-)
> 

Cheers. There's about 650 of us, so that's a lot of kudos ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
