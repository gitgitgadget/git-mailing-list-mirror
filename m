From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
	loop forever
Date: Tue, 31 Mar 2009 10:12:53 -0400
Message-ID: <76718490903310712w540205b4n3826d2d9277853fa@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <vpqd4bzjlk1.fsf@bauges.imag.fr>
	 <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
	 <vpqwsa7gjlh.fsf@bauges.imag.fr>
	 <76718490903300845x14897599jc73f50a16b21605d@mail.gmail.com>
	 <76718490903300904k7e8c1054m99edb92d8d582387@mail.gmail.com>
	 <vpqvdpq9gww.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Mar 31 16:14:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loejc-0000nX-3m
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 16:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbZCaOM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 10:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbZCaOM5
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 10:12:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:57241 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbZCaOM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 10:12:56 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2447305ywb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yia+/1sPteis/d2HbdVl/fDtEfbg5vHd6jne8ba2efw=;
        b=vlX7m+OYIS9dT9Lm8ldmA/CApdrKGVzHVS4EdancqO41DSJJsmMh6NTYnILsVyvyj4
         y7H2I0JVgk4HRqTkkX8jbkSuF16iY8Q7SW8PXIecmSM4HfO6TPAjFGWwOysHAv6ni58W
         buPWj5czBTWaUPLdv6J6HOeI/Hp0QmVih1Xxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wx2o5/PJogno+TXL1u4aM104Msbk8cOkgevIw6hv01QJQyqTT+ikjM6kQKfod0xbOV
         vgRjsfXQPc4OYrMi7c0fiZ4+KFfZwXak23nVsMZqXGlWynzm4umvsejfoYEJsLh1ciX+
         3MyCRPEHt6FodDSXkZ34BcDW7DBqsAzefCiQQ=
Received: by 10.150.199.16 with SMTP id w16mr12688738ybf.163.1238508773766; 
	Tue, 31 Mar 2009 07:12:53 -0700 (PDT)
In-Reply-To: <vpqvdpq9gww.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115262>

On Tue, Mar 31, 2009 at 5:32 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Actually, this seems to be a totally separate issue.

Argh, I need more sleep these days.

j.
