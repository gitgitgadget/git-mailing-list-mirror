From: Stefan Beller <sbeller@google.com>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 10:53:07 -0700
Message-ID: <CAGZ79ka7iNP0VJbLmzpUmFkkdtBhgHrbseKtfOq-PX4FCiBuaA@mail.gmail.com>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
	<20150519172254.GA27174@peff.net>
	<CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
	<CAGZ79kaNWDB2qg2-x-+2ccV1hC7Y0K8TQVPQNkjMotggwsRRzw@mail.gmail.com>
	<CAGZ79kbYUNjD79T+1LqgLNf=_ym-keq57FoQhby_aqn_sPFYSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:53:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulhZ-0007Mf-DP
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbbESRxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:53:09 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35976 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbESRxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:53:08 -0400
Received: by qget53 with SMTP id t53so11337036qge.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LFDxfulc2IesC6t07oryS7SLIonJ51v/z4+UUfFJ/So=;
        b=KuPpoEPyHAz4YLanXazKfT36ZlnAXL6INoy080bvUQWylNXwx5feOP/Lc6cv4y3Qzi
         DMYi3Bb93Ky8URhN0OigNiF3AJg0zfvzU7gY3b9GXEVQGT3WTvr7sBo0oUGaj6XckpnE
         EB5tgey3jABPrFnRNXwn6qM1zYQl9A2f5/mnn3u3ruxGUqJvVSEXJHfjnAHP7qth6JvA
         cI4Atlxn/YvzRZ7aaTMA1Ngzmd03B/GwPi4SLwc7qKb3T/Q0VC+4TlMOwMRt944K9X8y
         jT0v7wreCbvKIPAx0vDvqNaTmEzPwR1T5oLXRXqroCK84TgFoBIwXbLKj9Yb+VpYiPqA
         b8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LFDxfulc2IesC6t07oryS7SLIonJ51v/z4+UUfFJ/So=;
        b=KEiLk6fbn2aaugi8CW9J8O7ghSvg6yrY+XhYXU8vBbLrKLEEXql3wpkRbWI68qb7Uy
         05F06WhdSlh9eK6vEimDBz0D5KZu7JB0+PQ4EX6tC4YwrT/3jDkV0HDLiIEVp0iBY0me
         YaIBNPmrfVqltZC2gTtDUk0nPJAKXV0uvPjX+whSrrwiZa7T3sy4l+SBSnIctJX+mQ0r
         E3kFaf8hBSgbonbzy2wH2s4a6gsel12W3U1ciNieLuJOzYHRB67r/8hnI9Hcg6yR2blx
         qgifFQ2LOpyJsidFPUBWLyxnkgfFH7msJo7epD8Rdn5y+zssE0wwl/wCnnbj5jnPx05L
         Bkpg==
X-Gm-Message-State: ALoCoQmB0VAo/o2DVH0h4ydBj1hvm/hcWeiXBH7W+xvy4uZd4Hdq9IU+dRRhGPmzlnJMzd5PtiPt
X-Received: by 10.140.196.140 with SMTP id r134mr12072980qha.60.1432057987209;
 Tue, 19 May 2015 10:53:07 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 19 May 2015 10:53:07 -0700 (PDT)
In-Reply-To: <CAGZ79kbYUNjD79T+1LqgLNf=_ym-keq57FoQhby_aqn_sPFYSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269380>

Sorry for the noise, it must be a machine specific
thing at my end, because v2.3 and even v2.0.0
fail the test now.

To observe the failing test I run

    $ make && (cd t; ./t5570-git-daemon.sh)

which should be sufficient to not have stale data?

I'll try to follow the test script and look into the test
details to actually understand what the problem is here.
