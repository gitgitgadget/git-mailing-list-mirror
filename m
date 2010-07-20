From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Tue, 20 Jul 2010 13:13:17 -0400
Message-ID: <20100720171317.GA8693@localhost.localdomain>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com>
 <cover.1279643093.git.jaredhance@gmail.com>
 <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 19:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGNl-00016Y-83
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab0GTRNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 13:13:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58635 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab0GTRNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 13:13:22 -0400
Received: by gxk23 with SMTP id 23so2946654gxk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NSLP6nR+GEkHlq81nPzb/LWkMJhwoavEa0F0VbvF0Ow=;
        b=UU/Jhh/8dyrwaQVNPZnsYvA4oAKBXq1V0Fbk+Fg57cMUEQzLhhIiGBYg0ycOHj1jDQ
         KMdUj9UopTevI0/Jceb2KLHAe3CNw99+15ahE0MCfeDOXT0rKnQCNSmjc2ZbgmWXro7i
         g1TJK1PAyUfdRKEeO11Wza+h29nlPKRXQJtec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xJrWnKW0Q+ienGmjF/NKbi0wDL5HuFpch1HHz7auJhUML+FRBCpYem0VSXyArOpigy
         TiFhIgRwObjLvFe3ahfrtJJP6ZySiWx7zj2kOmOdArLb/FYO4up7Yopc7LrGPU4k554W
         IeDR1DexChyodlKOi2UWInn+bkrI9QX1obELc=
Received: by 10.224.40.137 with SMTP id k9mr5698231qae.388.1279646001509;
        Tue, 20 Jul 2010 10:13:21 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id js14sm28233206qcb.30.2010.07.20.10.13.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 10:13:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151332>

On Tue, Jul 20, 2010 at 06:03:36PM +0100, Aaron Crane wrote:
> Rather than stuffing multiple exclusions into a single option, how
> about requiring one -e option per exclusion?
> 
> git clean -e foo -e bar

I actually considered that - However,
Documentation/technical/api-parse-options.txt does not document how to
do this type of thing with the the parse options api. I will look into
the code for some examples to see if I can figure it out.
