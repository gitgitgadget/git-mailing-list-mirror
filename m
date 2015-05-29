From: Stefan Beller <sbeller@google.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Fri, 29 May 2015 09:00:20 -0700
Message-ID: <CAGZ79kbOCUDVUT_WFQUNppD6QLr=kUUpZbuGi13ot=j_D7Zf8w@mail.gmail.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
	<xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
	<87zj4n4w3t.fsf@gmail.com>
	<xmqqsiafe6md.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Neukirchen <chneukirchen@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 18:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMhu-0005nP-A6
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbbE2QAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:00:23 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36026 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbbE2QAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:00:21 -0400
Received: by qkx62 with SMTP id 62so47315932qkx.3
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eDtsT4qGt8RkD116k/dCaUXZ+CVLzSZKQc1n9fZjSkg=;
        b=fDgaET68KVPxzbhgpEfBcmPpKfjxZJtlT88INGXvE2bLQTD+QuyGkcScXGWRwfEYV2
         F+lbSfywdCuZvZYfcs/vYInVzNIgdMMbLw7WmEcDtTANG4fZyew5t0aCTLDGG/GbsSPS
         tplnhTL0duELXtmI4j53J1Hm/enOjq6cFrvvAIpFow18ySPZhaV5w6SlA6e8O1HGFyBy
         Wm4cVjXIWoHRVvFxekSsln4jE+RR2oowdHJcj9v1gkSNmkD00yUKVV6xeYcFdzL5jHYV
         GGpFu8Qxr2HMCrHHa6PN+foJV1thadyZKp4qyP73lZdzVAjTiZhMeqvAXzCsa9S7zrMd
         INbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eDtsT4qGt8RkD116k/dCaUXZ+CVLzSZKQc1n9fZjSkg=;
        b=BDywUyVIiERSkb0qvawY/J72zjm9Qgrc04YEoAU/A2uVMU4YaUx29Y9mZdfxMr83ou
         wD6X3CIDq7o2BTf4Kovo25Z7oRiKCmIwVRDZS6x8JfrLX0vkTUZbY+toh3RCjqSVjzD5
         sZDg2gCZjSser1lROcl/EUGOjtqusIaHfbZxtZftP+X0qZQN2TNgu+185itlAyAUHfAi
         eqz7OPuEy+mL13GMsVz6K7j1KWsAdYyHSBC1BZq6sNLjyDuOmz84xaZspTu6vUHZl6h+
         FcycjB/EGGSNEdJIEpQ8NxPwHfu24DuNNcNlIV2XHpudy6eBjVvBcUaN8H8uCr2paEiM
         nXGw==
X-Gm-Message-State: ALoCoQkcNWagddDBMDFZYXthmKW/OcJnKPmSspyx6m4NbKcLraXSljqxQSGKe9u6LnYNXbh9SxQ9
X-Received: by 10.55.19.197 with SMTP id 66mr17294449qkt.24.1432915220550;
 Fri, 29 May 2015 09:00:20 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 29 May 2015 09:00:20 -0700 (PDT)
In-Reply-To: <xmqqsiafe6md.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270249>

Thanks a lot for the discussion!
So I'll just fix it locally for me and we keep the state as is.
