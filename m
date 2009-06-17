From: Andreas Ericsson <ae@op5.se>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 15:16:34 +0200
Message-ID: <4A38ECB2.6010100@op5.se>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <4A38AD5D.6010404@gmail.com> <20090617102332.GA32353@coredump.intra.peff.net> <4A38D408.7000302@op5.se> <4A38EACD.3050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Bito <jwbito@gmail.com>, git <git@vger.kernel.org>
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 15:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGv0V-0000Ux-Po
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbZFQNQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757333AbZFQNQh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:16:37 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53118 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754428AbZFQNQh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 09:16:37 -0400
Received: from source ([72.14.220.157]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSjjstSQ+eX3c4kf8U3pa55xCQxarM2n3@postini.com; Wed, 17 Jun 2009 06:16:40 PDT
Received: by fg-out-1718.google.com with SMTP id e21so106347fga.22
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 06:16:37 -0700 (PDT)
Received: by 10.86.3.20 with SMTP id 20mr536023fgc.16.1245244597334;
        Wed, 17 Jun 2009 06:16:37 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm1511149fgg.5.2009.06.17.06.16.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 06:16:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A38EACD.3050602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121743>

Paolo Bonzini wrote:
> 
>> The glibc implementation is quite large. Cutting the library-specific
>> cruft it still sits at about 10k LOC.
>>
>> Using PCRE is a no-go, as it uses perl-compatible regexes even for the
>> posix-compatible API, as per pcreposix(3):
> 
> I have a PCRE fork that has POSIX semantics (except the braindead 
> leftmost-longest *sub*expressions).  It weighs 8kLOC, you can find it in 
> branch ssed of GNU sed's git repository.
> 

Sounds neat. Do you by any chance have some performance measurements
for it? If the work's already done and it provides a significant
improvement I'm all for it ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
