From: eduard stefan <eduard.stefan@gmail.com>
Subject: Re: [RFC PATCH v2 00/16] Return of smart HTTP
Date: Tue, 13 Oct 2009 06:45:09 +0300
Message-ID: <4AD3F7C5.2060203@gmail.com>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 05:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxYUI-00060L-KW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 05:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538AbZJMDxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 23:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbZJMDxM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 23:53:12 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:62607 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbZJMDxL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 23:53:11 -0400
Received: by qw-out-2122.google.com with SMTP id 9so759255qwb.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 20:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=es8s4j4lWsIO1i2GHQLLQDy877ONypv+ycCRt8EFGms=;
        b=AmBv5t1fisSq4PAZRhRonLbds5G/uZwoHumay5X2tcyxMGwZ2/rFuAydTzxxH8+EgU
         kCIOOYXJz3xxFL/N45ROmADsl4j8nGHoeSKOmlDIBn4t5OkYHBP2qiOErnlJPuJkWE3e
         AtJgj7ID1gv0tCoSCJH0vFoO2MgRvLKIEXGdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=x/qUhRnlRVRmkEuG2OcSMDKxvfGionx4Uj1jiPvpFedCgIDEhh11NCp+M24Z7YqQOn
         L2sxhT8pvHMffzvM0iXs2ZNnEhj1iGAEF3m+1HQHb16Hfnxq6UD0oPxryi5ZT1BcfIcF
         t+rr/P8sm7NjpTaxBRs+18/ILau115T/1SgDM=
Received: by 10.224.114.149 with SMTP id e21mr1642967qaq.215.1255405515167;
        Mon, 12 Oct 2009 20:45:15 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id 8sm2000457qwj.16.2009.10.12.20.45.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 20:45:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130122>

Shawn O. Pearce wrote:
> The series has gotten a lot larger since my last posting, but I have
> what appears to be a fully working client *AND* server implementation
> for both fetch and push, and the client should be supporting deeping
> shallow repositories over the smart variant of HTTP.
> 
> I've dropped the documentation patch from the series for now as
> I have quite a few edits queued up from folks in the last round
> (thanks for those!) that I have not yet applied.  So there is no
> point in sending that particular patch again.

I have apllied you patches on top of Git 1.6.5 release,
and they solved my http cloning crashes on windows
(msysGit environment).

Now git http cloning works just fine for local http servers,
but on GitHub I get an 502 error:
"error: Unable to get pack file
http://github.com/loudej/spark.git/objects/pack/
pack-1bc121e71e2847622f814603ddb34444bfc6a16c.pack
The requested URL returned error: 502"
which seems to be more like a GitHub problem,
since that URL returns an error when accessing it with a browser.

Have a nice day,
  Eduard
