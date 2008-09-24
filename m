From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: clone fails: Could not get the current working directory
Date: Wed, 24 Sep 2008 16:43:11 +0200
Message-ID: <81b0412b0809240743l4ef88c51o8aebc496ca16e7c4@mail.gmail.com>
References: <48D59A30.5020403@cs.tamu.edu>
	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
	 <48D8EDDA.3050804@cs.tamu.edu>
	 <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>
	 <48D90125.3090703@cs.tamu.edu>
	 <81b0412b0809230801l2e6b1a71v1210317fe636aeba@mail.gmail.com>
	 <48D95C96.4030906@cs.tamu.edu>
	 <81b0412b0809240430y682d6dd9wef801c33a6ee2f85@mail.gmail.com>
	 <48DA410A.2080504@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Freeman" <jfreeman@cs.tamu.edu>
X-From: git-owner@vger.kernel.org Wed Sep 24 16:45:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVbi-0005wn-3o
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbYIXOnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYIXOnO
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:43:14 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:34873 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYIXOnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:43:13 -0400
Received: by gxk9 with SMTP id 9so5679591gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+bkhC2PdbhX8zLLGS6Fu7IXorMUAUfWMQ8xmT+0g0fA=;
        b=iaThPk7hpsrTtJVgeVE54T951tXBRVuWxNUml6BrcFU2fefp0GnshCCAT5X5sR2qnF
         9kA1RVVy6dOHaGv9UBEBmb56wbgQj7QH2wA1OYwmeuRIYZgOLM0pbMKlFa67jaKPLxTy
         eoDR3byrgA1Z6dauQEvJLZKjBhyNrMYMzLPI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Mo89I1RydyxqESOprBNCUIr21yu5yhyb4at76QInkbmH2F+Vrxa60NzaDIrvEGMvMj
         xI1O//XbcTbcGsWRLSM18DYuiFi3KrdGK+MO/YxSg9rCJ0BqMVzl6EvjHU+RTlZyjsdZ
         6njZ/DWR8AR7RY6F0ZKXo76nGijBaB8CyOd6Q=
Received: by 10.151.143.14 with SMTP id v14mr11148459ybn.144.1222267391513;
        Wed, 24 Sep 2008 07:43:11 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 07:43:11 -0700 (PDT)
In-Reply-To: <48DA410A.2080504@cs.tamu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96638>

2008/9/24 John Freeman <jfreeman@cs.tamu.edu>:
> Alex Riesen wrote:
>>
>> General question: What does Sun's pwd do?
>
> It works like you'd expect.  There are no permission problems.  Even in
> directories for which I don't have read access, it will show the path.

No, not what it shows. What does it call? Which syscalls it uses so we
can use them also. Or is /bin/pwd root-SUID?
