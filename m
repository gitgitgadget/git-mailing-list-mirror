From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: refactor input parameters parse/validation
Date: Fri, 10 Oct 2008 10:37:30 +0200
Message-ID: <200810101037.31037.jnareb@gmail.com>
References: <200810071257.38423.jnareb@gmail.com> <1223457985-27094-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoDWU-0007QH-GP
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 10:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbYJJIhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 04:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbYJJIhm
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 04:37:42 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:65184 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYJJIhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 04:37:40 -0400
Received: by ey-out-2122.google.com with SMTP id 6so172124eyi.37
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EuPRPn9joFBxeMRTNtGirFrtEpY9j6M//lORgxzWSVM=;
        b=POELkzMzKDW2S/56uQ76HQz5St3vbQCmum2fzgxi3DcgQUhSMD3TzC6FKdqvSkWZdN
         PRW8VI0wQxQCDj9GocLPy52MMosZsmxYnQTHJ0VPM8++CttRIHtXYnbGLlZSV3OZIbuf
         4J2aGnKACY1CigqnYCbnNaahJc2Bzlccw2FAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CKh9HL9UtJfVmWksEHVsUtuSQMUzOFXg/MiOo8YGqBxQBbSFnz6O0se9x6j78riRTv
         gjpP9bbOAwhxcEr+Yw1yg0qXgk7Q8ZEBvu8HCef8lrd505iYdPN94xyB6E7Yx9CEWvpi
         oanxgYliCnHh0cXpuRS5DkCmFlj2qZUlYscX4=
Received: by 10.210.90.10 with SMTP id n10mr1588000ebb.49.1223627857861;
        Fri, 10 Oct 2008 01:37:37 -0700 (PDT)
Received: from ?192.168.1.11? (abvi22.neoplus.adsl.tpnet.pl [83.8.206.22])
        by mx.google.com with ESMTPS id 2sm6418171nfv.5.2008.10.10.01.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Oct 2008 01:37:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1223457985-27094-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97915>

On Wed, 8 Oct 2008, Giuseppe Bilotta wrote:

> Since input parameters can be obtained both from CGI parameters and
> PATH_INFO, we would like most of the code to be agnostic about the way
> parameters were retrieved. We thus collect all the parameters into the
> new %input_params hash, delaying validation after the collection is
> completed.
> 
> Although the kludge removal is minimal at the moment, it makes life much
> easier for future expansions such as more extensive PATH_INFO use or
> other form of input such as command-line support.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Very nice.

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
