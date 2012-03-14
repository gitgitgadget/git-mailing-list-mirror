From: Jon Jensen <jon@endpoint.com>
Subject: Re: [PATCH/RFC 0/2] post-receive-email: declaring and consistently
 using one output encoding
Date: Wed, 14 Mar 2012 11:54:50 -0600 (MDT)
Message-ID: <alpine.LFD.2.02.1203141153460.4355@fnzzl>
References: <20120308115119.GA2604@burratino> <7v62eeewl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Gerrit Pape <pape@smarden.org>,
	Alexey Shumkin <zapped@mail.ru>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7soy-0007Fs-PA
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab2CNSVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 14:21:09 -0400
Received: from mail.endcrypt.com ([74.205.105.202]:41682 "EHLO
	mail.endcrypt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384Ab2CNSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 14:21:07 -0400
X-Greylist: delayed 1574 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Mar 2012 14:21:07 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id CCA84302A3;
	Wed, 14 Mar 2012 17:54:50 +0000 (UTC)
X-Boson: 1506598
In-Reply-To: <7v62eeewl8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193142>

On Thu, 8 Mar 2012, Junio C Hamano wrote:

>> Patches are targetted at 1.7.11 unless there is overwhelming interest 
>> in them landing sooner.
>
> Even if there is none, I wouldn't mind taking it for 1.7.10, if only to 
> reduce the chance that the patch gets forgotten again, provided that 
> there is a clear concensus that this is a good change that won't regress 
> people who have been actually using this sample in real life.

+1 from me. This would solve an occasional problem we have because 
encodings aren't set in post-receive-email output.

Jon
