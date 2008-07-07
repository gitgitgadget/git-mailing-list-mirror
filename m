From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn sucks when it should not
Date: Mon, 7 Jul 2008 12:29:43 -0400
Message-ID: <32541b130807070929q65e9a0d8g788cdb8c28ef28b9@mail.gmail.com>
References: <alpine.DEB.1.00.0807070135450.7342@eeepc-johanness>
	 <20080707094438.GA5964@untitled>
	 <alpine.DEB.1.00.0807071242180.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 18:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFtbv-0006IE-9l
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 18:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbYGGQ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 12:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYGGQ3p
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 12:29:45 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:36348 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbYGGQ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 12:29:44 -0400
Received: by el-out-1112.google.com with SMTP id z25so184106ele.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BV8GgFOQzRMblr+RRfith8KNaX2p/PUq8wI5pr6ISao=;
        b=Wn1HiWWLTKB534/47la8k4tzmx7D7GW0iweDeKYsxaoNFZdxZH7V2I2rPvW/+Za5An
         m06gffLnrxGL2EQXSOZr/+PwrZcuZXKA0b6bmgcal7TZLlGTNLA7FO9RYyjIOCCOHQnR
         AwLauhfDq7ij7REkC7ggVt5fS8GMWIC4UMAZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hdKqtRjN3CMTx40TZQbAfUlOy82zliHpK4SzEAasZNWPeYnmhtO4dTOMYY4VyV5Gag
         ToQCE5ke4GsbB9YF9pNrF0RFs//+gLcPg/0Gw4+f5qY2M3qD12L2iMAj8rCnCOlX9hkQ
         SbY3aFeqRCyLA5ga4UDiea4CpN0OC3Jvnb66o=
Received: by 10.151.100.17 with SMTP id c17mr8452061ybm.200.1215448183988;
        Mon, 07 Jul 2008 09:29:43 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 7 Jul 2008 09:29:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807071242180.18205@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87631>

On 7/7/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  # It heavily relies on curl being able to screen-scrape the directories,
>  # in other words, it wants an HTTP on the other side that has directory
>  # listings enabled.

I wrote a similar script myself, although it makes assumptions about
the meaning of /branches and /tags rather than using the dirs vs.
files trick.

Rather than relying on screen scraping with curl, you might prefer to
use "svn ls" instead, since it'll work with any svn-compatible
repository type and (I presume) doesn't require special web server
settings.

Have fun,

Avery
