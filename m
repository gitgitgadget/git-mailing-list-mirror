From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 15:30:40 +0200
Message-ID: <4BF14500.30806@drmicha.warpmail.net>
References: <878w7ieu4p.fsf@thor.thematica.it>	<4BF12C96.9030802@drmicha.warpmail.net> <buofx1qhgum.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon May 17 15:31:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE0Po-0007G2-UZ
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 15:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab0EQNbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 09:31:21 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34092 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753252Ab0EQNbT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 09:31:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 888B2F65DB;
	Mon, 17 May 2010 09:30:34 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 May 2010 09:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=E8cZuvIIzCYmAtILtG7O6iht8P8=; b=keUkjvP29p81n3YbrVpQRDYZJXaQk4pEGOZlTVwfAuhz6Y5NLKfmaPHoqm43di4Mpjg37Zs6M+/JL8YeD64GLaxU69Af56+eVuJ9oVvMY1o5QrjOVyIcqT6vLbU1rsmYtG4OKkhQmhtxoRciJg21S58sl1Ry9/01me+qG4SQEmw=
X-Sasl-enc: m/rDZy/dqXk3i9XjMkMnohNBrOV2a01ADEIzZjf9Lg0F 1274103033
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0229B4D499;
	Mon, 17 May 2010 09:30:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <buofx1qhgum.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147234>

Miles Bader venit, vidit, dixit 17.05.2010 14:07:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> Now, usage messages are displayed on specific request (-h) as well as
>> when a command is used with wrong arguments. So the classification
>> depends on the use case! But I reckon that even with '-h', usage strings
>> are not exactly "regular output", so stderr looks more natural to me.
> 
> Usage info specifically requested by the user is not error output, it is
> the output of the command.  It should be output to stdout, not stderr.

Well sure it is, just as I wrote. So do you suggest that the file handle
should depend on the use case? Care to implement?

> [Note that for GNU progs, this behavior is explicitly required by the
> GNU coding standards, and I think it's a pretty reasonable rule.]

Fortunately, Git is not GNU software.

Michael
