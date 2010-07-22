From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git gui blame: Show History Context [still] broken since
 29e5573d
Date: Thu, 22 Jul 2010 03:23:10 -0500
Message-ID: <20100722082310.GB13386@burratino>
References: <vpqy6e4v1h0.fsf@bauges.imag.fr>
 <87sk3qrjk3.fsf@fox.patthoyts.tk>
 <7vtyo4a096.fsf@alter.siamese.dyndns.org>
 <vpqzkxkorzr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 22 10:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obr4t-0001NN-Im
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 10:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab0GVIYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 04:24:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42405 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab0GVIYT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 04:24:19 -0400
Received: by iwn7 with SMTP id 7so7693818iwn.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=26rb0D0JJF4Yq8Fh4JROfuZQVu8D5YPqtucDovOsxv4=;
        b=Cw4obB5NujVNycVIWmXbJ3IPsEVus8PlYphsjZA7i8j4YmjJR95ThDk0GN2wbPX5bn
         Wj/fzJeuweeY44HX3qSh08qYVdw2YSDcuyIzbxVzqUsa6cdA4C+47HXHJwuZSzH0IZSR
         P00cYWVug1H1uIvYWcWmNeqhH77ZrICnhDI8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B957yEdVObYycZ4M7tBH49mVRH+Kr46t5nyWs8nyvug8ChCvfTnom1tI134dimVhY+
         Gf0A9vQM8mUiNqY/fCpR8gvwxFpvzPMAFnvIOmMO4bdyVmIrdpUEQ1xT+nJn4jShf0+z
         l1niAllTxDhAPdjDpapk70fQJ7RXfEfhLQ8iY=
Received: by 10.231.172.83 with SMTP id k19mr1688556ibz.114.1279787048702;
        Thu, 22 Jul 2010 01:24:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm29709342ibk.7.2010.07.22.01.24.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 01:24:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqzkxkorzr.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151446>

Matthieu Moy wrote:

> Too late for the 1.7.2, but can we finally get one of these patches
> applied? They're both very short and straightforward, and fix an
> important feature of git-gui which is basically broken as of now.

Maybe some interested person should maintain a temporary fork of
git-gui that could be merged in the meantime.  That is what people
seem to usually do with submodules in analogous situations.
