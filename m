From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb: Include a site name in page titles
Date: Tue, 11 Jul 2006 23:48:58 +1200
Message-ID: <46a038f90607110448p40fd8984ke3e15639cf5ecf46@mail.gmail.com>
References: <11526131782190-git-send-email-alp@atoker.com>
	 <11526131781900-git-send-email-alp@atoker.com>
	 <1152613179634-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 13:49:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Gjh-0005Ug-Cw
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 13:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWGKLtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 07:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWGKLtB
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 07:49:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:27657 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751222AbWGKLtA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 07:49:00 -0400
Received: by nf-out-0910.google.com with SMTP id n15so200395nfc
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 04:48:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BQI9bShLYFdzQcbAvdKqbTjv4phTSbqo/nUk56jGiuD2x4X//DlG/OdoUsAa1+n2vEvtKYjuope8wOS1dCFwLalV1rWeAu6lBWGcqmHWtTyZDrGfXwe6zKMRwxX1+fC6AaC0o50AuXDFjuMjELiHQah6su8UzZkIpa+LtMnD8sE=
Received: by 10.78.157.8 with SMTP id f8mr2115361hue;
        Tue, 11 Jul 2006 04:48:58 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 11 Jul 2006 04:48:58 -0700 (PDT)
To: "Alp Toker" <alp@atoker.com>
In-Reply-To: <1152613179634-git-send-email-alp@atoker.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23709>

> +# name of your site or organization to appear in page titles
> +our $site_name = "Untitled";

I generally agree, but as a default, $ENV{SERVER_NAME} should be better.

cheers,


martin
