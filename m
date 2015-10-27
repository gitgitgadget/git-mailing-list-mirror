From: Davide Fiorentino <davide.fiorentino@gmail.com>
Subject: Re: Why are submodules not automatically handled by default or at least configurable to do so?
Date: Tue, 27 Oct 2015 10:56:32 +0000
Message-ID: <EC0D15E1-82B3-4A4C-96DE-8922AB870E2B@gmail.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com> <562F5704.5070405@letterboxes.org>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: John Smith <johsmi9933@inbox.com>, git@vger.kernel.org
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 11:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr1vk-0006ms-TG
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 11:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbbJ0K4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 06:56:36 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35543 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbJ0K4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 06:56:36 -0400
Received: by wicll6 with SMTP id ll6so153654849wic.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5xV4Dqsz+z3qTy1cVfJm0tNAk1AttCzEcjzMG+Z3UAA=;
        b=sZcy5HKwaYc0tO+bS6Va2z8ft2oOhS/Bpt54wiweqL3N2K4PmR5uMyGOQZY9eM8NVD
         w3nkIEphVb0TyfIg5P1YspKVZiuTjAlj4Dq5DsV7IEQU4q0MtyLAKjNgVhH/cgRZl5/O
         3TiHqhbsmyaehTSo0AyBDXrrczExG1eUFp8KqFwyZc/9sx/sYZj19S9f3Nm4G2yUf9Ur
         1UwmksduC58Myzm3F027GomUbiNk8+jCJlL/tXIRaKRR1B7NBbONwb8EoB4ZssN9tzWw
         8jwdn2pX8zGOmNm3toBAPJGNi6zeNNXdCMnMHNne+ZaDcdbRPgi1Qrpj0kvOtZ+gPgU5
         EIHA==
X-Received: by 10.180.207.238 with SMTP id lz14mr27128405wic.1.1445943394916;
        Tue, 27 Oct 2015 03:56:34 -0700 (PDT)
Received: from [10.7.0.54] ([213.152.162.99])
        by smtp.gmail.com with ESMTPSA id nd17sm1772774wic.22.2015.10.27.03.56.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 03:56:34 -0700 (PDT)
In-Reply-To: <562F5704.5070405@letterboxes.org>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280259>

Why not set alias(es) for that?

Best,
Davide
> On 27 Oct 2015, at 10:50, Nick <oinksocket@letterboxes.org> wrote:
> 
> I too am interested in finding ways to automate working with submodules, as it's a particular pain point with my colleagues.  They frequently shoot themselves in the foot trying to branch and merge a project with submodules, resulting in a broken build and grumpy comments about git (or possibly about me, as the "Git Advocate").  And they're right, it is awkward.
> 
> Whether or not any sensible default configuration exists, users do need a way to avoid excessively complicated workflows, or people are just going to avoid using submodules, or perhaps Git. Hand-rolled solutions might be better than nothing, but I would expect that this is a common issue which would benefit from a built-in solution.  For instance, so that one can branch and merge the whole project without duplicating the work for each submodule.
> 
> Am I correct in thinking there isn't anything which does these kind of things yet?
> 
> Thanks!
> 
> Nick
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
