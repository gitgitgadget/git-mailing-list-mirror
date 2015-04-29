From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: Fix inconsistent quotes
Date: Wed, 29 Apr 2015 12:09:46 -0700
Message-ID: <20150429190946.GQ5467@google.com>
References: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
 <20150429185141.GA32207@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Tatschner <stefan@sevenbyte.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnXMo-0004hH-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 21:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbbD2TJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 15:09:50 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34440 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbD2TJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 15:09:49 -0400
Received: by iedfl3 with SMTP id fl3so56463584ied.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S3oQz14+BpyKg27ziXGskNCyZEjSD28FMhGDCeh8u9I=;
        b=J8Hw76LUZ+EmAFYHrUThg87NdNR+LwT85IB6waoMv8fKKrzRazE8f+wP17dcq8fY8n
         L+5HHDq03yTPunaxUjbBfJzWVYLjduol15dIvJ4jJdc3b8Kivp/B0aauqGfnf42uAic+
         Vz7wKnu3UEpsN36rJ3CbMHYGQbpIrN+9mp9bGxEKWW20t0pG1dwDFog6Ll3F7ztSpdxx
         OiaPvZ7rTNSKlaICdoYNsGOEAz1Md/cMnZd+fYZuznrWMfAnVdLSlPgBmyfIi+gvnKm0
         PwEPvkyGdmYUa9MPfFEvXx/eoO9Mb91uaoHnwEpcOpKu+Yi91aesPyzQfMs0g2EocrE5
         2IHA==
X-Received: by 10.50.110.104 with SMTP id hz8mr6257172igb.38.1430334588966;
        Wed, 29 Apr 2015 12:09:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:71e2:5d4a:c0e6:7f1b])
        by mx.google.com with ESMTPSA id f126sm17290465ioe.21.2015.04.29.12.09.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Apr 2015 12:09:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150429185141.GA32207@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267992>

Hi,

Jeff King wrote:

> But IMHO, using backticks looks much better. In the roff-formatted
> manpages single quotes underline, but backticks use bold.

Are you sure?  My copy of git.1.gz has backticks converted into no
formatting at all:

	Other options are available to control how the manual page is displayed\&. See
	\fBgit-help\fR(1)
	for more information, because
	git \-\-help \&.\&.\&.
	is converted internally into
	git help \&.\&.\&.\&.

Thanks,
Jonathan
