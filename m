From: Nick <oinksocket@letterboxes.org>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Tue, 27 Oct 2015 10:50:44 +0000
Message-ID: <562F5704.5070405@letterboxes.org>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: John Smith <johsmi9933@inbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 11:50:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr1qD-0001uG-NJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 11:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbbJ0Kuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 06:50:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51682 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754018AbbJ0Kux (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 06:50:53 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 609BF201EB
	for <git@vger.kernel.org>; Tue, 27 Oct 2015 06:50:50 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 27 Oct 2015 06:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=letterboxes.org;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=vM61rBXfZLRNctQXbIy7aey+XAE=; b=iQivy0
	m/L71n1jwruRayg+RcONAXoFbzjsrmAgu+wgboQrzvQgSZBGRHvmksCYzZ3I9iQA
	TSG/Xn3FUAW4VKawe9qZXWByswynw7dE0KjGbvY2Vj9GXN3MbpKipoSAFt1KKg/n
	rlXUXcZE5GJnoG1qnVhVFyLQ6jneXx18UC5qU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=vM61rBXfZLRNctQ
	XbIy7aey+XAE=; b=EnMuhmvS5VD4yrszfiAEI3poA7Nm1/2drJq6LFU3HXkV+rF
	im5ZT76rjcfiOp3GUQAkfn4LTfO1dMadf8wOtmVu2gSBMIK38sZ6GzhP38yhAAuU
	NMUWYw0mwOp2kh/qOlQUzyWB4z+VRp0dQrqcy9NyYllDJKoRPKwfkSgQwJRk=
X-Sasl-enc: Zo0IIq0l3wNgEskwxSjH1yQrvdRpyejRJp6TR732TPcn 1445943050
Received: from [192.168.69.14] (unknown [31.216.5.136])
	by mail.messagingengine.com (Postfix) with ESMTPA id DC03DC0001E;
	Tue, 27 Oct 2015 06:50:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280258>

I too am interested in finding ways to automate working with submodules, 
as it's a particular pain point with my colleagues.  They frequently 
shoot themselves in the foot trying to branch and merge a project with 
submodules, resulting in a broken build and grumpy comments about git 
(or possibly about me, as the "Git Advocate").  And they're right, it is 
awkward.

Whether or not any sensible default configuration exists, users do need 
a way to avoid excessively complicated workflows, or people are just 
going to avoid using submodules, or perhaps Git. Hand-rolled solutions 
might be better than nothing, but I would expect that this is a common 
issue which would benefit from a built-in solution.  For instance, so 
that one can branch and merge the whole project without duplicating the 
work for each submodule.

Am I correct in thinking there isn't anything which does these kind of 
things yet?

Thanks!

Nick
