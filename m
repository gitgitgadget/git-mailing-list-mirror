From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 11:35:23 -0500
Message-ID: <4F85B2CB.3070002@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411060357.GA15805@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:35:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0W2-0002mV-EN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760658Ab2DKQf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:35:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56811 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760038Ab2DKQfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:35:25 -0400
Received: by obbtb18 with SMTP id tb18so1422561obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8kVWbX18VAfWcFoucPDl1al5879mgSBkN9ewfkHu6DU=;
        b=c/x66sOAtcmv9tJ5UAB4umyA2R30cjyjzPVhH/OqViJhWZA67XtM98hk5ocnVtYTvn
         AlKsRdDsdcfjZRctiRs4LWyy6c4G7fHsTlCc83FHnZSr40L7WbkDbmqurfiH8npGAChS
         1utvwVaM9iOcuxCPQhhoLPnocaibZDQSy7pMdibJYL1xuyBOLb/hPPkVN+94zZzSRTk5
         xA2UPH5WVHQw7HXlMe/93HshmqKyoOj6PNRe3APjhEjPUHiI4ZjAutwxxBoRWulJFltb
         EGLVEBFvopmH0IpvJ6saPWzrVV1AW9qbPEzgMBZjzbNfo0JgaMPpTw8PdyvA13FdohW+
         S2HQ==
Received: by 10.182.1.1 with SMTP id 1mr20701025obi.32.1334162124854;
        Wed, 11 Apr 2012 09:35:24 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b6sm3319940obe.12.2012.04.11.09.35.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 09:35:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120411060357.GA15805@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195207>

On 4/11/2012 1:04 AM, Jonathan Nieder wrote:
> Neal Kreitzinger wrote:
>
>> Maybe small binaries do xdelta well and the above is a moot point.
>
> If I am reading it correctly, diff-delta copes fine with smallish
> binary files that have not changed much.  Converting to hex would
> only hurt.
>
> I would suggest tracking source code instead of binaries if
> possible, though.
>
Is there some documentation out there that lists the common binary
formats (e.g., pdf, docx, gif, jpg, png, bmp, mpeg, mp3, zip, 
c-binaries, java stuff, website stuff, etc.) and explains their nature 
(container, compressed, encrypted, etc.), how well they currently delta 
in git.git within specified size boundaries and use cases (pdfs with 
only plain text vs. pdfs with graphics, tables, etc.) so git users can 
reference that to make their git repo/superproject design decisions?

v/r,
neal
