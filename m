From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 18:43:34 +0100
Message-ID: <C66AC756.2064B%jefferis@gmail.com>
References: <7viqijszjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKFSp-0006bb-9K
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZFZRnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 13:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbZFZRnj
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 13:43:39 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:62671 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZFZRni (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 13:43:38 -0400
Received: by ewy6 with SMTP id 6so3595051ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version
         :content-type:content-transfer-encoding;
        bh=aPVJccEwaGMI/qSehoFsT2gyU5rj2IUAN7ILf+KyWbI=;
        b=k5PBbBFOIAX4oDML2znm2JBptbuBELGvh2YyppNJHDyOypxymBOqs1aeJ39eT0rgjO
         Ej9kz4UDc+ohNPt2u97/Etxb2nVt3fgD7vAHGg0lF43JfCc8K1gmfUeYksiD+q6mVzbt
         vvKEL0hUe26vlObh9J+X1Ol081X5qmoOTyZqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :thread-index:in-reply-to:mime-version:content-type
         :content-transfer-encoding;
        b=MQV7P3QLnIKUht1cUGspBslFY3KyZqSNuj9/5UsSlNUytAXdEUapBPvLCvf336Ctst
         7zxHiKjax5tjI0EdkRNeaEgaEsdX2GW6XcSsNdm/V6KZPrzVrY57bPoqIsmdOkl7y4dP
         1+Itf3WEhcTGySb//DCtk1rnRzNfqbkSkMmzo=
Received: by 10.210.58.17 with SMTP id g17mr4670774eba.1.1246038220480;
        Fri, 26 Jun 2009 10:43:40 -0700 (PDT)
Received: from ?10.6.0.183? (nat.mrc-lmb.cam.ac.uk [131.111.85.79])
        by mx.google.com with ESMTPS id 5sm486738eyh.50.2009.06.26.10.43.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 10:43:39 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.13.0.080930
Thread-Topic: Choosing a mergetool according to file type
Thread-Index: Acn2haB2+EW+tGDwd0+dkLRSM+FxKg==
In-Reply-To: <7viqijszjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122311>

On 2009-06-26 17:57, "Junio C Hamano" <gitster@pobox.com> wrote:

> You are both correct.  Your example runs "gedit" with three files before
> merge.  If Gregory's custom mergetool expects the failed half-merge result
> as its input, this is not the interface he is looking for.

I think that Matthieu is more correct this time in that I can do what I need
with the merge driver because I don't need the failed half-merge result.
But I prefer the 2 level arrangement of 1) automatic then 2) fixing merge
conflicts manually since there will be other cases where this is required.

Thank you Junio for pointing out how to do add the necessary functionality -
a project for a rainy weekend I guess.

Best,

Greg.
