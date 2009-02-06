From: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
Subject: Re: how do I install "git" on Redhat linux? (getting confused)
Date: Fri, 6 Feb 2009 10:45:26 +1000
Message-ID: <d30068860902051645x64a5b15fg7ea0beb72310ac71@mail.gmail.com>
References: <d30068860902051623w758bbfccrb1acca0adaf4a59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 01:47:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVEry-0003Hn-87
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 01:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbZBFApb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 19:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbZBFAp3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 19:45:29 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:31760 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154AbZBFAp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 19:45:28 -0500
Received: by yw-out-2324.google.com with SMTP id 9so254527ywe.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 16:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=1nsbSJbKsC5ovVM9GN8zektJz92UxUCSnhlYOt3V1Io=;
        b=LQhd+SPYeWZc2olawOOGoR9QdKMkp4i4VEOcpaRMox4Z/DQhB9i5eDFPJqwAnR2tZD
         pIPf1pOvjkn+tirNMoXAc2xtKLQLV2qmz4cvsIX1abdUlsSqhQM5pn3I40Ahwty1FoZb
         PjsBSBsTbGEWJMpZWazRA51cq87NQoWp74RV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=purm9MZqkHl93324yiIOpkDoVAED6hJsPRcR6VuJP+3sQsgfzCIKtWTSc9OJKr4Mue
         C+w0gG1lgJ5gny+q+HOUMR2hrXz0bDUvVh8fZq8+oitQYML29CQVgFxsB4blYGdFaE+6
         RCehY1aPhaTd5IXARgGTBQg7M/OopwFdXkmLE=
Received: by 10.142.237.20 with SMTP id k20mr634214wfh.93.1233881126736; Thu, 
	05 Feb 2009 16:45:26 -0800 (PST)
In-Reply-To: <d30068860902051623w758bbfccrb1acca0adaf4a59@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108641>

actually I've tried downloading the main
"http://kernel.org/pub/software/scm/git/git-1.6.1.2.tar.gz", and then
following:

tar xzvf git-1.6.1.2.tar.gz
cd git-1.6.1.2
./configure
make
sudo make install

Seems to have worked...


2009/2/6 Greg Hauptmann <greg.hauptmann.ruby@gmail.com>:
> Hi,
>
> Can someone give me a pointer re how to install "git" on Redhat linux?
>  I'm getting a bit confused with all the different approaches I'm
> seeing. The linux box I'm targetting is running clarkconnect
> (www.clarkconnect.com) and underlying system details are;
>
> [root@home ~]# cat /proc/version
> Linux version 2.6.18-8.1.14.3.cc (devel@cc4devel.lan) (gcc version
> 3.4.6 20060404 (Red Hat 3.4.6-8)) #1 SMP Mon Oct 22 17:57:16 EDT 2007
>
>
> Thanks
> Greg
>



-- 
Greg
http://blog.gregnet.org/
