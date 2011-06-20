From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 17:48:28 -0500
Message-ID: <20110620224827.GC695@elie>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org>
 <20110620223156.GA695@elie>
 <20110620223705.GG32765@one.firstfloor.org>
 <20110620224619.GB695@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYnGv-0005D6-0M
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab1FTWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:48:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39724 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281Ab1FTWsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:48:32 -0400
Received: by iwn6 with SMTP id 6so1585543iwn.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VfpytrscPlAvVr4S4LTA64jyqbj2smsqdJtVkVWNHOw=;
        b=pZqEz8767K5HA/dKfV1i4NzJAABL0UOjd6WU/cLeTUXM89l1OCDnFUrOazd1lMLtvO
         ZhzpcU8i0EFYaC/dI3W+fp4mHTvd94Msb6RZ31YpMgW+iHBYvHSE4xWHGcpFXdrL2ETa
         zvojQpEwsKrg/pTFkh44fVs8SoPYTtromDRwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gHKr0BRRmvB92CQUnsd2tAVRyNUAUCacaFVqMtAGr/Ws3rSxaxzEWDrn0EFILYRJtH
         yejIgFo823RPt1CLhnxvdsGR1a+vu8n24oYjTam+GtyjjIuB2MnsDiH9i/AJrgaGoe/z
         9Jx9QzMB8XsoxyaAFMGvY0jIcZnyW5Nufo6qE=
Received: by 10.42.174.69 with SMTP id u5mr6311423icz.381.1308610111805;
        Mon, 20 Jun 2011 15:48:31 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id f13sm2936758ibe.44.2011.06.20.15.48.30
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 15:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110620224619.GB695@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176107>

Jonathan Nieder wrote:

> Even worse, if someone removes a die() call and introduces
> a bug, we lose the benefit of the warnings you are suppressing.

(Scratch that part --- I don't know what I was thinking.  Will
think more carefully before hitting "send" next time.)
