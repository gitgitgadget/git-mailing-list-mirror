From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 20:35:53 +0700
Message-ID: <CACsJy8BFdk6jtRqSKE0ThtcZi39hHC_QbDx6oka0qWk7eiD4wQ@mail.gmail.com>
References: <20160317111136.GA21745@lanh> <alpine.DEB.2.20.1603171431000.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:36:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agY6J-0003MV-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbcCQNg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:36:27 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35680 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030677AbcCQNgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:36:24 -0400
Received: by mail-lb0-f172.google.com with SMTP id bc4so68687656lbc.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2OkctKQyX86pZJ3zwc/i22Fp3fMP5U0Xe59BLKPNC4U=;
        b=oZSWt54Q31Uon/A4HGBBeMdnZHePyKADUu+dgpy6ERYN3J52fBP8epv33Fw+m97uAP
         2G7/+DEp/ib3pslKz3X8LLrHbrYdmpbdADVjDkNZbOh4R4h6elzewj3YuMOQ2QDjo4/H
         22116Ywk3cFYzWWq4qX5dctKoCL6IS8n9Lr8ps6EPtIb97EjvQnsX32M1ARcpW05+wbM
         KWdbuBtPAtY1TiLIH0ClRg4bRt2Xs4mQPt9GxnYAa+6Ybfl5KMeDlKN0vXXLxjetKILX
         c0Ak1r5k/BgnjD0bqUEjjNz9NqD7iNFXgw6xw1C1A/p6M0n6bPK30RI+1ltqv1Ybkl62
         FhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2OkctKQyX86pZJ3zwc/i22Fp3fMP5U0Xe59BLKPNC4U=;
        b=d/4IwHql7ZhT6c133ZLswc7b6fbpVWowyP/aoaEoCyF4VxixgLIOF3KllYO7m02mam
         0gQXbU949frm4O+V9Ba/M9lOy6Ev7ji+OFf4Jid5YaU4Q0opnO1+Xw6AsCvnQKbQmLqb
         1etSi4WUV6Gi7HJF6VJ3Di0sqHaTRz7JyhcGK296YdTmnmU3qW1Py/k5Q6Up7bgAtF6d
         ZBU4jrq5nAn9cZ1hxGHIwTdJMfNxVWSK0zldj3P++EpTdDsM9zywa23THrtsDu6eTiQd
         OdW6Jsx1hdC/6/nGWwWsPEeJIhpabTdAjF3/cmTmmAwvyd4pfamoX2FjYoHKGPGxFrnz
         PefA==
X-Gm-Message-State: AD7BkJLy2JFn/wkp3+ZJbsa6pyw6Gpx0RxYkf0L2HQ2qBt4RRoIZEGyrMC9ost082W1yfeQVN9xSxwVhEvjCJw==
X-Received: by 10.112.130.41 with SMTP id ob9mr3560105lbb.81.1458221783240;
 Thu, 17 Mar 2016 06:36:23 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 06:35:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603171431000.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289114>

On Thu, Mar 17, 2016 at 8:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Good? Bad? Ugly?
>
> Disruptive. Probably a change for 3.0?

We tested it with the builtin rename a long time ago, so it's probably
not bad. By the principle of "dogfooding", we should try it soon and
make sure it's not disruptive, or prepare ourselves for such a change
(I think git-am can't track renames, for example, without us giving it
a clue somehow)
-- 
Duy
