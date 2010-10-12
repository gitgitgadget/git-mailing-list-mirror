From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] svn-fe: Use the --report-fd feature
Date: Tue, 12 Oct 2010 16:55:41 +0200
Message-ID: <AANLkTikxsP_DV2Tjwk9vNi1WZFFiFEjQjCjhcbc5FETf@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com> <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 16:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5gIz-00046V-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 16:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab0JLO4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 10:56:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55596 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab0JLO4C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 10:56:02 -0400
Received: by mail-gw0-f46.google.com with SMTP id 17so1440341gwj.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=+siqECcEUqzNMxqh5iF9TcSaaZy2grrKpbwaagiV+WU=;
        b=CVOezmPLIqcZd5Nayv97iN4oU5/zs5iG2hvIceQEOW2v72Uh3B49h6pR0pOzuIb/j0
         osyft3Rjl/bDxgIY9G43zuWCxaj8AmJ/UUuW7tCpFlc+j9zG+vnb+xqmU84MyzRVmRwe
         uBYr+3WovHYZbfTAlhiEYFRdm7ohmO3fICYAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ExlUp8y7bfwgS508u6HSAWnrVZi9qY8/eUa2seJAjkBfiEmFuGetLYQtwOo1rnoFVz
         vuzICTIr9u7mrN3f3xjL/CUPQdNSXN5LIR21grzvkRYQEvImL0/oBQ8ii8x8uqRyV+WV
         KzWypj8Git23z4MWmQtdgHuFXwWO9ZQ0CJmmM=
Received: by 10.151.87.10 with SMTP id p10mr8475838ybl.101.1286895362418; Tue,
 12 Oct 2010 07:56:02 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 12 Oct 2010 07:55:41 -0700 (PDT)
In-Reply-To: <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158851>

Heya,

On Tue, Oct 12, 2010 at 15:50, David Barr <david.barr@cordelta.com> wrote:
> On one hand, this makes the interface much uglier.

Can you quantify this? What does it make uglier, and why?

-- 
Cheers,

Sverre Rabbelier
