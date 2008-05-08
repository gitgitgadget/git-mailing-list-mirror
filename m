From: "Caio Marcelo" <cmarcelo@gmail.com>
Subject: Re: Binary files in format-patch
Date: Thu, 8 May 2008 17:21:53 -0300
Message-ID: <d280d7f10805081321q7a09b61ke06a1c945650d880@mail.gmail.com>
References: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
	 <200805061119.14792.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 08 22:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuCdi-0003qB-Gs
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762075AbYEHUV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbYEHUV6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:21:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18963 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240AbYEHUV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 16:21:56 -0400
Received: by nf-out-0910.google.com with SMTP id d3so501148nfc.21
        for <git@vger.kernel.org>; Thu, 08 May 2008 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NXfp1C/vuA5iGsog1N9kjJS2X/VBD7/W3B3/JAEN5Fk=;
        b=emlMnXBRh7CzJBtLuW3K4JsleZ87xWQjUQQzWlnm1z5zpGO1paEBOCNpRaZBoOihdFmXgCPei/MNa1GXvXNv3wafNZrte1PSr8geoSVUwQijEQAyasNwQpm8CkaZZDzGQh3zY1oJsam92y3Us44MJUpljTkfAF5T22mbbCzcYOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fRlEqNpf1iRARTvrpWU4CEU2/WJH+Gqe7EENet3+JQQ+RvEwdzuVgzRJbPxDa1nK2vkOXxoDxurORzGsLrONuH2mGevO3xOAsQqIEqA6UOnKO4k4dQrPNcV9s6GV/Rb+lRuJ/tgec5+Dx/pDEYON3XuXeD3o91nEz3lvEOYyKb0=
Received: by 10.78.179.12 with SMTP id b12mr1036174huf.61.1210278113839;
        Thu, 08 May 2008 13:21:53 -0700 (PDT)
Received: by 10.78.140.8 with HTTP; Thu, 8 May 2008 13:21:53 -0700 (PDT)
In-Reply-To: <200805061119.14792.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81557>

>  > Wouldn't be nice to allow this code path to happen via some
>  > --omit-binary / --no-binary option to be checked in cmd_format_patch?
>  > (I could provide a patch for this, if you think it's a good idea).
>
>  Sounds reasonable.  I'd say --no-binary is the right one here.

Commited a patch couple a days ago. Could anyone take a look? I've
tried to reduce the changes to a minimum.


Cheers,
  Caio Marcelo
