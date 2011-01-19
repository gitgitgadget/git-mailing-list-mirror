From: "Aaron S. Meurer" <asmeurer@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Wed, 19 Jan 2011 12:15:15 -0700
Message-ID: <0F4E18EC-E67D-4C3E-BB5C-C8D8BA326C1D@gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com> <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com> <54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com> <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com> <7vd3nukqn8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:15:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfdVA-0003xI-G2
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab1ASTPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:15:23 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:48641 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab1ASTPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:15:22 -0500
Received: by pxi15 with SMTP id 15so216581pxi.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=4uow3UVswvZN5IqMJMzGz/Z04Nl7iYGyi7ESg5zJma8=;
        b=MPz8/0dsBpW37K0pfETXsLt5IUgYvKvlnmh8592PcasFW7HF+naQgiJ9i43GVDM8Bv
         E0gjyZdl1sZDKn7TXY2o/iDaAEnA5hJK8GV/30EQfiq138sVm9nncCkOBFJXKQsIyFyN
         OB1X1tysqrN/A36vrUIbOLFp1f/wXfL0jVO48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=CzvoNIc1Ml3OykCK2OIzWGK9iCyOAXyj744diilwV6kWopmkCJeClKuWNSIGCH0N6P
         qubH7fV9IGkrVkWI+U1dDA0TZm9t6Y/zMPiuPLnjDIemvoCB33j4js0V64kz1ZO4GQqW
         N93mm18GhM9cPGWp4s+HLX2LtbjPLCJDjGEuM=
Received: by 10.142.51.7 with SMTP id y7mr1076058wfy.358.1295464522412;
        Wed, 19 Jan 2011 11:15:22 -0800 (PST)
Received: from [192.168.2.3] (dhcp-baca-230.resnet.nmt.edu [129.138.31.230])
        by mx.google.com with ESMTPS id x18sm9971066wfa.23.2011.01.19.11.15.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:15:20 -0800 (PST)
In-Reply-To: <7vd3nukqn8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165278>

So if I care about this issue I should keep bumping it until it gets fixed?

Aaron Meurer

On Jan 18, 2011, at 11:34 AM, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
>> Well, bugs are usually fixed within days after they have been
>> reported. Otherwise they are usually documented in the code or in the
>> documentation or in the test suite (with test_expect_failure).
>> 
>> For the rest we rely on people remembering what happened and on
>> people's mailing list searching skills ;-)
> 
> Not really.
> 
> What we do is to take advantage of the fact that issues people do care
> about are important ones, and others that nobody cares about are not worth
> pursuing.
> 
> In a sense, "people forgetting" is a lot more important than "people
> remembering" to filter unimportant issues (issues that are so unimportant
> that even the original complainer does not bother to come back and
> re-raise it).
