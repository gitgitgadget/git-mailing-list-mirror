From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Checksum incorrectly uses signed values
Date: Thu, 14 Jun 2012 04:35:21 +0000
Message-ID: <1339648521-ner-3801@calvin>
References: <CA+-ctj5M4XraOQJfWRVVFmRrNsUZUJyt63_Oi__OJCcYMC=ciw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Brendan Brewster <brendan.brewster@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 06:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf1n4-0006NZ-5N
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 06:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986Ab2FNEgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 00:36:08 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54716 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2FNEgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 00:36:07 -0400
Received: by wgbdr13 with SMTP id dr13so1427599wgb.1
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 21:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=gmIARVzLpCAUORkzKvscLSomToANUUNuhFcr0AmY4zs=;
        b=CJ761wWeulN+dRqpsdahapln71q81lgSpbUq/Wq0mlL2VcuTQd3aUatEWkVJoWwX2Q
         Xy0YPSfprf7nNnrdjUp+gLGzhua2TOR1hxfjCCfFn7DET2C0wExiblT5lV/Re015bRii
         pLSZ6A3YdlVauxLvRMsd4ciGMTJgkIZMKQJMyMirsl/AMWcKufDhFEdXHcra1yE0H9mS
         uWdzQ4p/3Km96AmcsSIT5458BZIjHXrdie1s4TO9jxf9LMGME3/FPSJ2RMtQbzEt7D6K
         MkxrZlRrrAbMW2FhrPeYttnohQAo731WPvU8RofL19N23U7vIa+aAnDB824I2jK2WZgo
         hreg==
Received: by 10.216.142.102 with SMTP id h80mr188534wej.36.1339648566536;
        Wed, 13 Jun 2012 21:36:06 -0700 (PDT)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id fm1sm16310649wib.10.2012.06.13.21.36.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 21:36:05 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id C4AEB42E56A; Thu, 14 Jun 2012 04:35:21 +0000 (UTC)
In-Reply-To: <CA+-ctj5M4XraOQJfWRVVFmRrNsUZUJyt63_Oi__OJCcYMC=ciw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199966>

On Wed, 13 Jun 2012 21:16:21 -0400, Brendan Brewster <brendan.brewster@gmail.com> wrote:
> Hi,
> 
> The issue, in summary, is that 7-zip was unable to untar a tar created
> via a "git archive" whereas gnu tar can. It seem that it may be the
> case that git is incorrectly using signed values when creating the
> checksum.
> 
> Can someone please look into this and possibly redirect if needed?

That was reported a day ago and Junio already wrote a patch. See
http://article.gmane.org/gmane.comp.version-control.git/199911.

tom
