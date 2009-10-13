From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Mon, 12 Oct 2009 17:31:52 -0700
Message-ID: <4AD3CA78.6090209@gmail.com>
References: <1255328340-28449-1-git-send-email-bebarino@gmail.com> <7vy6ng5gdr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 02:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxVQL-00013h-G0
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 02:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbZJMAdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 20:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbZJMAdG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 20:33:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:51952 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbZJMAdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 20:33:04 -0400
Received: by ey-out-2122.google.com with SMTP id 4so2029812eyf.19
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=EUw1Dan3YGYs8ibnxljSUXetM0Wf946M5EkBEWdrGvM=;
        b=C7I5vjuRDh+xeJZlPl7qUx8LH7m0JQH2Gl9r58s7mAIwCmtlOutIw223fPhKPwFWxm
         sUIWANauV40Z+DwK56K70bpcEPh0NVyvX4JAhN5pO7DkwF+BPQClocmdZQzc1L7Gi35h
         1m2hnSEaSsLbtzhIublkCbPJO5t694rKJjBzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ibS0AKWkarXn6fWKp5QeuPccKcTL/n6vJJXGAGc6ZS2remVaEv+AIPFt4w50rN29uZ
         m1jZ3dviuIniiZtV7RSPJEAwKqxY2X2hTY6FvVdLB4GPsvzEqeAkbxlulrZxp4xxU/LM
         o3kbvq4fKe55bnLjltDqU4aIRCnjdPE2g/CgI=
Received: by 10.216.85.144 with SMTP id u16mr2100473wee.3.1255393916975;
        Mon, 12 Oct 2009 17:31:56 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id u14sm1267521gvf.3.2009.10.12.17.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 17:31:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <7vy6ng5gdr.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130099>

Junio C Hamano wrote:
>
> The intent makes sense to me, although I somehow suspect that with avatar
> support the user might be tempted to click on the icon not necessarily on
> the name string.

Ok if the utf8 thing can be solved I'll make sure to linkify the icon too.
