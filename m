X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (take 3)] gitweb: Add some mod_perl specific support
Date: Sat, 16 Dec 2006 21:03:17 +0100
Message-ID: <200612162103.18695.jnareb@gmail.com>
References: <11662174851575-git-send-email-jnareb@gmail.com> <11662855752162-git-send-email-jnareb@gmail.com> <7virgbei6z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 20:03:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Oz3HDJbZiXcvc/94BevgCqszMXsA1dOJat3MLv6T5BTyf62xHouqArZMm/GLy/Y6veLz1rkc3o9MQEc2UPtlv7KUOzqi+tELiStlqoUOwjMvZEjNuPAJYJt+CEN7ya7EY0ZlnQKfj+pe8HNkdRQoo4bgVIznMbUrA8qODdP4bAE=
User-Agent: KMail/1.9.3
In-Reply-To: <7virgbei6z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34638>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvfkq-00085b-NO for gcvg-git@gmane.org; Sat, 16 Dec
 2006 21:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161449AbWLPUD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 15:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161450AbWLPUD3
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 15:03:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:27147 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161449AbWLPUD2 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 15:03:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1148994uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 12:03:26 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr2197799ugl.1166299406668; Sat, 16
 Dec 2006 12:03:26 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id s1sm5389143uge.2006.12.16.12.03.22; Sat, 16 Dec
 2006 12:03:26 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> I have your (take 2) merged already last night in my tree but
> haven't pushed the result out.  Does this replace it?

Yes, that replaces it. I'm very sorry for the confusion.

I have noticed that I would need to add "use Apache2::RequestRec"
or it's mod_perl 1.0 equivalent before I can use $r->path_info().
-- 
Jakub Narebski
