From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Use git-update-ref to update a ref during commit in git-cvsserver
Date: Wed, 21 Feb 2007 09:08:54 +0000
Message-ID: <200702210908.59579.andyparkins@gmail.com>
References: <200702200857.02779.andyparkins@gmail.com> <200702202010.02128.andyparkins@gmail.com> <7vmz38t5r4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 10:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJnTP-0000St-L4
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 10:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbXBUJJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 04:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbXBUJJK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 04:09:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:27713 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161135AbXBUJJH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 04:09:07 -0500
Received: by nf-out-0910.google.com with SMTP id o25so150649nfa
        for <git@vger.kernel.org>; Wed, 21 Feb 2007 01:09:06 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KjhWbdPsXTAOgPC4zNb+eRCCkWpD3IDGQSAm6ORdGpi9pq+ficdi1oVF7577sQl5inlveWo5ewuH0YYaEQj7yxMixP9NWIcMK+r3ssL8mjS31+LhO/Pz/I1FwZ/ZlFwv34N8YVc1ufANeWSL4DK+t7WWSDMvqToFdolaiRxbyLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X60J47OWJuFHGC/xi37PWMxPlatUZWvvhhMOWY+rjEt8+EO5mgLcnQYw6J3uESdgYXsz+RqxEcOG/2+m9mfwhuLMl/lpbkUmiQZzFFw1yp7UDpe7rx+R3DwilZ4skAu80fUkRdRafmeufNvf+IQNUhq8JoTyN/cqCxHHhpmIEak=
Received: by 10.49.94.18 with SMTP id w18mr898983nfl.1172048946562;
        Wed, 21 Feb 2007 01:09:06 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id r34sm1693098nfc.2007.02.21.01.09.04;
        Wed, 21 Feb 2007 01:09:04 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz38t5r4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40290>

On Wednesday 2007 February 21 05:54, Junio C Hamano wrote:

> This makes "ci" codepath lockless by following the usual
> "remember the tip, do your thing, then compare and swap at the
> end" update pattern using update-ref.  Incidentally, by updating

Looks much better than mine (obviously).  I'll run it for a few days and 
report back.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
