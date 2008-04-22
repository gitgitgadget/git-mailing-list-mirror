From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git_blame2: fix rendering on Firefox 3.0b5
Date: Tue, 22 Apr 2008 19:05:40 +0200
Message-ID: <200804221905.41963.jnareb@gmail.com>
References: <1208821391-7895-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:07:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLx5-00024O-FE
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbYDVRF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755817AbYDVRF4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:05:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23401 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbYDVRFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:05:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so189300ugc.16
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=k0zuCTmBvBamL51XzeMLFIjUbj9c4MXw6EuuS8LuY48=;
        b=QycN9m9P92zuyeEaatAKLcB1mortalERqjKT/GChmJC+Oic83jXBpBETOY3TFVUsJAD1nO8YiUPJVuz9ACLB2oqwC16EF/WiGejZLzTWe1hT5AXyWZvF2a6XQDT7W9FQbXMuN4l7GIUpscqGEtpkwSTSypSgxgEloLOBriVJNIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EVh58J7eKPoYJsMQUdrQMGv0fGT0CrL14dq7u7PEUdPyU1TsjEU7m1hz0qQyOHvq+T3+nCfYdCMbONSUJjIsI87d8QfdALj00YIPmOKWEMw2c+s148Vd7EPLH2ksv/2bbo5mMISke90q1neReUVFX5AMNfuXO1LzaYetm+PsqWc=
Received: by 10.66.255.7 with SMTP id c7mr7146359ugi.43.1208883953935;
        Tue, 22 Apr 2008 10:05:53 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.207])
        by mx.google.com with ESMTPS id s8sm101105uge.3.2008.04.22.10.05.45
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 10:05:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1208821391-7895-1-git-send-email-stevenrwalter@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80141>

On Tue, 22 April 2008, stevenrwalter@gmail.com wrote:
> From: Steven Walter <stevenrwalter@gmail.com>
> 
> Using variably-sized rows and rowspan does not render correctly with
> Firefox 3.0b5.  Instead, make each row have the same number of cells.

Beta version of Firefox doesn't correctly render perfectly valid HTML;
more, the way rowspan was meanto to be used, see example in

  http://www.w3.org/TR/html401/struct/tables.html#h-11.2.6.1
  (subsection "Cells that span several rows or columns" in HTML 4.01)

and you want gitweb to generate invalid HTML?

Firefox 3.0b5 doesn't render, for a beta version, is not a valid
reason for me.

P.S. I don't know / remember who wrote the code in question...
-- 
Jakub Narebski
Poland
