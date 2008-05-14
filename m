From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Wed, 14 May 2008 21:40:44 +0200
Message-ID: <482B403C.5060101@gnu.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org> <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org> <7vve1yzgfc.fsf@gitster.siamese.dyndns.org> <482018E4.9000908@gnu.org> <482B0354.2060207@gnu.org> <7vhcd0oiov.fsf@gitster.siamese.dyndns.org> <482B3854.9040906@gnu.org> <7vod78n10h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwMrJ-0004Ga-S8
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379AbYENTlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755850AbYENTlA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:41:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:19335 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYENTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:40:59 -0400
Received: by fk-out-0910.google.com with SMTP id 18so42506fkq.5
        for <git@vger.kernel.org>; Wed, 14 May 2008 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=5utX+ruxaWMqCuexzg8YDGG0Z1a9H9h+vJs6c/yD3J0=;
        b=gbG99F3DnJ98xy5cep3wHILcxDnqOp6ZxH97mLmBjptKsRG1tmZdYJZgpS970RimzcK26eZ3btRDOG4wkKHMZvTA0IPmy2djOx8cuAkjZ98o62+/n7DNiz56TBPfueab3W7ytQ8YHpcS0aErlOEfOabAuWynIYTv2D9qTwFs30U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=s99ouawnTVXo1ocYXFM7+cBOmSDEZDkygtKa64DLn8zeDH+/P7m76mLNUjLb+cpaaIVUNpsMa41ihYA7tob/MZltQNakOjBRrpJWp1CgfQ+aXQyX7fLRp0ujJmU4A4oUoVXXz/lVXVwFq9WkR9mPiah11m4J9xO/mA8MzZHq9G0=
Received: by 10.124.68.24 with SMTP id q24mr770529mka.162.1210794054707;
        Wed, 14 May 2008 12:40:54 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l12sm2011027fgb.8.2008.05.14.12.40.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 12:40:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vod78n10h.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82139>


> I think we are in agreement and that is all the more reason we have to be
> extremely careful not to introduce incompatibility without a clear
> advantage.  The commands involved with your patch work with or without the
> new default entry in the config created by the clone exactly the same way,
> and the versions before your patch would choke with the new default entry.

Ok, this patch is (for now :-) withdrawn.  I think I'll punt and prepare 
something along the lines of "git remote push".  When I get to that, we 
can reconsider this patch too.

Paolo
