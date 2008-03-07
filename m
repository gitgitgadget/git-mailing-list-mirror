From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: git-svn breaks on gtk+ import
Date: Fri, 07 Mar 2008 11:41:25 -0800
Message-ID: <1204918885.23455.8.camel@brick>
References: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Tim Janik <timj@imendio.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 20:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXiSP-00006n-Lg
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 20:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbYCGTli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 14:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbYCGTli
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 14:41:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:4118 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbYCGTlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 14:41:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so331331rvb.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=mDPI+IMTyiW+swgBb0i4ucn5SugV0ZKYcpss6b3QbAA=;
        b=rX5Aa5TPFRdIzxUu/gXVjj9RSmEg4RiW0a/9cTZWFXw3j2WA2753gavj010f3rIdGydp5rj4HT+RJkjqxOOLCIRbouX0AAeG8eEzFQcOuEgzPoxT/+D5fQuLT4q4hoJnY2uaMqwLFB8Wo2wLmN86l2vjvxILnHhPExOOkWZmr7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=sTicjcdV/gFu5bT17CFHINnim6xo5RX+TqCsPkO2spL6h3PikczqTDDMFK4ozsNr7qbu7GGsnj2wUAs2RUJ4b3ArCyNR2QJHKKWS3o45eAPoR/80t3futWiqF5cKjeVwRGstMaj7J4Md1jVcd1IX5exFWfI23DZNoSUkJkaOOc0=
Received: by 10.140.173.15 with SMTP id v15mr894600rve.168.1204918895052;
        Fri, 07 Mar 2008 11:41:35 -0800 (PST)
Received: from ?192.168.1.100? ( [216.19.190.48])
        by mx.google.com with ESMTPS id k35sm9284976waf.30.2008.03.07.11.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Mar 2008 11:41:34 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76517>

On Fri, 2008-03-07 at 19:00 +0100, Tim Janik wrote:
> hi Eric.
> 
> with git-svn from git 1.5.4.3, imports of the Gtk+ repository fail:
> 
>    git-svn clone -T trunk -b branches -t tags -r 19001 http://svn.gnome.org/svn/gtk+
>    Using existing [svn-remote "svn"]
>    Using higher level of URL: http://svn.gnome.org/svn/gtk+ => http://svn.gnome.org/svn/gtk%2B/http:
>    No such file or directory: PROPFIND request failed on '/svn/gtk%252B/http%3A': Could not open the requested SVN filesystem at /usr/bin/git-svn line 1352
> 

Strange, mine worked fine, other than:
 svn://svn.gnome.org/svn/gtk+

Cheers,

Harvey

