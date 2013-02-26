From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] mingw: rename WIN32 cpp macro to NATIVE_WINDOWS
Date: Tue, 26 Feb 2013 17:40:21 +0100
Message-ID: <512CE575.1000702@web.de>
References: <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk> <51031C43.5030307@gmail.com> <7v38xo3irh.fsf@alter.siamese.dyndns.org> <51032481.4030707@redhat.com> <20130126010359.GH3341@elie.Belkin> <5106C382.20009@ramsay1.demon.co.uk> <7vliac3nbg.fsf@alter.siamese.dyndns.org> <512C3554.8020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:43:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UANcJ-0001fy-OO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3BZQme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:42:34 -0500
Received: from mout.web.de ([212.227.15.4]:51775 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758612Ab3BZQmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:42:33 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LtFEp-1Uqlqe0yjL-012UY8; Tue, 26 Feb 2013 17:40:23
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <512C3554.8020902@gmail.com>
X-Provags-ID: V02:K0:fh/COB5AN4lrNeDTQjNwsiL+NzXu0SxJj3gMD8INs2u
 NDXciFOseFubVZHlLo1DbN8Si+VIto6k69BY2V2t7bCLmNRYso
 KdKrGcspCSJwy/l2KtDzWoQAlzwDUAgZAZyVHR4kEGrLPTq+w/
 2Xh2h2NPBYLJ1E0G3LZ2fZL1jJpvejwLtrTLCspAnY8jipti/E
 l7EzdF6U3+m6YCRqW+/OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217144>

On 26.02.13 05:08, Mark Levedahl wrote:
> On 02/25/2013 01:44 AM, Junio C Hamano wrote:
>> I was in "find leftover bits" mode today and found this thread hanging. Has anything come out of this thread, or there is nothing to improve in this area? 
> 
> The patch passed my simple tests (build, run a few commands), but I didn't get around to a full test. And of course, I am testing on current Cygwin where git compiles and runs correctly anyway.
> 
> Mark
I run the test suite, and there was 1301 failing (and t0070 ?) which have
to do with POSIX permisions.
They are on my TODO stack.
/Torsten
