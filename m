From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: How to give permission to another user on my git remote
Date: Mon, 11 Aug 2014 13:56:14 +0200
Message-ID: <53E8AF5E.3070807@gmail.com>
References: <CAD6G_RTP5AQC8wjz17ghGBGbJ95t=kn5rRAgSaGaM-QCxi2mtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jagan Teki <jagannadh.teki@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 13:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGoD8-0002AG-5M
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 13:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaHKL4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 07:56:18 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35368 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaHKL4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 07:56:17 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so8383941wgh.15
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nKahUHXc8cbGjmei6crvccx3kYVRun9qlMFvyRY4LeI=;
        b=otKe5URKwKZLytc2tsIBQI137VqiC+JWf9QfQEosbegEBjlFaMGywLYC/vA89x/cqh
         kOZ44H65mAahNhWsIKoi+Mzzqb0B38AD4d0QCUi1OI1mjPEpN2wTfB0wk92neNA0plqi
         6SC6qpjU3m9buNv105XHtHc4wZoXI4ZIpmwPhPfIw+77HrDDB8TBmCO2NoA/JjbF2mdN
         eAGLdDSJg73wp4JgN1nKRZ/40ugptMXrXbG4WMNLDbfCe1t1/E6D2B+Dr8YPe7szKkVx
         PYCUKoswYdCf2piZkF3GrAK9bCnxVZxzv/x/vqOwjel9W5cHnFAYnVAmNmuklLPY3u6Q
         jcZw==
X-Received: by 10.180.106.99 with SMTP id gt3mr20458714wib.1.1407758175352;
        Mon, 11 Aug 2014 04:56:15 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id xw9sm1029209wjc.32.2014.08.11.04.56.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2014 04:56:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAD6G_RTP5AQC8wjz17ghGBGbJ95t=kn5rRAgSaGaM-QCxi2mtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255123>

On 11.08.2014 13:41, Jagan Teki wrote:
> Hi,
> 
> I have created one repository (but I'm not a root user on the server) like
> $ git init --bare
> 
> And I do push my changes locally to remote repo where I created.
> My friend also working the same repo, and he needs to push the changes
> on the same.
> 
> I tried by adding below line on the remote config file
> [config]
>         sharedRepository = true
> 
> Any help, how to do that.
> 

Please see
http://git-scm.com/book/en/Git-on-the-Server-Getting-Git-on-a-Server
to explore different ways how to use git on a server.

Stefan
