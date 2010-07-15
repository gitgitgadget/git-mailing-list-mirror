From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] Add treap implementation
Date: Thu, 15 Jul 2010 14:09:02 -0500
Message-ID: <20100715190902.GB2774@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:10:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZToy-0002TH-MP
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934398Ab0GOTKB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 15:10:01 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60852 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934274Ab0GOTKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:10:00 -0400
Received: by ewy23 with SMTP id 23so359118ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8YpE79x/3H10U/Xu5gmsU3Npc7pmWiKg5RO6rX+Mbuc=;
        b=YIm+ogmosajgFUDBt3DEO3drvvTy6ysmc6OMFHK/LmsLxv95KDQENZVgTMi+cp45n0
         0PgHZCjL4FzPi8IDYj2Jn4jbIwR3zM+R8EKDnQD/Pz7s7uiwsuyBzBfVhkVk/cczXut3
         raJel9egkw55IwyKekxYVfZ0f3A8pB8FPAd8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LbuH9hWpmBoN91YhDZkO3CduwCleSiBsBc1LtoCG9d7S/VA0i4vRuW/yDXKCl7RH7w
         E2rpn71TLXHPpUUIvrhoeuR4hxze0aESELVD89G+D6E9L1KUxQ9MkMzYihKneZQZ/mbp
         6Hb1MBHRu1pXonxiDNsuiksrdD1thQufQ1hOc=
Received: by 10.213.19.67 with SMTP id z3mr3195687eba.64.1279220994689;
        Thu, 15 Jul 2010 12:09:54 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a48sm10561410eei.12.2010.07.15.12.09.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:09:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151110>

Ramkumar Ramachandra wrote:

> Treaps provide a memory-efficient binary search tree structure.
> Insertion/deletion/search are about as about as fast in the average
> case as red-black trees and the chances of worst-case behavior are
> vanishingly small, thanks to (pseudo-)randomness.  The bad worst-case
> behavior is a small price to pay, given that treaps are much simpler
> to implement.

I still haven=E2=80=99t checked this implementation in detail, but it s=
eemed
to work in practice and is about to change anyway.

I like the documentation updates.  What else changed from the
previous round?
