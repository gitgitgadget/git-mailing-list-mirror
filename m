From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "Not currently on any branch"
Date: Fri, 2 Oct 2009 23:46:53 +0200
Message-ID: <81b0412b0910021446nb07e7e9l465f588168297fe9@mail.gmail.com>
References: <loom.20091002T215942-663@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim <timothyjwashington@yahoo.ca>
X-From: git-owner@vger.kernel.org Fri Oct 02 23:47:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtpxs-0003K5-7x
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 23:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbZJBVqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbZJBVqw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 17:46:52 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43725 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbZJBVqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 17:46:50 -0400
Received: by bwz6 with SMTP id 6so1375208bwz.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=u19EyPdrR67q9+PbnP5TD1cWcZGVkAb/qJieDylIxZw=;
        b=lzzrMl4ftYUOyX0xzY/v4rAbzgD2G4xX6XVRFapdVONhBi4578+mF0Gs2MnOeNKMYA
         8PE69tGlcD/bDIfoRcSGjpTrfH9Hl6x9EeqZXYcacJMMOZBE2Q6APuDvEEwJmbDQskvI
         fp90Dbemiw4w5hJz3wgdo1A17hkS/6SyyzYFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rQ8ETczyG/ZkrY0/9Wqu0LJzk4Vv3MmJKB94x+0Q7MckCaOfZFsbO0JpiNzqcf4hhe
         vE25fI6+70EXpF8TBlgshDyZIuQl68fAqJAWinjpJ0Vkvn9rpZGRMvZ8qwVaPbfeBWgG
         GKVc/AT7k3YickQaAXfVI3vw4r/Q7MSnapyzM=
Received: by 10.204.36.210 with SMTP id u18mr1591931bkd.19.1254520013938; Fri, 
	02 Oct 2009 14:46:53 -0700 (PDT)
In-Reply-To: <loom.20091002T215942-663@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129461>

On Fri, Oct 2, 2009 at 22:08, Tim <timothyjwashington@yahoo.ca> wrote:
> What's the most straightforward & cleanest way to merge my changes in the
> headless branch to my 'ui-integration' branch?

Assuming you use a Bourne shell:

$ prev=$(git rev-parse HEAD)
$ git checkout ui-integration && git merge $prev
