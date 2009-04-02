From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Thu, 02 Apr 2009 19:17:45 -0400
Message-ID: <49D54799.9010607@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org> <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 01:19:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpWBv-0007om-E0
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 01:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284AbZDBXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbZDBXRv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 19:17:51 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:9468 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZDBXRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 19:17:49 -0400
Received: by an-out-0708.google.com with SMTP id d14so629885and.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3mp8LdRXDClgywW7tFb2iZweQdyXiFMSsBEI2n85CfE=;
        b=qCqvAJk1IYdVUjvljY346WcfH608JkC35hM9obZVRnAqfGXMk/UaK2NMw1MsxJ0E6T
         +kHXP1zNxa95SAgZrVNMQ82r7lAIM564xbsYrh3W5DS0huXhk8qjJFVcdVPSw3OOlgOi
         j8A2V/DYaBx/Xf/YTwkVlRcTuHnNXp7vwKPwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=sOcySX4wgCsQIu7+uNMqjwtEEjPxoRweQqARkTOEmY6xGGVaZYTK0+fkrPMqS8ypOh
         B2F0QCrvDFtA3JWnsRQthoP5GIOhYjpVF0T2bl5sIJ+RcRTSwU9iXzjJuBIQNZm/qnFg
         PZw8kM9TTxAymi4qu4q/zz5352O5VrTAsgZgg=
Received: by 10.100.178.9 with SMTP id a9mr1039226anf.116.1238714267358;
        Thu, 02 Apr 2009 16:17:47 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id c9sm4681130ana.13.2009.04.02.16.17.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 16:17:47 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115505>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 2 Apr 2009, A Large Angry SCM wrote:
> 
>> Junio C Hamano wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>>> What part of the email address is this going to lowercase? Only the
>>>>> domain
>>>>> name is case agnostic.
>>> That is my understanding of RFC, too.  Let's see where this mail goes to
>>> find out how much more lenient the real world is ;-).
>>>
>>>
>> Many email providers/servers are lenient when it comes to case in the 
>> local part of an email address (after all, they control the 
>> interpretation) but not every provider/server is and the RFC is VERY 
>> clear on this issue.
> 
> And in one of my projects it is _very_ clear that this strict 
> interpretation of the RFC, which does not matter in reality, _actively_ 
> _hurts_.

Care to provide actual justification for that statement.

> In the alternative, can I ask you to adjust my .mailmap in your free time?

_Your_ .mailmap file is your issue.

So which standards do you choose to follow and which do you choose to 
ignore?
