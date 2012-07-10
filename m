From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without any extra flags
Date: Tue, 10 Jul 2012 11:52:53 +0200
Message-ID: <98BD2F91-9204-40CE-AE0A-4F771AFEA984@quendi.de>
References: <1341529386-11589-1-git-send-email-max@quendi.de> <7vk3ydkmzq.fsf@alter.siamese.dyndns.org> <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de> <7vy5mskewg.fsf@alter.siamese.dyndns.org> <35825CE5-4411-4C75-830A-6D704ACA1410@quendi.de> <7vtxxgkac0.fsf@alter.siamese.dyndns.org> <84D9664E-3249-4D80-980A-C01B02DF5E43@quendi.de> <7vd344k1ag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 11:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoX7v-0007Pl-0z
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 11:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab2GJJw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 05:52:57 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:38035 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752700Ab2GJJw4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 05:52:56 -0400
Received: from dhcp181.math.nat.tu-bs.de ([134.169.53.181]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1SoX7l-0000Fd-RH; Tue, 10 Jul 2012 11:52:53 +0200
In-Reply-To: <7vd344k1ag.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1280)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341913976;472c9ff4;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201258>


On 10.07.2012, at 00:38, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> But all in all, I don't understand why this order independence
>> seems to be so important?
> 
> Not so important as long as it is made clear for later people to
> patch that part of the code.  I just wanted to make sure that
> somebody thought hard enough to judge that it is not worth the
> effort to make it independent of the orders with a justification
> better than that simply we are too lazy to do so ;-).

Understood ;). Well, in any case, I'll create a new patch based on your feedback. (And also for the revisions.txt docs, from that other thread), but this week I am extra busy at work, so it might take me a day or two longer, sorry.

Max
