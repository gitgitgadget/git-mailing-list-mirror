From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] shell-prompt: clean up nested if-then
Date: Mon, 18 Feb 2013 15:28:16 -0800
Message-ID: <20130218232816.GE4022@elie.Belkin>
References: <1361228206.17734.4.camel@mas>
 <5122b23b.512e980a.32b9.ffffa580@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: s.oosthoek@xs4all.nl, git@vger.kernel.org,
	trsten@science-computing.de, felipe.contreras@gmail.com
To: martinerikwerner@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 19 00:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7a8c-0002VR-UW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 00:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab3BRX2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 18:28:22 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:33658 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab3BRX2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 18:28:22 -0500
Received: by mail-da0-f48.google.com with SMTP id v40so2698848dad.7
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IGeWtTzESW5RGl3aDWcqa3m8TUu5Wd7NRTr7TcQVvfA=;
        b=IRKVF+v7Z6TH3d220ZCenbm0SA8ryg75uQmqfqCcuDi/x8D7uPZXX2Hge8M/g2ZWFD
         QforfIxGgc49ir3ZFDgayVzkB2i1bFJrIF4alAVnJQVFHzq3gf0usfh9Isv3BN1xtttT
         y3rHy6mdYmZ9cLrheACXtW1nP1Qc3TgoUTe0InB3FJNuq60zujS0SK1x6hD5nY8GHfSj
         /js7G8i8dLEJ/KFOb36QrxvzIRYyg04OZNSOEsILqG3toYCRBXAi4HG9u40lQem/jF/k
         d8MHdSane8ZiYnL7Opny/DaCiZsxYz4Mcpk65dvBNVHLouykwkF0u0xMORrknyZ3UvSK
         /1SQ==
X-Received: by 10.68.48.165 with SMTP id m5mr35167508pbn.40.1361230101834;
        Mon, 18 Feb 2013 15:28:21 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id f9sm105162634paz.12.2013.02.18.15.28.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 15:28:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5122b23b.512e980a.32b9.ffffa580@mx.google.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216550>

Martin Erik Werner wrote:

> Minor clean up of if-then nesting in checks for environment variables
> and config options. No functional changes.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>  contrib/completion/git-prompt.sh |   27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the quick turnaround.
