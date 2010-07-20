From: Jared Hance <jaredhance@gmail.com>
Subject: Re: unpack failed --- is my repos broken?
Date: Tue, 20 Jul 2010 11:35:53 -0400
Message-ID: <20100720153553.GA2931@localhost.localdomain>
References: <4C45A7C5.1050601@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 20 17:36:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObEra-0003Gg-UE
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 17:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441Ab0GTPgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 11:36:01 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47705 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383Ab0GTPgA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 11:36:00 -0400
Received: by eya25 with SMTP id 25so1318104eya.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=N0tdFjTOcf6SeC6s7ameCiKWFK/wMypx8WBeslZ0RYc=;
        b=EyUU7LAhZ9yzaeIVEjvT0fdX2gKrPKkbjjyFqSYD2aBgcwvqxAB7c4d1HCo62O3oRt
         /Jd7j0jteCxZORVOtNTszVXy5o2udBLX7HuIAC3Mn++HuztySK11pAiSD/EAwYAIuWbf
         5WryKF0Hevu+IPXdmixak7G2Vz//E25nKdYts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C7e9MV3NwPoTPPPCXuDW65Qtho12LWUWDxp8sOf7ImR5/aksYnchRzMIPD66CjWvzU
         7VnlfJVmWIxPPvuKr3Dcn9TN7yHxEgJs8ENTYOhfUkD/jgtbBLGwhETosZaQxTdQJm7P
         Y+d86H07jdP6Pt3osiqkfuR8+FgRSw73SNhHM=
Received: by 10.213.114.67 with SMTP id d3mr3971561ebq.73.1279640159520;
        Tue, 20 Jul 2010 08:35:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id g33sm28135937qcq.28.2010.07.20.08.35.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 08:35:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C45A7C5.1050601@llaisdy.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151317>

On Tue, Jul 20, 2010 at 02:42:29PM +0100, Ivan Uemlianin wrote:
> Is smart-http not entirely reliable?  In which case what is the
> preferred way to communicate remotely (we need to push as well as
> pull; there are a very small number of active developers)?

I'm not entirely sure why the error is occuring, but the preferred way
to communicate is over SSH. You can use the git protocol for anonymous
pulling (but not pushing).
