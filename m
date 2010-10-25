From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 00/10] gitweb: remote_heads feature
Date: Mon, 25 Oct 2010 20:38:46 +0200
Message-ID: <201010252038.47687.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 20:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PARxA-0004NV-FK
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 20:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759368Ab0JYSjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 14:39:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55287 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759362Ab0JYSi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 14:38:58 -0400
Received: by bwz11 with SMTP id 11so2693151bwz.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AM4/1wLCTSjUcWaSfhAWHSpSIxzuflu7M/sN01gc4Dk=;
        b=c58QQfUC/lzJSlzrYjcSDw8A3Ac93uI12dhGIVCEHcP+T1AaTgfT49iSVlnvlD2lve
         XCkZF0oghB9eLEFkCie/7JW9EaDgpNm32BAc/1BF7sbGht4FK3xBjj42PmYFZUH1fL9S
         Jf/tyWHpsvvnnQ5NR+qxBRVoB1EMroSnma1ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WhDz5XPyBfqm86qw4kwmPBjxqBEySRKq/vheuSjYLDEBGrWzrofSGTZJk94mRc39eS
         u1hLgYiHLn2kD1DRZQhp1nv1/6fMloqeBmH6mfKvsloW8o5pv439x1MFqypKqmeRm4Fc
         4JYogjbp0i9N9fgiiCOJpsyrksz/CxkUZngPc=
Received: by 10.204.69.193 with SMTP id a1mr5457107bkj.108.1288031937405;
        Mon, 25 Oct 2010 11:38:57 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id 4sm5119307bki.13.2010.10.25.11.38.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 11:38:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159967>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

> In this 6th version of the remote heads feature for gitweb, much of the
> internal API has been cleaned up thanks to the suggestion from Jakub and
> others. There were also some other stylistic changes, and a few patches were
> reordered/merged.
> 
> The first 4 patches are rather straightforward and can probably go
> straight in. The 5th patch is a bugfix for something that is only
> triggered by the name manipulation done with the remote heads, but can
> probably be useful even without the rest of the series.
> 
> Patch 7 provides 'single remote view', depending on patch 6 for
> improved visuals of the page header.
> 
> Patches 8 and 9 provide some infrastructure for the grouped remote heads
> display introduced in the last patch.

You can consider all patches, except the very last one (which is
undergoing review - I will send a comment shortly), can be considered
Acked-by.  Any comments are minor, and non-blocking.

-- 
Jakub Narebski
Poland
