From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Thu, 26 Jun 2008 11:55:46 -0400
Message-ID: <32541b130806260855o691d444bpc0843e5f51639430@mail.gmail.com>
References: <20080624222105.GA24549@dervierte>
	 <7vwskea2ik.fsf@gitster.siamese.dyndns.org>
	 <48620C1A.6000509@panasas.com>
	 <alpine.DEB.1.00.0806251109380.9925@racer>
	 <486220CE.3070103@viscovery.net>
	 <alpine.DEB.1.00.0806251334060.9925@racer>
	 <20080625135100.GF20361@mit.edu>
	 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
	 <20080626115550.GA23058@atjola.homenet>
	 <alpine.DEB.1.00.0806261306060.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Theodore Tso" <tytso@mit.edu>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 26 17:57:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBtq4-00031c-5g
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 17:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYFZPzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 11:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYFZPzt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 11:55:49 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:10922 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYFZPzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 11:55:48 -0400
Received: by fk-out-0910.google.com with SMTP id 18so79751fkq.5
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eaCOwWNMzt/oD6/NZDFZaViqREcnO0OAk0iJBfhK6/Y=;
        b=S24HG6YyZy8lB3aFNuK/vZxaeF49MXnXz4JZdr1PtaPFZCCZMuQsxS/t47J7rgPkCS
         mnfgZxcGzqD7DtzyDnwfwrAIZLkUGYXk6KStu8Sv5WJ0ON3iVWdwliaDsm00CflSD0qX
         wMx/EBK69fCyB1mWrsz49E4Iphq393ffg+L6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YzvXHjeFzazyO5doCLIuao7T9hmL9MuQprXh8rd7lv24LJlX4znnNGe2eyW4KfBdlP
         L85oqa+feklz69ifaLludS08hwolyZ4Gmk9P+fQX4TOk5bWTkQVvV6xzrgbYPvu+MPDb
         0uM0GsaAEISu3NpsAOJaKiarvdfawNtFlNTL8=
Received: by 10.82.165.5 with SMTP id n5mr1170bue.84.1214495746620;
        Thu, 26 Jun 2008 08:55:46 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Thu, 26 Jun 2008 08:55:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806261306060.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86458>

On 6/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> While we are nit-picking: Ted's version does not respect autocrlf, while
>  Junio's does.

Is it intentional that git-show doesn't respect autocrlf, or just an oversight?

Avery
