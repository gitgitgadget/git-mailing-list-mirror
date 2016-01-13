From: Richard Maw <richard.maw@codethink.co.uk>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Wed, 13 Jan 2016 17:43:32 +0000
Message-ID: <20160113174331.GI3397@logi.codethink.co.uk>
References: <20160107165417.GB3397@logi.codethink.co.uk>
 <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
 <xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
 <20160111155153.GE3397@logi.codethink.co.uk>
 <xmqqy4butzw8.fsf@gitster.mtv.corp.google.com>
 <20160113113743.GF3397@logi.codethink.co.uk>
 <xmqqlh7tpfkt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:43:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPSQ-0001fu-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbcAMRni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:43:38 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:55201 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbcAMRnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:43:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id E84EE460D07;
	Wed, 13 Jan 2016 17:43:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i8BVznFh6W5U; Wed, 13 Jan 2016 17:43:33 +0000 (GMT)
Received: from logi.codethink.co.uk (logi.dyn.ducie.codethink.co.uk [10.24.1.141])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id A52D3460B6D;
	Wed, 13 Jan 2016 17:43:33 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqlh7tpfkt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283954>

On Wed, Jan 13, 2016 at 09:14:10AM -0800, Junio C Hamano wrote:
> Richard Maw <richard.maw@codethink.co.uk> writes:
> 
> > 1.  Before any "want" requests.
> >
> >     This would also let you extend ls-remote to let it display ancestry.
> >
> >     This is complicated by the fact that normally the client responds
> >     with which features it supports in the first "want",
> >     so the sender would have to support "check-ff N O <FEATURES>"
> >     if it advertised "ancestry-check".
> 
> Yes, that sounds like a good thing.  Actually, ls-remote is a
> degenerated case of fetch that sends 0 "want" requests, so the above
> may be identical to what I suggested in the message you are
> responding to.

Thanks. I've got a good idea of what I'd need to do now.
