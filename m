From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 12:58:38 -0600
Message-ID: <20091127185838.GA3602@progeny.tock>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
 <20091127065904.GE20844@coredump.intra.peff.net>
 <20091127144553.GA24366@progeny.tock>
 <7vvdgvn7ny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:46:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5qE-0004t0-9O
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbZK0Sq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbZK0Sq3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:46:29 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:41048 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZK0Sq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:46:29 -0500
Received: by ywh12 with SMTP id 12so1904069ywh.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/Gf/OdlzYl9IlOeYbpAX3Mazkq1YiRuZ4S+W/sumEcU=;
        b=PFjHNWHtGCdtVwZ/jiMw6URkQOsfYSSthcDoA7TnJgx6thYen5UecKYnRaTjL63mcJ
         4Ejxfeh/P351FW0TAOWhOve3nd9kekuYZg8EUiBsATIwWqPLBxv1BsTbgDGaC/AGLjYT
         o4ZXVuQqCedFnuCx19nW09A1/Kh+HI+H86xmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hCMLMlZzOeNG26mtjPTOEQjIRF4CVSf8EvbgsmXMrJCaHsreg+ayjtGWqADDQY2zkQ
         J+SITEOzWdBYYoMMbiV7YAQtTadpF7ZQ5pB8y87krekZ/B0aceq5EFAIhJrQv5MaCB08
         WYn/elloyQJX3XEhDTVjuXUADAdWH+t6gSDt4=
Received: by 10.101.147.27 with SMTP id z27mr715497ann.22.1259347593828;
        Fri, 27 Nov 2009 10:46:33 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm926648yxh.58.2009.11.27.10.46.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 10:46:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvdgvn7ny.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133923>

Junio C Hamano wrote:

> The flipping of "grep" default is too late for 1.7.0, as we have only
> started discussing it, and I want the release after 1.6.6 to be 1.7.0=
=2E

Yes, I=E2=80=99m sorry I suggested it.  I think you had mentioned this =
plan
before, but somehow it escaped my mind.
