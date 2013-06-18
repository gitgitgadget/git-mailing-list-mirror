From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fix "builtin-*" references to be "builtin/*"
Date: Tue, 18 Jun 2013 09:28:23 -0700
Message-ID: <20130618162823.GB2887@elie.Belkin>
References: <1371571166-6481-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoyln-0000M1-1O
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064Ab3FRQ2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:28:30 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48858 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab3FRQ22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:28:28 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so4051548pbb.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JHiucjuCF7roadTkWyHhpG8Y8unhgM4j9DqVnrr/gBU=;
        b=XAgnlpnS/9QvU29EKKJJ/agHIQYbaqorcKVVLiZbO1N1vaugqNxWk20/4S/1tsH608
         HDKm0IliJaC8e5Y4d7tW3ahod6fbfPNxl0MyBrgTC9FLe/tsUeU2JE7ZlEQyZm6QbNjR
         4fB08ZYHeYqmB2uR+jI2bV16/F9Q7rgr/j9DI+Pg4jnJYcY5eYen/nirFOGO/rtWkYS0
         DVhljA35RJc/OlEMmm/MZukF0dwwZUog/4DFc7VJgkrbq9bIqUGoAXOHyvcLnlQIkfza
         rwZRJiXlAFQC3Z/t8NSt9j3+xfl/0vNpQRklmGS+pyTKe1KQ01LNOPZr8OdFaULBDI6X
         zsug==
X-Received: by 10.68.202.7 with SMTP id ke7mr17517352pbc.82.1371572907703;
        Tue, 18 Jun 2013 09:28:27 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id qp4sm18910483pbc.41.2013.06.18.09.28.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 09:28:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371571166-6481-1-git-send-email-hordp@cisco.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228264>

Hi,

Phil Hord wrote:

> Documentation and some comments still refer to files in builtin/
> as 'builtin-*.[cho]'.  Update these to show the correct location.

Yeah, good call.

[...]
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -1,5 +1,5 @@
>  /*
> - * builtin-help.c
> + * builtin/help.c
>   *

It would probably be better to remove the above two lines which are
redundant next to the filename.  That can wait for a later patch if
you like, though.

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
