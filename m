From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] revert: refactor code that prints success or
 failure message
Date: Mon, 12 Jul 2010 20:27:33 +0200
Message-ID: <20100712182733.GD17630@debian>
References: <20100712115455.12251.53947.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNhR-00016r-NU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab0GLSZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:25:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46065 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0GLSZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:25:48 -0400
Received: by ewy23 with SMTP id 23so905047ewy.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HpNG3LOlksJbWlkdiHo7gK4j6X4aajga6hEszt2ftgc=;
        b=Xhh745ZZWKMEzYFpCWxRakWu14k+aKhdb9d/ue0M+/Z8OMuvi1QT1nlnYlkgnzbhMO
         tX1wUwBoj6F911sS5f7Ym0yA0dWfebcJAxnvmMr12uAnzb/FqEz26xpNEmDErXcrgPhz
         yBQafp1AgLyjWugpP6JEdUAxzPjPa0rJGVOjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=puWIsb+gzgYySCBHcSuvTFSpyeICGErMKKhMj7BKF8pDDT6X9Q2dEwFXVzJHo70ql7
         +KEhYBBL9WvrX50/NQwxAbvN7Z1x7vLwTEgdjn1QhVjcYBBcZm3aiJtJFden1XJjUm+7
         rA/S2ErD4bxUx09spAFwK5/X7chUUR8chmVHk=
Received: by 10.213.105.138 with SMTP id t10mr10232473ebo.77.1278959146913;
        Mon, 12 Jul 2010 11:25:46 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm39277690eei.12.2010.07.12.11.25.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 11:25:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100712115455.12251.53947.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150836>

Hi Christian,

Christian Couder writes:
> This patch refactors the code that prints a message like
> "Automatic cherry-pick failed. <help message>". This code was
[...]

This is good stuff. Can we expect the git-rebase--interactive.sh to be
refactored to use the "cherry pick a range" feature in future?

-- Ram
