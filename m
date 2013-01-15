From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 06/14] imap-send.c: remove some unused fields from
 struct store
Date: Tue, 15 Jan 2013 14:59:27 -0800
Message-ID: <20130115225927.GE12524@google.com>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
 <1358237193-8887-7-git-send-email-mhagger@alum.mit.edu>
 <20130115203204.GA12524@google.com>
 <7vtxqi13ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFUV-0000wn-38
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934529Ab3AOW7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 17:59:33 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:39254 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934530Ab3AOW7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 17:59:32 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so257423dak.16
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zB9ISlsMWRYXBq33WxzhBbiH6F7nyILU7dV/C8iqhRc=;
        b=tEiOPEhalQYabJsKty9dcpsO0SSHTW1Ugae4WgjwbQFRMBUa7KeEFD+QEZL/WevSIB
         y06tm6Vk1JnY0B0MVYPawlvQSh3MzA49LkOh6VniyV4Oity+/46qtIWL7gRgzZBiA93v
         jiFqIxoBU4RkJacrTr+Esxe4EkfSVM7XYBKGmyXEX21SUJjH+2IsONPdK8sen2kPWRNT
         wMFKAv4PuQaskGgo5kKEli3/1WjrpI9gbNSs7WSdyzPoukKu2zXv0TLjLBHA0tdjX/fw
         MSMH17nlfhTD04IWpwCoOjffvxZ/TmSwr2AbPvY2J9O23eQd1saVzgjGfhVZq0sgdsvA
         u68A==
X-Received: by 10.68.228.2 with SMTP id se2mr272634859pbc.93.1358290771482;
        Tue, 15 Jan 2013 14:59:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id sk1sm10987785pbc.0.2013.01.15.14.59.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 14:59:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtxqi13ks.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213684>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Since actually fixing that is probably too aggressive for this patch,
>> how about a FIXME comment like the following?
[...]
> Hmph; it seems that it is not worth rerolling the whole thing only
> for this, so let me squash this in, replacing the /* unused */ with
> the large comment, and then merge the result to 'next'.

Sounds good to me.  Next time, I'll include a 'fixup!' patch instead of
making you do the copy/pasting.

Thanks, both.
Jonathan
