From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: Is it possible to roll back unstaged changes while leaving the staged ones for the next commit?
Date: Wed, 17 Dec 2008 20:22:17 -0500
Message-ID: <c115fd3c0812171722g93dbeefw2fb5bf7641dfe394@mail.gmail.com>
References: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
	 <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812171448o3db6f4c1oc24e39f9a68ed1d3@mail.gmail.com>
	 <7vbpvajtmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 02:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD7c1-00016j-L7
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 02:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbYLRBWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 20:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbYLRBWT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 20:22:19 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:30548 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbYLRBWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 20:22:18 -0500
Received: by yx-out-2324.google.com with SMTP id 8so83563yxm.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 17:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aum/qR8uWwaDgizPV2XEmlvqbRdA7JHE36bPy9Oyir8=;
        b=nJA/KVb/kZRk4PCSq3tlIOQoUm+3+iGjQLEqKRJIBBRyFFbge1yeI6YjYHaTIULzF1
         Eu0n/Zmf2Bk9sBnqM1CF2pwivZ8SsnfuxYh/PqlE2/TcwRQGN1im9yBeOaPlQkj/xRYS
         dyWpefKUyhVu+36gh0zYC3E3uw7Gi/ZlV2uFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VblDtSTMKQl6V6dHbMgte8q8sFtUFOO4WB+KQSRmrcEoB2ex83mCf6ROtA+KxipI5n
         Y/XgbkOz7NrGPheOyPeV4bgefHA58NIluicqMKLk7BfKQTDMQSoSmfiBd3LeuZpg2D/0
         Bsi+FIxvS3VjYviC9on9BIELisLIG7fJxaUVI=
Received: by 10.100.5.15 with SMTP id 15mr1100580ane.50.1229563337488;
        Wed, 17 Dec 2008 17:22:17 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Wed, 17 Dec 2008 17:22:17 -0800 (PST)
In-Reply-To: <7vbpvajtmd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103418>

On Wed, Dec 17, 2008 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> How about omitting the "git commit" and do "git checkout PATH" after you
> are done with the staging?  IOW, (1) above.

Huh.  I guess I was under the impression that doing the `git checkout
PATH` would destroy the staged content as well as the unstaged.  This
isn't the case?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
