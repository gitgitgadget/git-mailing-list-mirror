From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: Fix for normalization of foreign idents
Date: Tue, 24 Aug 2010 09:23:55 +0200
Message-ID: <yf9r5ho79tg.fsf@chiyo.mc.pp.se>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
	<20100823213531.GD2120@burratino> <yf97hjhrol5.fsf@chiyo.mc.pp.se>
	<20100823223321.GE1308@burratino>
	<7vd3t8zyc0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 09:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onnrb-0000p3-KU
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab0HXHYC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 03:24:02 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:45793 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0HXHYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 03:24:01 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id A0B22FB34;
	Tue, 24 Aug 2010 09:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1282634638; bh=3uweh2nY0oEyVYlVdfTY8X6DpyqRfEfPqvhZzK2z/UU=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UvDQ7EPB8u+W+w91vexbwqrMJpaxqO3rxu2ke
	GxRxxSQll31/9vSb7KQcZtYLfUMtYY/DJXRw9MmaEw95nGPRLlwDrHHC58uOcdkENvd
	CgdEH4CQYNHwyfz9C3OjicKG2HwHFQsmMa7vrzB6GJfiQjj2DRfUuievMUiE80XO6zw
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1OnnrR-00037u-1t; Tue, 24 Aug 2010 09:23:57 +0200
In-Reply-To: <7vd3t8zyc0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon, 23 Aug 2010 16:46:55 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154302>


Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>> No, I don't use the $Id$ feature at all and if I inherited a codebase
>> with a bunch of foreign $Id$ tags, I don't know what I'd do.
>
> Heh, I know what I would do---the first commit will be to remove them.


Remove just the foreign ident, or remove $Id$ completely?

Either way, this doesn't sound like a vote for preserving the old $Id$
expansion on commit.  :-)


  // Marcus
