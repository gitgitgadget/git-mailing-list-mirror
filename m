From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large
 repo?
Date: Fri, 20 Feb 2015 23:08:55 +0100
Message-ID: <54E7B077.3050501@gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com> <20150220000320.GD5021@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 23:09:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOvlH-0005GA-7R
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 23:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbbBTWJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 17:09:17 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47110 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbbBTWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 17:09:17 -0500
Received: by mail-wg0-f42.google.com with SMTP id n12so15672555wgh.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zJpXRKsp3mthnqITgZd8Uh2/S9Pm/SthPXx/Ktm0z9s=;
        b=hNPNZkLRi/CPiZuawg+1xNGzJBSaVf7wi2AFzH/ffiYVUSpSMxskmLnc7RomYpvTu1
         j3XzhmDNrZiMw7N5Jxm+zYO5GpZ+SpyUNHTMig/OZiW76D691Ht17YzF1/lAVLwNZHPp
         ZTLb+nVdbGPFYgKcpctZHe9DcLcXyrXmKoGZtmjJemgYN16kE3wBNZpRlQUMSoynm3vJ
         H1Saylc5Z5phRH1TIIlCib3JpeYbCQ8sBBG9qarsDNWS8G7bTug5cqzwb7pwgD7Rspik
         gYC0GQcX2KJ5I9nO2p6hw2IYTU8agGEalKEwr5Uo4cYHYqFYkCEtonotKEyPs52C0SAH
         wA4A==
X-Received: by 10.180.97.226 with SMTP id ed2mr1715661wib.4.1424470155653;
        Fri, 20 Feb 2015 14:09:15 -0800 (PST)
Received: from [192.168.188.20] (p5B156C57.dip0.t-ipconnect.de. [91.21.108.87])
        by mx.google.com with ESMTPSA id v7sm43907435wju.22.2015.02.20.14.09.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 14:09:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20150220000320.GD5021@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264189>

On 20.02.2015 01:03, brian m. carlson wrote:

> If you want good performance, I'd recommend the latest version of Git
> both client- and server-side.  Newer versions of Git provide pack
> bitmaps, which can dramatically speed up clones and fetches, and Git

Do you happen now which version, if at all, of JGit and Gerrit support 
pack bitmaps?

> 2.3.0 fixes a performance regression with large numbers of refs in
> non-shallow repositories.

Do you also know in what Git version the regression was introduced?

-- 
Sebastian Schuberth
