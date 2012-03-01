From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] t4011: modernise style
Date: Thu, 01 Mar 2012 20:46:36 +0100
Message-ID: <4F4FD21C.9060403@gmail.com>
References: <7vipipqk4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:46:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Bxf-0008IM-7d
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435Ab2CATqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:46:44 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60908 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423Ab2CATqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:46:42 -0500
Received: by wejx9 with SMTP id x9so594434wej.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 11:46:41 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.180.79.229 as permitted sender) client-ip=10.180.79.229;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.180.79.229 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.180.79.229])
        by 10.180.79.229 with SMTP id m5mr13968000wix.6.1330631201566 (num_hops = 1);
        Thu, 01 Mar 2012 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=uz67gc4plBnx5Gfek4g/YecEi/mTuBjv3hAhwlhoCfA=;
        b=YAmKdtDsHbGNp+ccMEZFAN/UkF+zVcRTppi7raetexV/UsrdNg3PpNlGzw3N1QjnUz
         IOyaMbqzeXV+zEpA4O17/doYqJQ0Bo+EyZZyv0HqEwY2D0lDU0M5SrXeW1ReOajqLeVa
         T3Cx1IGnMFRS+6cGJC3bk3oSuvPsDCgjqsi4R4sGPANI6EOGR8oLIZpLFiBeptJ2Im6a
         gIhQ7Ah3et0bOX4e5GiCndVaeCfNWnW1my7A69CLihmGCKeRKbc+qRMfnBGphXRjyyNC
         xllpOTFi+gSugbBy3kmUbT62irk9z5kP04qU+tjsUGTOnE82z/LVqthA4lzSO4As+YXl
         4VLQ==
Received: by 10.180.79.229 with SMTP id m5mr11209894wix.6.1330631201527;
        Thu, 01 Mar 2012 11:46:41 -0800 (PST)
Received: from [87.4.96.156] (host156-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.156])
        by mx.google.com with ESMTPS id p10sm44599663wic.0.2012.03.01.11.46.39
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 11:46:40 -0800 (PST)
In-Reply-To: <7vipipqk4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191964>

Hi Junio.

I've noted a possible typo in the commit message ...

On 03/01/2012 12:45 AM, Junio C Hamano wrote:
> Match the style to more modern test scripts, namely:
> 
>  - The first line of each test has prereq, title and opening sq for the
>    script body.  This makes the test shorter while reducing the need for
>    backquotes.
>
Did you intend "backslashes" instead of "backquotes" here?

Regards,
  Stefano
