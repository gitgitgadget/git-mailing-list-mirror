From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] test-hg.sh: avoid obsolete 'test' syntax
Date: Tue, 12 Nov 2013 14:23:07 -0600
Message-ID: <52828e2bc5ce6_3b98795e78ab@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-6-git-send-email-rhansen@bbn.com>
 <5280c31919c9_6841541e7851@nysa.notmuch>
 <5281BDD8.6040501@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 21:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKbR-0004dA-3A
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3KLUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:30:21 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55737 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3KLUaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:30:19 -0500
Received: by mail-oa0-f46.google.com with SMTP id m1so4436972oag.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=0Q1/OMntxsJtg4rNniz3G01Dtbg5qrTFB3tg6KT0CyQ=;
        b=PohbRTiX2vdV5b8n8+6CX+o08yNC+B69xlKdXbDWbwcFVNX5t9tnIugmDr6ZonP/AA
         ri6kjebG8l3wJokFyTh4MM/om7HXRs3SAJAR5ClGfj1iUZn7Yhuaq4nbUQlyVWhLjScA
         s1e54ZLFshwo/q0h9fCioAKYRSZOJi2VwBD+Rg5/QLktm11MXhXm6RSPRRZfsvUr8aaX
         pcMvjUZkc527UjnVtO0YkgGU3xWFWJvUZTnvBELNIIy0ua/3/R3nIWRYgvJB0wbJiql3
         hDdKvChNaoCXGIjQESsOoNqCpGjrMoO+ZLkTIhX9KYzRxBTJ6tfazSaFuvwycHONafUG
         Blgw==
X-Received: by 10.60.50.168 with SMTP id d8mr8604442oeo.77.1384288219070;
        Tue, 12 Nov 2013 12:30:19 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm35139027obc.10.2013.11.12.12.30.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 12:30:17 -0800 (PST)
In-Reply-To: <5281BDD8.6040501@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237732>

Richard Hansen wrote:
> On 2013-11-11 06:44, Felipe Contreras wrote:
> > Richard Hansen wrote:
> >> The POSIX spec says that the '-a', '-o', and parentheses operands to
> >> the 'test' utility are obsolete extensions due to the potential for
> >> ambiguity.  Replace '-o' with '|| test' to avoid unspecified behavior.
> > 
> > All right, if you say so.
> 
> In case you're curious about what the spec says:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16

Thanks, I didn't know the POSIX spec was available publicly.

-- 
Felipe Contreras
