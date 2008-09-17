From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Wed, 17 Sep 2008 17:01:22 +0100
Message-ID: <b0943d9e0809170901o15027408w439af4436cfea67c@mail.gmail.com>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
	 <20080914085118.GC30664@diana.vm.bytemark.co.uk>
	 <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
	 <20080915075740.GB14452@diana.vm.bytemark.co.uk>
	 <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
	 <20080916074024.GA2454@diana.vm.bytemark.co.uk>
	 <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
	 <20080916193647.GA12513@diana.vm.bytemark.co.uk>
	 <b0943d9e0809170455m53eaf677t87e9ade3f001d044@mail.gmail.com>
	 <20080917130432.GA26365@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfzU9-0007PY-55
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYIQQBY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 12:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbYIQQBX
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 12:01:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:58693 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYIQQBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 12:01:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3239461rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XfqnOGTr9BVzv7+dKKBoZhdeocR3ii5eX7T7IYcaQ5A=;
        b=m1ZUUjILabXHoBM3QePozKq/WoWOMHg7JgMS+RbHznJGme4EsSlucF9+WA0mbNWHh3
         GuM50OhGkkIq139pAVRf9XKAfpB1XkVLNyn0unSQiOOKh9MsTn3pUydqs9JwSgWurz2t
         3dqHRyMlfeDkFYICluEUKWhyRDnLtzatDbS/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Yq5Y8llwCKg88FygPRW2adjqMH4xJvVG8736knAdgaAdZgPFOXSLiLPgz0oDQVDHz1
         YDWbmQLI9XJ/Op/XYuKAz+qIYyS1rB79xGUyYtvxkVt79LC/Cnd8CXdbRsXfeXIxaZuE
         oc5G3rDCMQ43uGYYSBB2jlHq2WxrJi4sj6yc8=
Received: by 10.141.63.20 with SMTP id q20mr6618226rvk.258.1221667282158;
        Wed, 17 Sep 2008 09:01:22 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Wed, 17 Sep 2008 09:01:22 -0700 (PDT)
In-Reply-To: <20080917130432.GA26365@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96124>

2008/9/17 Karl Hasselstr=F6m <kha@treskal.com>:
> Have you tried the benchmarks I committed a while back?

No, I wanted to see how some real patches behave and I'm pretty
pleased with the result.

--=20
Catalin
