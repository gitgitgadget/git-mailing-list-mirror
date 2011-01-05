From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [RFC][PATCH] git-send-email: added support for S/MIME
Date: Wed, 5 Jan 2011 10:22:02 +0100
Message-ID: <201101051022.02854.roberto.sassu@polito.it>
References: <1294156930-21367-1-git-send-email-roberto.sassu@polito.it> <201101042036.36208.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 10:22:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaPZc-00029x-6N
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 10:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab1AEJWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 04:22:10 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40832 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429Ab1AEJWI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 04:22:08 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4E06D2087A;
	Wed,  5 Jan 2011 04:22:08 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 05 Jan 2011 04:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id; s=smtpout; bh=RVEEOV/aSs49XXVOHAK4qTQLkAc=; b=luuD/ob57fqMOm4M2DC0PpMmMkS7sQc4zwShd08+/2n/8fNQS5XQ/C4z4tpZXaceFaR/RIn3FPkhdX5DtCAL2VN9PqEHLMlHEMXH/g2OEd0BIYyCjTKble6v81OZBcR1TbfOoa5mjPwkuHQYKarWn9vzRvHqMT84z26YEH+tecU=
X-Sasl-enc: 6knvUuGELdM8pSDeHve5mLZRRclCDdffYIs5BDyBS/Kl 1294219328
Received: from h2clo7.fastwebnet.it (93-38-171-154.ip71.fastwebnet.it [93.38.171.154])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0CF9B403383;
	Wed,  5 Jan 2011 04:22:08 -0500 (EST)
User-Agent: KMail/1.13.5 (Linux/2.6.35.10-74.fc14.i686.PAE; KDE/4.5.4; i686; ; )
In-Reply-To: <201101042036.36208.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164558>

Hi Thomas

On Tuesday, January 04, 2011 08:36:36 pm Thomas Rast wrote:
> Roberto Sassu wrote:
> > The script git-send-email.perl has been modified in order to add support
> > for messages with S/MIME format.
> 
> Does git-am need symmetric support to decode the message?

I think git-am does not require any modification on the code,
because it already supports emails with Content-Type
'multipart'. One example comes from git-format-patch which
can generate patches with this format by adding the option
'--attach'.

Regards

Roberto Sassu
